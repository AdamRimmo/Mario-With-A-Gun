extends CharacterBody2D


const SPEED = 100.0
var direction:bool = true # true is right, false is left

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall():
		direction = not direction
	
	if direction:
		velocity.x = SPEED
	else:
		velocity.x = -SPEED
	
	move_and_slide()
