extends Area2D

@onready var timer = get_node("../CanvasLayer/Tempo")
@onready var tela_vitoria = get_node("../CanvasLayer/TelaVitoria")
@onready var tempo_final = tela_vitoria.get_node("TempoFinal")

func _on_body_entered(body):

	if body.name != "Player":
		return

	# para o cronômetro
	timer.stop_timer()

	# mostra o tempo final
	tempo_final.text = "Tempo: " + timer.text

	# mostra tela de vitória
	tela_vitoria.visible = true

	# pausa o jogo
	get_tree().paused = true
