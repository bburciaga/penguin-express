extends CharacterBody2D

const SPEED: float = 100.0

@onready var player: Node2D = get_tree().get_first_node_in_group("Player")
@onready var color_rect: Node = $"../ColorRect"

func _physics_process(delta) -> void:
	if global_position.y > 840:
		queue_free()
	if player:
		var direction: Vector2 = (player.global_position - self.global_position).normalized()
		velocity = Vector2(direction.x, 1) * SPEED

	move_and_slide()
