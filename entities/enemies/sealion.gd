extends CharacterBody2D

const SPEED: float = 100.0
const MAX_Y: float = 840.0

@onready var player: Node2D = get_tree().get_first_node_in_group("Player")

func _physics_process(delta) -> void:
	if global_position.y > MAX_Y:
		queue_free()
	velocity = Vector2(0, 1) * SPEED
	move_and_slide()
