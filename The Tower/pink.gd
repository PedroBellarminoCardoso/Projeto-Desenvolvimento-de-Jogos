extends Area2D

@onready var victory_screen = $"../VictoryScreen"
@onready var tempo_label = $"../Tempo/Label"
@onready var tempo_final = $"../VictoryScreen/TempoFinal"

func _on_body_entered(body):
	if body.name == "Player":
		victory_screen.visible = true
		tempo_final.text = "Tempo Final: " + tempo_label.text
		get_tree().paused = true
