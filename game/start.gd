extends Node

func _ready():
	set_process_input(true)
	
func _input(event):
	randomize()
	
	if Input.is_key_pressed(KEY_S):
		controller.new_game()
