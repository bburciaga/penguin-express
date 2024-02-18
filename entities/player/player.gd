extends CharacterBody2D

@onready var SNOWBALL_PATH: Resource = preload("res://entities/projectiles/snowball.tscn")

var attack: Attack = Attack.new(1, self.global_position, 5)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta) -> void:
	move()
	shoot()

func move() -> void:
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * SPEED

	move_and_slide()

func shoot() -> void:
	if Input.is_action_just_released("action"):
		var instance: Snowball = SNOWBALL_PATH.instantiate()
		instance.transform = $CollisionShape2D.global_transform
		owner.add_child(instance)
	#	start_cooldown()

	pass
