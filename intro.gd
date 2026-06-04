extends Node2D

func _ready():
	# Fade da tela
	$ColorRect/AnimationPlayer.play("fade_in")
	await $ColorRect/AnimationPlayer.animation_finished

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
