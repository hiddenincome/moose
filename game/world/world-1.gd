extends "res://game/world/world.gd"

onready var player_1_score = get_node("player_1_score")
onready var player_2_score = get_node("player_2_score")
onready var p_spawn = get_node("powerup_spawn")
onready var powerup = preload("res://game/item/powerup.tscn")


var next_world_index = 2

func _ready():
	print("Loaded World 1")


func _on_p_spawn_timeout():
	var fire = powerup.instance()
	add_child(fire)
	var spawn_points = p_spawn.get_children()
	var spawn_point = spawn_points[randi() % spawn_points.size()];	
	fire.set_pos(spawn_point.get_pos())
	

func update_score():
	player_1_score.set_text("%d" % player_1.get_score())
	player_2_score.set_text("%d" % player_2.get_score())
