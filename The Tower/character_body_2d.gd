extends CharacterBody2D

@export var gravity: float = 900.0
@export var jump_force_multiplier: float = 4.0

# 🔥 bounce leve estilo Jump King
@export var wall_bounce_x: float = 120.0
@export var wall_bounce_y: float = 80.0
@export var ceiling_bounce: float = 120.0

@export var bounce_cooldown: float = 0.2
@export var launch_lock_time: float = 0.15

# SPRITE DE HIT
@export var hit_texture: Texture2D
@export var hit_duration: float = 0.1

var can_jump: bool = true
var bounce_timer: float = 0.0
var launch_timer: float = 0.0

var normal_texture: Texture2D
var hit_timer: float = 0.0

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D


func _ready() -> void:
	normal_texture = sprite.texture


func _physics_process(delta: float) -> void:

	# ======================
	# HIT SPRITE
	# ======================

	if hit_timer > 0:
		hit_timer -= delta

		if hit_timer <= 0:
			sprite.texture = normal_texture

	# ======================
	# GRAVIDADE
	# ======================

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if velocity.y >= 0:
			can_jump = true

		velocity.x = move_toward(velocity.x, 0, 1000 * delta)

	# ======================
	# TIMERS
	# ======================

	bounce_timer = max(bounce_timer - delta, 0)
	launch_timer = max(launch_timer - delta, 0)

	# ======================
	# ANIMAÇÕES
	# ======================

	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

	# NÃO toca animações enquanto mostra o hit
	if hit_timer <= 0:

		if not is_on_floor():
			anim.play("jump")

		elif abs(velocity.x) > 10:
			anim.play("run")

		else:
			anim.play("idle")

	# ======================
	# MOVIMENTO
	# ======================

	move_and_slide()

	# ======================
	# BLOQUEIOS
	# ======================

	if bounce_timer > 0 or launch_timer > 0:
		return

	# ======================
	# BOUNCE NA PAREDE
	# ======================

	if is_on_wall():

		mostrar_hit()

		var normal = get_wall_normal()

		var dir = sign(velocity.x)

		if dir == 0:
			dir = -normal.x

		velocity.x = -dir * wall_bounce_x
		velocity.y = -wall_bounce_y

		velocity *= 0.85

		bounce_timer = bounce_cooldown
		return

	# ======================
	# BOUNCE NO TETO
	# ======================

	if is_on_ceiling():

		mostrar_hit()

		velocity.y = ceiling_bounce

		velocity *= 0.85

		bounce_timer = bounce_cooldown
		return


func mostrar_hit() -> void:

	if hit_texture == null:
		return

	sprite.texture = hit_texture
	hit_timer = hit_duration


func launch(force: Vector2) -> void:

	if not is_on_floor():
		return

	if not can_jump:
		return

	velocity = force * jump_force_multiplier
	can_jump = false

	launch_timer = launch_lock_time
