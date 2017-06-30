extends Node

func _ready():
	set_process_input(true)
	
func _input(event):
	if Input.is_key_pressed(KEY_S):
		get_tree().change_scene("res://game/world/world-1.tscn")
