extends Node

var player = null

func _ready():
	# Retrieve the player object from the controller
	player = controller.get_player()
	
	# Add the player to this world and make it spawn at the 
	# right place
	add_child(player)
	player.set_pos(get_node("player_spawn").get_pos())
	
func goto_next_world():
	# Remove player from scene tree to prevent it from 
	# being deleted when we change scene
	remove_child(player)
	
	controller.load_world(self.next_world_index)