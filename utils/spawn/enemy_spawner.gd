extends Node2D

@export var spawns: Array[SpawnInfo] = []

@onready var player: Node = get_tree().get_first_node_in_group("Player")
@onready var state_machine: StateMachine = get_parent().find_child("StateMachine")
@onready var playerInfo: Node = $"../Player"
var time: int = 0
var difficulty_level: int = 1

func _ready():
	$Diff.start()
	
func _on_timer_timeout() -> void:
	if "Idle" == state_machine.current_state.name:
		return
	if playerInfo.is_time_stopped:
		return
		
	#time += 1

	var enemy_spawns: Array[SpawnInfo] = spawns
	for i in enemy_spawns:
		#if i.time_start <= time and i.time_end >= time:
		if i.spawn_delay_counter < i.entity_spawn_delay:
			i.spawn_delay_counter += 1
		else:
			i.spawn_delay_counter = 0
			var new_enemy: PackedScene = load(str(i.entity.resource_path))
			#var counter: int = 0
			#while counter < i.entity_num:
			#print("Difficulty level increased to ", difficulty_level)
			for j in range(difficulty_level):
				var enemy_spawn = new_enemy.instantiate()
				enemy_spawn.global_position = get_random_position()
				owner.add_child(enemy_spawn)
			#counter += 1

func get_random_position() -> Vector2:
	var x: float = randf_range(10, get_viewport_rect().size.x - 10)
	
	return Vector2(x, 0)


func _on_diff_timeout():
	difficulty_level += 1
