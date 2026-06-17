extends Area2D

@export var target_camera: Camera2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		target_camera.make_current()
		
		
