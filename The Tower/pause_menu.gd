extends CanvasLayer

func _ready():
	visible = false

func _process(delta):
	var current_scene = get_tree().current_scene
	if current_scene and current_scene.name == "Menu":
		return
		
	if Input.is_action_just_pressed("ui_cancel"):
		if visible:
			resume()
		else:
			pause()

func pause():
	visible = true
	get_tree().paused = true

func resume():
	visible = false
	get_tree().paused = false

func _on_resume_button_pressed():
	resume()

func _on_menu_button_pressed():
	resume()
	get_tree().change_scene_to_file("res://menu.tscn")
