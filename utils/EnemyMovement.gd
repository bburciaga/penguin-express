extends Area2D

var speed: float = 200.0
var direction: Vector2 = Vector2(1, 1)

@onready var color_rect: Node = $"../ColorRect"
@onready var player: Node = $"../Player"
	
func _physics_process(delta: float) -> void:
	var direction: Vector2 = (player.global_position - self.global_position).normalized()
	position += Vector2(direction.x, 1) * speed * delta
	_check_bounds()

func _check_bounds() -> void:
	if position.y < color_rect.position.y or position.y > color_rect.position.y + color_rect.size.y:
		self.queue_free()
