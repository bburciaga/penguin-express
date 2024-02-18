extends Area2D

@onready var weapon = $Sprite2D
@onready var color_rect = $"../ColorRect"

const SPEED = 200.0

func _physics_process(delta):
	position += Vector2(0, SPEED * delta)
	_check_bounds()
	
func _on_body_entered(body):
	if "Player" == body.name:
		queue_free()

func _check_bounds():
	var rect_position = color_rect.position
	var rect_size = color_rect.size
	if position.y < rect_position.y or position.y > rect_position.y + rect_size.y:
		self.queue_free()
