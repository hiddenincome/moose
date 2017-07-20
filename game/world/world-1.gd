extends "res://game/world/world.gd"

onready var player_1_score = get_node("player_1_score")
onready var player_2_score = get_node("player_2_score")
onready var p_spawn = get_node("powerup_spawn")
onready var powerup = preload("res://game/item/powerup.tscn")
onready var active_powerup_container = get_node("powerup_container")


var next_world_index = 2

func _ready():
	print("Loaded World 1")

func _on_p_spawn_timeout():

	var spawn_points = p_spawn.get_children()
	var spawn_point = spawn_points[randi() % spawn_points.size()];	
	
	var found_one_in_the_way = false
	var active_powerups = active_powerup_container.get_children()
	
	for active_powerup in active_powerups:
		if spawn_point.get_pos() == active_powerup.get_pos():
			found_one_in_the_way = true
			break
	
	if not found_one_in_the_way:
		var fire = powerup.instance()
		active_powerup_container.add_child(fire)
		fire.set_pos(spawn_point.get_pos())
		
func update_score():
	player_1_score.set_text("%d %d%% %s" % [player_1.get_score(), player_1.get_health(), player_1.get_power_up_string()])
	player_2_score.set_text("%d %d%% %s" % [player_2.get_score(), player_2.get_health(), player_2.get_power_up_string()])
		