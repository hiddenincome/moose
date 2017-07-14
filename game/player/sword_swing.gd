extends Area2D

onready var animation = get_node("animatedsprite")

var my_master = ""

func _ready():
	animation.play()

func set_master(master):
	my_master = master

func flip(look_left):
	animation.set_flip_h(not look_left)


func _on_animatedsprite_finished():
	animation.stop()
	queue_free()

func _on_sword_swing_body_enter( body ):
	if body.get_name() != my_master:
		controller.player_hit(my_master, body.get_name())
		