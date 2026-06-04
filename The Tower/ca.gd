extends Camera2D

const SCREEN_SIZE: Vector2 = Vector2(320, 180)

var cur_screen: Vector2 = Vector2.ZERO


func _ready() -> void:
	top_level = true # substitui set_as_toplevel(true)
	global_position = get_parent().global_position
	_update_screen(cur_screen)


func _physics_process(delta: float) -> void:
	var parent_screen: Vector2 = (get_parent().global_position / SCREEN_SIZE).floor()

	if parent_screen != cur_screen:
		_update_screen(parent_screen)


func _update_screen(new_screen: Vector2) -> void:
	cur_screen = new_screen
	global_position = cur_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
