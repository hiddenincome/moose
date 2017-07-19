extends Node

# Preload scenes
onready var player_scene = preload("res://game/player/player.tscn")
onready var world_1_scene = preload("res://game/world/world-1.tscn")
onready var world_2_scene = preload("res://game/world/world-2.tscn")
onready var player2_scene = preload("res://game/player/player_2.tscn")

var player = null
var player2 = null

var player_1_respawn_timer = null
var player_2_respawn_timer = null

func _ready():
	# Create the player instance that is shared between all worlds.
	player = player_scene.instance()
	player2 = player2_scene.instance()

	player_1_respawn_timer = Timer.new()
	player_2_respawn_timer = Timer.new()
	
	player_1_respawn_timer.set_one_shot(true)
	player_2_respawn_timer.set_one_shot(true)
		
	player_1_respawn_timer.set_wait_time(5.0)
	player_2_respawn_timer.set_wait_time(5.0)
		
	player_1_respawn_timer.connect("timeout", self, "_on_player_1_respawn_timeout")
	player_2_respawn_timer.connect("timeout", self, "_on_player_2_respawn_timeout")

	add_child(player_1_respawn_timer)
	add_child(player_2_respawn_timer)

func _on_player_1_respawn_timeout():
	print("PLAYER 1 RESPAWN")
	get_world().respawn_player(1)
	
func _on_player_2_respawn_timeout():
	print("PLAYER 2 RESPAWN")
	get_world().respawn_player(2)

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

func player_hit(attacker, victim):
	print(attacker, "HIT ", victim)
	if victim == "player_1":
		player.you_got_hit()
	elif victim == "player_2":
		player2.you_got_hit()
	if attacker == "player_1":
		player.you_hit()
	elif attacker == "player_2":
		player2.you_hit()
	get_world().update_score()
	
	if player.get_health() == 0:
		get_world().remove_player(1)
		player_1_respawn_timer.start()
	if player2.get_health() == 0:
		get_world().remove_player(2)
		player_2_respawn_timer.start()
		
func player_power_up(player_name):
	print("POWER-UP",player_name)
	if player_name == "player_1":
		player.you_powered_up()
	elif player_name == "player_2":
		player2.you_powered_up()

func respawn_player(player_name):
	print("Respawn player ", player_name)