extends Node2D

func _ready():
<<<<<<< HEAD
	$Player.visible = false

=======
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
	# Fade da tela
	$ColorRect/AnimationPlayer.play("fade_in")
	await $ColorRect/AnimationPlayer.animation_finished

<<<<<<< HEAD
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
=======
	# Remove a tela preta completamente
	$ColorRect.hide()

	# Abre a porta
	$Porta/AnimationPlayer.play("open")
	await $Porta/AnimationPlayer.animation_finished

	# Toca a animação do player
	$Player/AnimationPlayer.play("blue_fade_in")
	await $Player/AnimationPlayer.animation_finished

	# Garante que o player fique totalmente visível
	$Player.modulate = Color(1, 1, 1, 1)

	# Fecha a porta
	$Porta/AnimationPlayer.play("close")
>>>>>>> 51db95ade9a57f6ee1b64b3b05b3740763da2137
