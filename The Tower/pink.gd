extends Area2D

@onready var victory_screen = $"../VictoryScreen"
@onready var victory_texture = $"../VictoryScreen/TextureRect"
@onready var victory_label = $"../VictoryScreen/TempoLabel"

func _on_body_entered(body):
	if body.name != "Player":
		return

	victory_screen.visible = true
	victory_texture.visible = true
	victory_label.text = "VOCÊ VENCEU!"
	get_tree().paused = true
