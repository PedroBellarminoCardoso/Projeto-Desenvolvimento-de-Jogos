extends CharacterBody2D

@export var speed: float = 120.0
@export var push_force: float = 500.0

var direction: int = 1


func _physics_process(delta: float) -> void:
	# 🚫 sem gravidade (flutuando)
	velocity.y = 0
	
	# movimento lateral
	velocity.x = direction * speed

	move_and_slide()

	# 🔁 vira ao bater na parede
	if is_on_wall():
		direction *= -1

	# 💥 empurrar player ao colidir
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body is CharacterBody2D and body != self:
			var normal = collision.get_normal()
			body.velocity += -normal * push_force
