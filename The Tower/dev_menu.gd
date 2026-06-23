extends CanvasLayer

@onready var player = $"../Player"

var is_flying: bool = false
var is_noclip: bool = false

@onready var fly_btn = $Panel/VBoxContainer/FlyBtn
@onready var noclip_btn = $Panel/VBoxContainer/NoclipBtn

func _ready() -> void:
	# Configura textos e conecta os sinais programaticamente
	if fly_btn:
		fly_btn.text = "Modo Voar: OFF"
		fly_btn.pressed.connect(_on_fly_btn_pressed)
	if noclip_btn:
		noclip_btn.text = "Sem Colisao: OFF"
		noclip_btn.pressed.connect(_on_noclip_btn_pressed)
	
	var tp_boss = get_node_or_null("Panel/VBoxContainer/TPBossBtn")
	if tp_boss:
		tp_boss.pressed.connect(_on_tp_boss_btn_pressed)
		
	var tp_start = get_node_or_null("Panel/VBoxContainer/TPStartBtn")
	if tp_start:
		tp_start.pressed.connect(_on_tp_start_btn_pressed)
		
	$Panel.visible = true

func _on_fly_btn_pressed() -> void:
	is_flying = not is_flying
	if fly_btn:
		fly_btn.text = "Modo Voar: ON" if is_flying else "Modo Voar: OFF"
	if player:
		player.is_flying_debug = is_flying
		if not is_flying:
			player.velocity = Vector2.ZERO

func _on_noclip_btn_pressed() -> void:
	is_noclip = not is_noclip
	if player:
		var col = player.get_node_or_null("CollisionShape2D")
		if col:
			col.disabled = is_noclip
	if noclip_btn:
		noclip_btn.text = "Sem Colisao: ON" if is_noclip else "Sem Colisao: OFF"

func _on_tp_boss_btn_pressed() -> void:
	if player:
		player.global_position = Vector2(640.0, -3450.0)
		player.velocity = Vector2.ZERO
		is_flying = false
		player.is_flying_debug = false
		if fly_btn:
			fly_btn.text = "Modo Voar: OFF"

func _on_tp_start_btn_pressed() -> void:
	if player:
		player.global_position = Vector2(454.0, 87.0)
		player.velocity = Vector2.ZERO
		is_flying = false
		player.is_flying_debug = false
		if fly_btn:
			fly_btn.text = "Modo Voar: OFF"
