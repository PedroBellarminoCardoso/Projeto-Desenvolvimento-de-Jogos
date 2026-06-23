extends Control

@onready var texture_rect = $Panel/TextureRect
@onready var desc_label = $Panel/DescLabel
@onready var next_btn = $Panel/HBoxContainer/NextBtn
@onready var skip_btn = $Panel/HBoxContainer/SkipBtn

var current_slide: int = 0

var slides_textures = [
	preload("res://story_1_pink.jpg"),
	preload("res://story_2_vilao.jpg"),
	preload("res://story_3_jail.jpg"),
	preload("res://story_4_hero.jpg")
]

var slides_texts = [
	"Pink vivia feliz e tranquila brincando nos campos da colina...",
	"Ate que o terrivel Vilao apareceu das sombras com planos malignos!",
	"Ele capturou a Pink e a trancou em uma jaula no topo de sua enorme torre!",
	"Agora, voce precisa subir a torre e derrotar o vilao para salvar a sua amada!"
]

func _ready() -> void:
	# Programmatic connections to avoid signal connection issues in tscn
	next_btn.pressed.connect(_on_next_btn_pressed)
	skip_btn.pressed.connect(_on_skip_btn_pressed)
	
	update_slide()
	next_btn.grab_focus()

func update_slide() -> void:
	# Fade out content panel
	var tween = create_tween()
	tween.tween_property($Panel, "modulate:a", 0.0, 0.25)
	await tween.finished
	
	# Update contents
	texture_rect.texture = slides_textures[current_slide]
	desc_label.text = slides_texts[current_slide]
	
	if current_slide == slides_textures.size() - 1:
		next_btn.text = "JOGAR!"
		skip_btn.hide()
	else:
		next_btn.text = "AVANCAR"
		skip_btn.show()
		
	# Fade in content panel
	tween = create_tween()
	tween.tween_property($Panel, "modulate:a", 1.0, 0.25)

func _on_next_btn_pressed() -> void:
	if current_slide < slides_textures.size() - 1:
		current_slide += 1
		update_slide()
	else:
		start_game()

func _on_skip_btn_pressed() -> void:
	start_game()

func start_game() -> void:
	get_tree().change_scene_to_file("res://Teste.tscn")
