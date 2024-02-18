extends CharacterBody2D

const SPEED = 100.0

@onready var player: Node2D = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	if player:
		var direction = (player.global_position - self.global_position).normalized()
		velocity = Vector2(direction.x, 1) * SPEED

	move_and_slide()
