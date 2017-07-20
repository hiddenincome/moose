extends Area2D

onready var animation = get_node("animatedsprite")

var my_master = null
var power = 0

func _ready():
	animation.play()

func set_master(master):
	my_master = master
	
func set_power(new_power):
	power = new_power

func flip(look_left):
	animation.set_flip_h(not look_left)

func _on_animatedsprite_finished():
	animation.stop()
	queue_free()

func _on_sword_swing_body_enter(body):
	if body.get_name() != my_master.get_name() and body.get_name().find("player") == 0:
		body.you_got_hit(power)
		controller.update()
		