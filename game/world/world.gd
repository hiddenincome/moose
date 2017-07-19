extends Node

var player_1 = null
var player_2 = null

func _ready():
	# Retrieve the player object from the controller
	player_1 = controller.get_player(1)
	player_2 = controller.get_player(2)
	
	# Add the player to this world and make it spawn at the 
	# right place
	add_child(player_1)
	player_1.set_pos(get_node("player_spawn").get_pos())

	add_child(player_2)
	player_2.set_pos(get_node("player2_spawn").get_pos())
	
func respawn_player(index):
	if index == 1:
		player_1.respawn()
		add_child(player_1)
		player_1.set_pos(get_node("player_spawn").get_pos())
	elif index == 2:
		player_2.respawn()
		add_child(player_2)
		player_2.set_pos(get_node("player2_spawn").get_pos())
		
func remove_player(index):
	if index == 1:
		remove_child(player_1)
	elif index == 2:
		remove_child(player_2)

func goto_next_world():
	# Remove player from scene tree to prevent it from 
	# being deleted when we change scene
	remove_child(player_1)
	remove_child(player_2)
	
	controller.load_world(self.next_world_index)