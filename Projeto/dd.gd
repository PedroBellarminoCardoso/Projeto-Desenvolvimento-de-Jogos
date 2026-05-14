extends Label

func _ready():
	text = "──────── O PRIMEIRO ANDAR ───────"
	visible = true
	
	modulate = Color(1,1,1,0)

	# FADE IN (lento + travado)
	await fade_step(0.0, 1.0, 1.5)

	# espera
	await get_tree().create_timer(2.0).timeout

	# FADE OUT (lento + travado)
	await fade_step(1.0, 0.0, 1.5)

	visible = false


func fade_step(from: float, to: float, duration: float) -> void:
	var steps := 12 # 👈 menos = mais "lagado"
	var step_time := duration / steps

	for i in range(steps + 1):
		var t := float(i) / steps
		var value: float = lerp(from, to, t)

		modulate.a = value
		await get_tree().create_timer(step_time).timeout
