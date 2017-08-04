extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _on_powerup_body_enter(body) :
	print(body.get_groups())
	queue_free()
	
	controller.player_power_up(body.get_name())