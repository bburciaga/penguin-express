class_name Snowball

extends Area2D

const SPEED: float = 150.0

var ATTACK: Attack = Attack.new(1, self.global_position, 2.5)

func _physics_process(delta):
	position += transform.x * SPEED * delta

func _on_area_entered(area: Area2D):
	var entity = area.get_parent()
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		if area.is_in_group("Enemy"):
			hitbox.damage(ATTACK)
			queue_free()
		if area.is_in_group("Projectile"):
			queue_free()
		if area.is_in_group("Object"):
			queue_free()

func _on_screen_exited():
	queue_free()
