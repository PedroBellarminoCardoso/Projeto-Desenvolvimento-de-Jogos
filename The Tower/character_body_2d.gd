extends CharacterBody2D

@export var gravity: float = 900.0
@export var jump_force_multiplier: float = 4.0

# Bounce leve estilo Jump King
@export var wall_bounce_x: float = 120.0
@export var wall_bounce_y: float = 80.0
@export var ceiling_bounce: float = 120.0

@export var bounce_cooldown: float = 0.2
@export var launch_lock_time: float = 0.15

# Sprite de hit
@export var hit_texture: Texture2D
@export var hit_duration: float = 0.1
@export var is_flying_debug: bool = false

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
	# Modo Voo para Debug/Testes
	if is_flying_debug:
		var fly_dir = Vector2.ZERO
		if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
			fly_dir.y -= 1
		if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
			fly_dir.y += 1
		if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
			fly_dir.x -= 1
		if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
			fly_dir.x += 1
		
		velocity = fly_dir.normalized() * 600.0
		move_and_slide()
		if hit_timer > 0:
			hit_timer = 0.0
			sprite.texture = normal_texture
		return

	# Sprite de hit
	if hit_timer > 0:
		hit_timer -= delta
		if hit_timer <= 0:
			sprite.texture = normal_texture

	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if velocity.y >= 0:
			can_jump = true
		# reduz deslize no chão
		velocity.x = move_toward(velocity.x, 0, 1000 * delta)

	# Timers
	bounce_timer = max(bounce_timer - delta, 0)
	launch_timer = max(launch_timer - delta, 0)

	# Animações
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

	if hit_timer <= 0:
		if not is_on_floor():
			if anim.has_animation("jump"):
				anim.play("jump")
			elif anim.has_animation("idle"):
				anim.play("idle")
		elif $Area2D.touch_down:
			if anim.has_animation("charge"):
				anim.play("charge")
			elif anim.has_animation("idle"):
				anim.play("idle")
		elif abs(velocity.x) > 10:
			if anim.has_animation("run"):
				anim.play("run")
			elif anim.has_animation("idle"):
				anim.play("idle")
		else:
			if anim.has_animation("idle"):
				anim.play("idle")

	# Movimento
	move_and_slide()

	# Bloqueios
	if bounce_timer > 0 or launch_timer > 0:
		return

	# Bounce na parede
	if is_on_wall():
		mostrar_hit()
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

	# Bounce no teto
	if is_on_ceiling():
		mostrar_hit()
		velocity.y = ceiling_bounce
		# deixa mais pesado
		velocity *= 0.85
		bounce_timer = bounce_cooldown
		return


func mostrar_hit() -> void:
	if hit_texture == null:
		return

	if anim:
		anim.stop()
	sprite.texture = hit_texture
	hit_timer = hit_duration


func launch(force: Vector2) -> void:
	if not is_on_floor():
		return

	if not can_jump:
		return

	velocity = force * jump_force_multiplier
	can_jump = false
	# evita bounce logo após pular
	launch_timer = launch_lock_time


func take_damage(knockback: Vector2) -> void:
	velocity = knockback
	mostrar_hit()

