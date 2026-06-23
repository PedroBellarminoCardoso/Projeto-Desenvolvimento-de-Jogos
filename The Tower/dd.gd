extends Label

var floor_name: String = ""
var was_current: bool = false
var is_first_trigger: bool = true

func _ready() -> void:
	visible = false
	modulate = Color(1, 1, 1, 0)
	
	# Determina o nome do andar programaticamente baseado no nome do nó da câmera pai
	var camera = get_parent().get_parent()
	if camera:
		if camera.name == "Andar 1_1":
			floor_name = "O PRIMEIRO ANDAR"
		elif camera.name == "Andar1_2":
			floor_name = "O SEGUNDO ANDAR"
		elif camera.name == "Andar1_3":
			floor_name = "O TERCEIRO ANDAR"
		elif camera.name == "Andar1_4":
			floor_name = "O ULTIMO ANDAR"
		else:
			floor_name = "NOVO ANDAR"
			
		text = "──────── " + floor_name + " ───────"

func _process(delta: float) -> void:
	var camera = get_parent().get_parent() as Camera2D
	if camera:
		var is_curr = camera.is_current()
		if is_curr and not was_current:
			# Aciona a exibição do título somente quando a câmera de fato se torna a atual
			if camera.name == "Andar 1_1":
				if is_first_trigger:
					is_first_trigger = false
					# Primeiro andar espera a animação de abertura da porta terminar
					await get_tree().create_timer(1.2).timeout
					show_floor_title()
				else:
					show_floor_title()
			else:
				show_floor_title()
		was_current = is_curr

func show_floor_title() -> void:
	visible = true
	modulate.a = 0.0
	
	# FADE IN
	await fade_step(0.0, 1.0, 0.8)
	
	# Tempo visível
	await get_tree().create_timer(1.5).timeout
	
	# FADE OUT
	await fade_step(1.0, 0.0, 0.8)
	
	visible = false

func fade_step(from: float, to: float, duration: float) -> void:
	var steps := 10
	var step_time := duration / steps
	for i in range(steps + 1):
		var t := float(i) / steps
		modulate.a = lerp(from, to, t)
		await get_tree().create_timer(step_time).timeout
