extends Area2D

func _ready():
	pass

func _on_powerup_body_enter(body): 
	if body.get_name().find("player") == 0:
		body.power_up("sword_strength", 10, 5)
	queue_free()
	controller.update()
	
func _on_powerup_area_enter( area ):
	print("OOPS")
	queue_free()
