extends CharacterBody2D

const SPEED = 100.0

@onready var player: Node2D = get_tree().get_first_node_in_group("Player")
@onready var color_rect: Node = $"../ColorRect"

func _physics_process(delta):
	if global_position.y > 840:
		queue_free()
	if player:
		var direction = (player.global_position - self.global_position).normalized()
		velocity = Vector2(direction.x, 1) * SPEED

	move_and_slide()
	_check_bounds()
	
func _check_bounds() -> void:
	if position.y < color_rect.position.y or position.y > color_rect.position.y + color_rect.size.y:
		self.queue_free()
