extends KinematicBody2D

const ACCELERATION = 1500
const MAX_VELOCITY = 500
const FRICTION = -1000

var acceleration = Vector2()
var velocity = Vector2()

func _ready():
	set_process(true)
	set_process_input(true)
	
func _process(delta):
	acceleration.y = 0
	acceleration.x = ACCELERATION * (Input.is_action_pressed("player_right") - 
		Input.is_action_pressed("player_left"))
	if acceleration.x == 0:
		acceleration.x = velocity.x * FRICTION * delta

	velocity += acceleration * delta
	velocity.x = clamp(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)

	move(velocity * delta)
	
	if is_colliding() and get_collider().get_name() == "exit_next_world":
		controller.get_world().goto_next_world()

	
