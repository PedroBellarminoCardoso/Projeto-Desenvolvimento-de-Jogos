extends Camera2D

@export var player: Node2D
@export var follow_speed: float = 5.0

var highest_y: float


func _ready():
	highest_y = global_position.y


func _process(delta):
	if player == null:
		return
	
	# se o player subiu mais que a câmera
	if player.global_position.y < highest_y:
		highest_y = player.global_position.y
	
	# move suavemente até o ponto mais alto alcançado
	global_position.y = lerp(global_position.y, highest_y, follow_speed * delta)
