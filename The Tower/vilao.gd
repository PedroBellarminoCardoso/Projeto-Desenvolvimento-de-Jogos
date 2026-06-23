extends CharacterBody2D

@export var speed: float = 120.0
@export var health: int = 3
@export var push_force: float = 350.0
@export var invincibility_time: float = 0.6

var direction: int = 1
var invincibility_timer: float = 0.0
var original_color: Color

@onready var sprite = $Sprite2D
@onready var pink_node = get_node_or_null("../Pink")

func _ready() -> void:
	if sprite:
		original_color = sprite.modulate
	else:
		original_color = Color(1, 1, 1, 1)
	
	if not pink_node:
		pink_node = get_parent().get_node_or_null("Pink")
		
	# Conecta o sinal da hurtbox programaticamente para simplificar o TSCN
	var hurtbox = get_node_or_null("Hurtbox")
	if hurtbox:
		hurtbox.body_entered.connect(_on_hurtbox_body_entered)

func _physics_process(delta: float) -> void:
	# Timers
	if invincibility_timer > 0:
		invincibility_timer -= delta
		# Pisca vermelho
		if sprite:
			if int(invincibility_timer * 12) % 2 == 0:
				sprite.modulate = Color(1, 0.2, 0.2, 1)
			else:
				sprite.modulate = original_color
			if invincibility_timer <= 0:
				sprite.modulate = original_color

	# Movimento horizontal básico (desativado para deixá-lo parado)
	velocity.y = 0
	velocity.x = 0
	move_and_slide()

func take_hit() -> void:
	if invincibility_timer > 0:
		return

	health -= 1
	invincibility_timer = invincibility_time

	# Repele o jogador ao bater no chefe (knockback para o lado e para cima)
	var player = get_parent().get_node_or_null("Player")
	if player:
		var dir = sign(player.global_position.x - global_position.x)
		if dir == 0: dir = 1
		# Lança o jogador para cima e para o lado oposto
		player.take_damage(Vector2(dir * push_force, -350.0))

	if health <= 0:
		die()

func die() -> void:
	if pink_node and pink_node.has_method("liberar"):
		pink_node.liberar()
	queue_free()

func _on_hurtbox_body_entered(body: Node) -> void:
	if body.name == "Player":
		take_hit()
