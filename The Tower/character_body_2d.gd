extends CharacterBody2D

@export var gravity: float = 900.0
@export var jump_force_multiplier: float = 4.0

# 🔥 bounce leve estilo Jump King
@export var wall_bounce_x: float = 120.0
@export var wall_bounce_y: float = 80.0
@export var ceiling_bounce: float = 120.0

@export var bounce_cooldown: float = 0.2
@export var launch_lock_time: float = 0.15

<<<<<<< HEAD
# SPRITE DE HIT
@export var hit_texture: Texture2D
@export var hit_duration: float = 0.1

=======
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
var can_jump: bool = true
var bounce_timer: float = 0.0
var launch_timer: float = 0.0

<<<<<<< HEAD
var normal_texture: Texture2D
var hit_timer: float = 0.0

=======
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D


<<<<<<< HEAD
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
=======
func _physics_process(delta: float) -> void:

	# ======================
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
	# GRAVIDADE
	# ======================

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if velocity.y >= 0:
			can_jump = true

<<<<<<< HEAD
=======
		# reduz deslize no chão
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
		velocity.x = move_toward(velocity.x, 0, 1000 * delta)

	# ======================
	# TIMERS
	# ======================

	bounce_timer = max(bounce_timer - delta, 0)
	launch_timer = max(launch_timer - delta, 0)

	# ======================
	# ANIMAÇÕES
	# ======================

<<<<<<< HEAD
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
=======
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
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137

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

<<<<<<< HEAD
		mostrar_hit()

=======
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
		var normal = get_wall_normal()

		var dir = sign(velocity.x)

		if dir == 0:
			dir = -normal.x

		velocity.x = -dir * wall_bounce_x
		velocity.y = -wall_bounce_y

<<<<<<< HEAD
=======
		# deixa mais pesado
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
		velocity *= 0.85

		bounce_timer = bounce_cooldown
		return

	# ======================
	# BOUNCE NO TETO
	# ======================

	if is_on_ceiling():

<<<<<<< HEAD
		mostrar_hit()

		velocity.y = ceiling_bounce

=======
		velocity.y = ceiling_bounce

		# deixa mais pesado
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
		velocity *= 0.85

		bounce_timer = bounce_cooldown
		return


<<<<<<< HEAD
func mostrar_hit() -> void:

	if hit_texture == null:
		return

	sprite.texture = hit_texture
	hit_timer = hit_duration


=======
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
func launch(force: Vector2) -> void:

	if not is_on_floor():
		return

	if not can_jump:
		return

	velocity = force * jump_force_multiplier
	can_jump = false

<<<<<<< HEAD
=======
	# evita bounce logo após pular
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
	launch_timer = launch_lock_time
