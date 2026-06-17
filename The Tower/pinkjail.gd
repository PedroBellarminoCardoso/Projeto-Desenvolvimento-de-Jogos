extends Area2D

@onready var timer = get_node("/root/Main/CanvasLayer/Tempo")
@onready var win_screen = get_node("/root/Main/CanvasLayer/WinScreen")
@onready var tempo_label = win_screen.get_node("TempoFinal")

func _on_body_entered(body):

	if body.name != "Player":
		return

	timer.stop_timer()

	var tempo = timer.format_time(timer.get_time())

	tempo_label.text = "Tempo Final: " + tempo

	win_screen.visible = true

	get_tree().paused = true
