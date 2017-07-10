extends KinematicBody2D

onready var sprite_2 = get_node("sprite_2")
onready var ground_ray2 = get_node("ground_ray2")


const ACCELERATION = 4000
const MAX_VELOCITY = 500
const FRICTION = -1000
const GRAVITY = 2600
const JUMP_SPEED = -800
const MIN_JUMP = -500
const MAX_ACCELERATION_AIR = 300

var acceleration = Vector2()
var velocity = Vector2()

func _ready():
	set_process(true)
	set_process_input(true)
	
	ground_ray2.add_exception(self)
	
	
func _process(delta):
	acceleration.y = GRAVITY
	
	acceleration.x = ACCELERATION * (Input.is_action_pressed("hoger") - 
		Input.is_action_pressed("vanster"))
	if velocity.x > 0: 
		sprite_2.set_flip_h(true)
	if velocity.x < 0:
		sprite_2.set_flip_h(false)

	if acceleration.x == 0:
		acceleration.x = velocity.x * FRICTION * delta
		
	velocity += acceleration * delta
	velocity.x = clamp(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
	
	var motion = move(velocity * delta)
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
		
	if abs(velocity.x) < 10:
		velocity.x = 0
	
	
	
