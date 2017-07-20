extends Node

onready var player_spawn_container = get_node("player_spawn_container")

var player_1 = null
var player_2 = null

func _ready():
	# Retrieve the player object from the controller
	player_1 = controller.get_player(1)
	player_2 = controller.get_player(2)
	
	# Add the player to this world and make it spawn at the 
	# right place
	respawn_player(1)
	respawn_player(2)

func respawn_player(index):
	var player
	if index == 1:
		player = player_1
	elif index == 2:
		player = player_2
	else:
		return
	
	player.respawn()
	add_child(player)
	var player_spawns = player_spawn_container.get_children()
	var player_spawn = player_spawns[randi() % player_spawns.size()];
	player.set_pos(player_spawn.get_pos())
		
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