extends Area2D

var speed = 100
var direction = Vector2(-0.5, 1)

var color_rect = null

func _ready():
	color_rect = $"../ColorRect"

func _physics_process(delta):
	position += direction.normalized() * speed * delta
	_check_bounds()

func _check_bounds():
	if color_rect != null:
		var rect_position = color_rect.position
		var rect_size = color_rect.size
		if position.x < rect_position.x or position.x > rect_position.x + rect_size.x:
			direction.x = -direction.x
		if position.y < rect_position.y or position.y > rect_position.y + rect_size.y:
			self.queue_free()
