class_name HitboxComponent
extends Area2D

@export var health_component: HealthComponent

func damage (attack: Attack, activate: bool = false) -> void:
	if health_component:
		health_component.damage(attack)
	
		var entity = get_parent()
		print(entity)
