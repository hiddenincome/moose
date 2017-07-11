extends KinematicBody2D


onready var left_wall_ray2 = get_node("left_wall_ray2")
onready var ground_ray2 = get_node("ground_ray2")
onready var sprite_2 = get_node("sprite_2")
onready var right_wall_ray2 = get_node("right_wall_ray2")
onready var player_1 = get_node("player")

const ACCELERATION = 4000
const MAX_VELOCITY = 500
const FRICTION = -4500
const GRAVITY = 2600
const JUMP_SPEED = -800
const MIN_JUMP = -500
const MAX_ACCELERATION_AIR = 300

var acceleration = Vector2()
var velocity = Vector2()
var walljumpi_left = true 
var walljumpi_right = true

func _ready():
	set_process(true)
	set_process_input(true)
	
	add_collision_exception_with(player_1)
	right_wall_ray2.add_exception(self)
	left_wall_ray2.add_exception(self)
	ground_ray2.add_exception(self)
	
func _input(event):
	if event.is_action_pressed("player2_up") and ground_ray2.is_colliding():
		velocity.y = JUMP_SPEED
	if event.is_action_released("player2_up"):
		if velocity.y < MIN_JUMP:
			velocity.y = MIN_JUMP
	if event.is_action_pressed("player2_up") and right_wall_ray2.is_colliding() and walljumpi_right:
		walljumpi_right = false
		walljumpi_left = true
		velocity.y = JUMP_SPEED
		velocity.x = JUMP_SPEED
	if event.is_action_pressed("player2_up") and left_wall_ray2.is_colliding() and walljumpi_left:
		walljumpi_left = false
		walljumpi_right = true
		velocity.y = JUMP_SPEED
		velocity.x = -JUMP_SPEED


func _process(delta):
	# Constant acceleration downward = gravity!
	acceleration.y = GRAVITY
	
	# Accelerate left or right dependin.g on user input.
	acceleration.x = ACCELERATION * (Input.is_action_pressed("player2_right") - 
		Input.is_action_pressed("player2_left"))
	if velocity.x > 0: 
		sprite_2.set_flip_h(false)
	if velocity.x < 0:
		sprite_2.set_flip_h(true)
	
	# Don't break immediately when the player releases the right/left key, 
	# use friction to stop.
	if acceleration.x == 0:
		acceleration.x = velocity.x * FRICTION * delta

	# Change velocity depending on acceleration (clamp it to 
	# prevent palyer from reaching infinite speed).
	velocity += acceleration * delta
	velocity.x = clamp(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)

	# Move! The motion variable will hold any remaing motion 
	# that was prevented because of collisions.
	var motion = move(velocity * delta)
	if is_colliding():
		# If we are colliding retain the motion and velocity perpendicular 
		# to the collision (i.e. slide along the surface).
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
		
	# If we are moving really slow - stop!
	if abs(velocity.x) < 10:
		velocity.x = 0
	
	# Check for collision with portal.
	if is_colliding() and get_collider().get_name() == "exit_next_world":
		controller.get_world().goto_next_world()
	
	if ground_ray2.is_colliding():
		walljumpi_left = true
		walljumpi_right = true
	
	 #print("C ", ground_ray2.is_colliding(), " ", right_wall_ray2.is_colliding())

	
