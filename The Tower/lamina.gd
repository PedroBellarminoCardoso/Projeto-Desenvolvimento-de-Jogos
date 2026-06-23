extends Area2D

@export var knockback_y: float = 350.0  # Empurra para baixo para atrapalhar a subida
@export var knockback_x: float = 250.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		var dir = 1.0
		if body.global_position.x < global_position.x:
			dir = -1.0
		# Empurra o jogador com força e dá o efeito de dano
		body.take_damage(Vector2(dir * knockback_x, knockback_y))
