extends Node2D

@onready var player = $Player
@onready var color_rect = $ColorRect
@onready var color_animation = $ColorRect/AnimationPlayer
@onready var door_animation = $Porta/AnimationPlayer

func log_debug(msg: String) -> void:
	print(msg)
	var file = FileAccess.open("res://intro_debug.txt", FileAccess.READ_WRITE)
	if not file:
		file = FileAccess.open("res://intro_debug.txt", FileAccess.WRITE)
	if file:
		file.seek_end()
		file.store_line(msg)
		file.close()

func _ready() -> void:
	# Fresh log file
	var file = FileAccess.open("res://intro_debug.txt", FileAccess.WRITE)
	if file:
		file.store_line("=== INTRO DEBUG START ===")
		file.close()

	log_debug("=== INTRO READY STARTED ===")
	log_debug("Door AnimationPlayer animations: " + str(door_animation.get_animation_list()))
	if player.has_node("AnimationPlayer"):
		log_debug("Player AnimationPlayer animations: " + str(player.get_node("AnimationPlayer").get_animation_list()))
	$"Andar 1_1".make_current()
	player.position = Vector2(454, 87)
	player.visible = false
	player.modulate = Color(1, 1, 1, 1)

	# Certifica que a tela preta está visível para fazer o fade
	color_rect.visible = true
	color_rect.color = Color(0, 0, 0, 1)

	# Fade da tela
	log_debug("Playing fade_in...")
	color_animation.play("fade_in")
	log_debug("Waiting for fade_in...")
	await color_animation.animation_finished
	log_debug("fade_in finished!")

	# Remove a tela preta completamente
	color_rect.hide()

	# Abre a porta e espera um tempo fixo antes de mostrar o player
	log_debug("Playing door open...")
	door_animation.play("open")
	await get_tree().create_timer(0.6).timeout

	log_debug("Showing player...")
	player.visible = true
	player.modulate = Color(1, 1, 1, 1)

	# Print debug info
	log_debug("--- PLAYER DEBUG ---")
	log_debug("Player visible: " + str(player.visible))
	log_debug("Player position: " + str(player.position))
	log_debug("Player global_position: " + str(player.global_position))
	log_debug("Player modulate: " + str(player.modulate))
	var sprite = player.get_node("Sprite2D")
	log_debug("Sprite visible: " + str(sprite.visible))
	log_debug("Sprite position: " + str(sprite.position))
	log_debug("Sprite global_position: " + str(sprite.global_position))
	log_debug("Sprite scale: " + str(sprite.scale))
	log_debug("Sprite modulate: " + str(sprite.modulate))
	log_debug("Sprite texture: " + str(sprite.texture))
	if sprite.texture:
		log_debug("Sprite texture size: " + str(sprite.texture.get_size()))
	log_debug("--------------------")

	# Fecha a porta depois da entrada
	await get_tree().create_timer(0.6).timeout
	log_debug("Playing door close...")
	door_animation.play("close")
	log_debug("=== INTRO READY FINISHED ===")
	if DisplayServer.get_name() == "headless":
		get_tree().quit()


