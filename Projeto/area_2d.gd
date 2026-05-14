extends Area2D

signal vector_created(vector)

@export var maximum_length: float = 200.0
@export var fade_time: float = 0.2

var touch_down: bool = false
var position_start: Vector2 = Vector2.ZERO
var position_end: Vector2 = Vector2.ZERO
var vector: Vector2 = Vector2.ZERO

var alpha: float = 1.0


func _draw() -> void:
	draw_line(
		Vector2.ZERO, # 👈 começa no player
		vector,
		Color(1, 1, 1, alpha),
		9.0
	)


func _input(event: InputEvent) -> void:
	# 🔥 clique começou
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = get_global_mouse_position()

	# 🔥 segurando
	if touch_down and event is InputEventMouseMotion:
		position_end = get_global_mouse_position()
		vector = -(position_end - position_start).limit_length(maximum_length)
		alpha = 1.0
		queue_redraw()

	# 🔥 soltou
	if touch_down and event.is_action_released("ui_touch"):
		touch_down = false

		if vector.length() > 10:
			emit_signal("vector_created", vector)

		fade_out()


func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(self, "alpha", 0.0, fade_time)

	await tween.finished
	_reset()


func _reset() -> void:
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	alpha = 1.0
	queue_redraw()
