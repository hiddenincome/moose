extends Area2D



func _ready():

	pass


func _on_powerup_body_enter( body ): 
	print(body.get_groups())
	queue_free()
	
	controller.player_power_up(body.get_name())

func _on_powerup_area_enter( area ):
	print("OOPS")
	queue_free()
