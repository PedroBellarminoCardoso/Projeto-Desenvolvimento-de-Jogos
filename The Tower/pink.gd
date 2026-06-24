extends Area2D

@onready var victory_screen = $"../VictoryScreen"
@onready var victory_texture = $"../VictoryScreen/TextureRect"
@onready var victory_label = $"../VictoryScreen/TempoLabel"

var is_locked: bool = true
var anim_timer: float = 0.0
var anim_frame: int = 0
const FRAME_DURATION: float = 0.15

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not is_locked:
		var spr = get_node_or_null("Sprite2D")
		if spr and spr.hframes > 1:
			anim_timer += delta
			if anim_timer >= FRAME_DURATION:
				anim_timer = 0.0
				anim_frame = (anim_frame + 1) % spr.hframes
				spr.frame = anim_frame

func liberar() -> void:
	is_locked = false
	var spr = get_node_or_null("Sprite2D")
	if spr:
		spr.texture = load("res://Pink.png")
		spr.hframes = 4
		spr.vframes = 1
		spr.frame = 0
		spr.position.y += 28.0
		# Efeito visual de estouro/liberação
		var tween = create_tween()
		tween.tween_property(spr, "scale", spr.scale * 1.3, 0.15)
		tween.tween_property(spr, "scale", spr.scale, 0.15)

	# Modificações físicas devem ser adiadas em Godot se acionadas por um callback de física
	call_deferred("_ajustar_colisao_liberada")

func _ajustar_colisao_liberada() -> void:
	var col = get_node_or_null("CollisionShape2D")
	if col and col.shape is RectangleShape2D:
		col.shape = col.shape.duplicate()
		col.shape.size = Vector2(23.0, 15.0)
		col.position.y += 28.0

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
