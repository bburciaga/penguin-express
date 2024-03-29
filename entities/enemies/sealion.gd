extends CharacterBody2D

const SPEED: float = 100.0
const MAX_Y: float = 840.0
var ATTACK: Attack = Attack.new(1, self.global_position, 2.5)

@onready var player: Node2D = get_tree().get_first_node_in_group("Player")
@onready var state_machine: StateMachine = get_tree().get_first_node_in_group("StateMachine")
@onready var icicle_path: Resource = preload("res://entities/projectiles/icicle.tscn")
@onready var player_vars = get_node("/root/PlayerVariables")

var can_shoot: bool = true

func _physics_process(delta) -> void:
	if "Idle" == state_machine.current_state.name:
		return
	if global_position.y > MAX_Y:
		queue_free()
	velocity = Vector2(0, 1) * SPEED
	shoot()
	
	if 1 > self.find_child("HealthComponent").health:
		player_vars.score += 5
		self.queue_free()
	move_and_slide()

func shoot() -> void:
	if can_shoot:
		var instance: Area2D = icicle_path.instantiate();
		instance.transform = $CollisionShape2D.global_transform
		var direction: Vector2 = (player.global_position - instance.global_position).normalized()
		get_parent().add_child(instance)
		can_shoot = false
		$Projectile.start()

func _on_projectile_timeout():
	can_shoot = true

func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		if area.is_in_group("Player"):
			hitbox.damage(ATTACK)
