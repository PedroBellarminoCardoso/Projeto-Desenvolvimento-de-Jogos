extends Control

@onready var main_menu = $VBoxContainer
@onready var options_menu = $OptionsPanel

func _ready():
	main_menu.get_node("PlayButton").grab_focus()
	options_menu.hide()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://storyboard.tscn")

func _on_options_button_pressed():
	main_menu.hide()
	options_menu.show()
	options_menu.get_node("VBoxContainer/BackButton").grab_focus()

func _on_back_button_pressed():
	options_menu.hide()
	main_menu.show()
	main_menu.get_node("OptionsButton").grab_focus()

func _on_graphics_button_pressed():
	var btn = options_menu.get_node("VBoxContainer/GraphicsButton")
	if btn.text == "Graficos: ALTO":
		btn.text = "Graficos: BAIXO"
		# Logic to change to low graphics
	else:
		btn.text = "Graficos: ALTO"
		# Logic to change to high graphics

func _on_volume_slider_value_changed(value):
	# Logic to change volume based on value (0 to 100)
	var bus_idx = AudioServer.get_bus_index("Master")
	if value == 0:
		AudioServer.set_bus_mute(bus_idx, true)
	else:
		AudioServer.set_bus_mute(bus_idx, false)
		AudioServer.set_bus_volume_db(bus_idx, lerp(-40.0, 0.0, value / 100.0))

func _on_quit_button_pressed():
	get_tree().quit()
