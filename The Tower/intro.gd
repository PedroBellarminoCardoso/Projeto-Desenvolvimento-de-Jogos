extends Node2D

func _ready():
	$Player.visible = false

	# Fade da tela
	$ColorRect/AnimationPlayer.play("fade_in")
	await $ColorRect/AnimationPlayer.animation_finished

	$ColorRect.hide()

	# Começa a animação da porta
	$Porta/AnimationPlayer.play("open")

	# Espera o momento em que a porta está aberta
	await get_tree().create_timer(0.5).timeout

	# Mostra o player
	$Player.visible = true


@onready var tela = $"../VictoryScreen"

func _on_pink_body_entered(body):
	var tela = get_tree().current_scene.find_child("VictoryScreen", true, false)

	print(tela)

	if tela:
		tela.visible = true
		print("TELA LIGADA")
