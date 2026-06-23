extends Area2D

@onready var victory_screen = $"../VictoryScreen"
@onready var victory_texture = $"../VictoryScreen/TextureRect"
@onready var victory_label = $"../VictoryScreen/TempoLabel"

var is_locked: bool = true

func _ready() -> void:
	pass

func liberar() -> void:
	is_locked = false
	var spr = get_node_or_null("Sprite2D")
	if spr:
		spr.texture = load("res://Pink.png")
		# Efeito visual de estouro/liberação
		var tween = create_tween()
		tween.tween_property(spr, "scale", spr.scale * 1.3, 0.15)
		tween.tween_property(spr, "scale", spr.scale, 0.15)

func _on_body_entered(body):
	if body.name != "Player":
		return

	if is_locked:
		return

	# Para o timer e obtém o tempo final
	var timer_label = get_node_or_null("../Tempo/Label")
	var final_time_str = ""
	if timer_label:
		timer_label.stop_timer()
		final_time_str = timer_label.text

	victory_screen.visible = true
	victory_texture.visible = true
	# Exibe apenas a string do tempo, pois a imagem de fundo já contém "SEU TEMPO FOI DE:"
	victory_label.text = final_time_str
	get_tree().paused = true
