extends CharacterBody2D

@onready var snowball_path: Resource = preload("res://entities/projectiles/snowball.tscn")

var attack: Attack = Attack.new(1, self.global_position, 5)
var can_shoot: bool = true

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_time_stopped = false
@onready var music_player = $StopTimeAudio

func _physics_process(delta) -> void:
	move()
	if !is_time_stopped:
		shoot()
	handle_time_stop()

func _on_projectile_timeout():
	can_shoot = true

func move() -> void:
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * SPEED

	move_and_slide()

func shoot() -> void:
	if Input.is_action_just_released("action") and can_shoot:
		var instance: Snowball = snowball_path.instantiate();
		instance.transform = $CollisionShape2D.global_transform
		owner.add_child(instance)
		can_shoot = false
		$Projectile.start()


func handle_time_stop() -> void:
	if Input.is_action_just_pressed("F"):
		if is_time_stopped:
			start_time()
		else:
			stop_time()

func stop_time() -> void:
	music_player.play()
	is_time_stopped = true
	for node in get_tree().get_nodes_in_group("Stoppable"):
		node.set_process(false)
		node.set_physics_process(false)

func start_time() -> void:
	is_time_stopped = false
	for node in get_tree().get_nodes_in_group("Stoppable"):
		node.set_process(true)
		node.set_physics_process(true)
