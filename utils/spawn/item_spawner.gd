extends Node2D

@export var spawns: Array[SpawnInfo] = []

@onready var player: Node = get_tree().get_first_node_in_group("Player")
@onready var state_machine: Node = get_parent().find_child("StateMachine")
@onready var playerInfo: Node = $"../Player"
var time: int = 0

func _on_timer_timeout() -> void:
	if "Idle" == state_machine.current_state.name:
		return
	if playerInfo.is_time_stopped:
		return
		
	time += 1

	var item_spawns: Array[SpawnInfo] = spawns
	for i in item_spawns:
		#if i.time_start <= time and i.time_end >= time:
		if i.spawn_delay_counter < i.entity_spawn_delay:
			i.spawn_delay_counter += 1
		else:
			i.spawn_delay_counter = 0
			var new_item: PackedScene = load(str(i.entity.resource_path))
		#	var counter: int = 0
		#	while counter < i.entity_num:
			var item_spawn = new_item.instantiate()
			item_spawn.global_position = get_random_position()
			owner.add_child(item_spawn)
		#	counter += 1

func get_random_position() -> Vector2:
	var x: float = randf_range(10, get_viewport_rect().size.x - 10)
	
	return Vector2(x, 0)
