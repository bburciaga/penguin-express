extends Node2D

@export var spawns: Array[SpawnInfo] = []

@onready var player: Node = get_tree().get_first_node_in_group("Player")

var time: int = 0

func _on_timer_timeout():
	time += 1

	var enemy_spawns = spawns
	for i in enemy_spawns:
		if i.time_start <= time and i.time_end >= time:
			if i.spawn_delay_counter < i.entity_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = load(str(i.entity.resource_path))
				var counter = 0
				while counter < i.entity_num:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					owner.add_child(enemy_spawn)
					counter += 1

func get_random_position():
	var x = randf_range(10, get_viewport_rect().size.x - 10)
	
	return Vector2(x, 0)
