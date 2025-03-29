extends CharacterBody2D


const DEFAULT_SPEED:float = 600.0
const JUMP_VELOCITY:float = -650.0
const FALL_VELOCITY:float = 1600.0
var sprint_multiplier:float = 1.5
var jump_count:float = 2
var respawn_point:Vector2 = Vector2(0, -270)
var speed = float(DEFAULT_SPEED)
var world_end:bool

func _ready() -> void:
	world_end = false

func _physics_process(delta: float) -> void:
	
# Reset Jump count and apply gravity
	if is_on_floor():
		jump_count = 2
	else:
		velocity += get_gravity() * delta
	
	if !world_end:
# Respawn
		if Input.is_action_just_pressed("Respawn"):
			position = respawn_point
			velocity.x = 0
			velocity.y = 0
			
			
	# Fastfall
		if not is_on_floor() and Input.is_action_pressed("Fall"):
			velocity.y += FALL_VELOCITY*delta

	# Jump
		if Input.is_action_just_pressed("Jump") and (is_on_floor() or (jump_count > 0)):
			jump_count -= 1
			velocity.y = JUMP_VELOCITY

		if Input.is_action_pressed("Run"):
			speed = sprint_multiplier*DEFAULT_SPEED
		if Input.is_action_just_released("Run"):
			speed = DEFAULT_SPEED

	# Movement
		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	else:
		velocity *= 0.5
	if Input.is_action_just_pressed("Debug 1"):
		print("debugged")
		world_end = false
	
	move_and_slide()


func _on_finish_body_entered(_body: Node2D):
	print_debug("World Complete")
	world_end = true
