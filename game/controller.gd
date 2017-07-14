extends Node

# Preload scenes
onready var player_scene = preload("res://game/player/player.tscn")
onready var world_1_scene = preload("res://game/world/world-1.tscn")
onready var world_2_scene = preload("res://game/world/world-2.tscn")
onready var player2_scene = preload("res://game/player/player_2.tscn")

var player = null
var player2 = null

func _ready():
	# Create the player instance that is shared between all worlds.
	player = player_scene.instance()
	player2 = player2_scene.instance()

func get_player(index):
	if index == 1:
		return player;
	else:
		return player2;

func get_world():
	return get_tree().get_current_scene()

func load_world(index):
	if index == 1:
		get_tree().change_scene_to(world_1_scene)
	elif index == 2:
		get_tree().change_scene_to(world_2_scene)

func new_game():
	load_world(1)

func player_hit(player_name):
	print("HIT ", player_name)
	if player_name == "player_1":
		player.you_got_hit()
	elif player_name == "player_2":
		player2.you_got_hit()