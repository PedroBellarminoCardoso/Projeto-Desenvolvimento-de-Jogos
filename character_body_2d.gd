extends CharacterBody2D

@export var gravity: float = 900.0
@export var jump_force_multiplier: float = 4.0

# 🔥 bounce leve estilo Jump King
@export var wall_bounce_x: float = 120.0
@export var wall_bounce_y: float = 80.0
@export var ceiling_bounce: float = 120.0

@export var bounce_cooldown: float = 0.2
@export var launch_lock_time: float = 0.15

var can_jump: bool = true
var bounce_timer: float = 0.0
var launch_timer: float = 0.0

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D


func _physics_process(delta: float) -> void:

	# ======================
	# GRAVIDADE
	# ======================

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if velocity.y >= 0:
			can_jump = true

		# reduz deslize no chão
		velocity.x = move_toward(velocity.x, 0, 1000 * delta)

	# ======================
	# TIMERS
	# ======================

	bounce_timer = max(bounce_timer - delta, 0)
	launch_timer = max(launch_timer - delta, 0)

	# ======================
	# ANIMAÇÕES
	# ======================

	# vira sprite
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

	# animações
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

		var normal = get_wall_normal()

		var dir = sign(velocity.x)

		if dir == 0:
			dir = -normal.x

		velocity.x = -dir * wall_bounce_x
		velocity.y = -wall_bounce_y

		# deixa mais pesado
		velocity *= 0.85

		bounce_timer = bounce_cooldown
		return

	# ======================
	# BOUNCE NO TETO
	# ======================

	if is_on_ceiling():

		velocity.y = ceiling_bounce

		# deixa mais pesado
		velocity *= 0.85

		bounce_timer = bounce_cooldown
		return


func launch(force: Vector2) -> void:

	if not is_on_floor():
		return

	if not can_jump:
		return

	velocity = force * jump_force_multiplier
	can_jump = false

	# evita bounce logo após pular
	launch_timer = launch_lock_time
