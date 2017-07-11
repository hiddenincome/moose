extends Area2D


onready var animation = get_node("animatedsprite")

func _ready():
	animation.play()

func flip(look_left):
	animation.set_flip_h(not look_left)


func _on_animatedsprite_finished():
	animation.stop()
	queue_free()







func _on_sword_swing_body_enter( body ):
	print(body.get_name())


	pass