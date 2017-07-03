extends Node

# Preload scenes
onready var player_scene = preload("res://game/player/player.tscn")
onready var world_1_scene = preload("res://game/world/world-1.tscn")
onready var world_2_scene = preload("res://game/world/world-2.tscn")

var player = null

func _ready():
	# Create the player instance that is shared between all worlds.
	player = player_scene.instance()

func get_player():
	return player
	
func get_world():
	return get_tree().get_current_scene()

func load_world(index):
	if index == 1:
		get_tree().change_scene_to(world_1_scene)
	elif index == 2:
		get_tree().change_scene_to(world_2_scene)

func new_game():
	load_world(1)
		