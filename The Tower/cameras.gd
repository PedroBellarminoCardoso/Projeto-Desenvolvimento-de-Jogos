extends Camera2D

@export var speed: float = 5.0

var target_position: Vector2
var moving: bool = false


func _ready() -> void:
	target_position = global_position


func _process(delta: float) -> void:
	if moving:
		global_position = global_position.lerp(target_position, speed * delta)

		if global_position.distance_to(target_position) < 1.0:
			global_position = target_position
			moving = false


func go_to(pos: Vector2) -> void:
	target_position = pos
	moving = true
