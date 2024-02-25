extends CharacterBody2D

const SPEED: float = 100.0
var ATTACK: Attack = Attack.new(1, self.global_position, 2.5)

@onready var player: Node2D = get_tree().get_first_node_in_group("Player")
@onready var state_machine: StateMachine = get_tree().get_first_node_in_group("StateMachine")
@onready var color_rect: Node = $"../ColorRect"
@onready var player_vars = get_node("/root/PlayerVariables")

func _physics_process(delta) -> void:
	if "Idle" == state_machine.current_state.name:
		return
	if global_position.y > 840:
		queue_free()
	if player:
		var direction: Vector2 = (player.global_position - self.global_position).normalized()
		velocity = Vector2(direction.x, 1) * SPEED
	
	if 1 > self.find_child("HealthComponent").health:
		player_vars.score += 5
		self.queue_free()
	
	move_and_slide()

func _on_area_entered(area: Area2D):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		if area.is_in_group("Player"):
			hitbox.damage(ATTACK)
