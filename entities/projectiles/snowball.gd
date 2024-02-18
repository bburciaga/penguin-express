class_name Snowball

extends Area2D

const SPEED: float = -150.0

var ATTACK: Attack = Attack.new(1, self.global_position, 2.5)

func _physics_process(delta):
	position += transform.y * SPEED * delta

func _on_area_entered(area: Area2D):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		if area.is_in_group("Enemy"):
			hitbox.damage(ATTACK)
		if not area.is_in_group("Player"):
			queue_free()

func _on_screen_exited():
	queue_free()
