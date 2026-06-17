extends Area2D

@onready var victory_screen = $"../VictoryScreen"
@onready var tempo_label = $"../Tempo/Label"
@onready var resultado_label = $"../VictoryScreen/TempoLabel"

func _on_body_entered(body):
	if body.name == "Player":
		victory_screen.visible = true
		resultado_label.text = "Tempo Final: " + tempo_label.text
		get_tree().paused = true
