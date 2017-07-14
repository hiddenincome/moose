extends Area2D



func _ready():

	pass


func _on_powerup_body_enter( body ): 
	print(body.get_groups())
