extends Area2D

var speed = 200
var direction = Vector2(1, 1)

var color_rect = null
var player = null

func _ready():
	color_rect = $"../ColorRect"
	player = $"../CharacterBody2D"
	
func _physics_process(delta):
	if player != null:
		var distance_to_player = position.distance_to(player.position)
		if distance_to_player < 100:
			var x_direction = 0
			if player.position.x - position.x != 0:
				x_direction = (player.position.x - position.x) / abs(player.position.x - position.x)
			direction = Vector2(x_direction, 1)
		else:
			direction = (player.position - position).normalized()
	position += direction * speed * delta
	_check_bounds()

func _check_bounds():
	if color_rect != null:
		var rect_position = color_rect.position
		var rect_size = color_rect.size
		if position.x < rect_position.x or position.x > rect_position.x + rect_size.x:
			direction.x = -direction.x
		if position.y < rect_position.y or position.y > rect_position.y + rect_size.y:
			self.queue_free()
