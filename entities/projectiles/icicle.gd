extends Area2D

const SPEED: float = 150.0
const MAX_Y: float = 840.0

var ATTACK: Attack = Attack.new(1, self.global_position, 2.5)

func _physics_process(delta) -> void:
	if global_position.y > MAX_Y:
		queue_free()
	position += transform.y * SPEED * delta

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		if area.is_in_group("Player"):
			hitbox.damage(ATTACK)
			queue_free()
