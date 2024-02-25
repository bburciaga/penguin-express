extends CharacterBody2D

@onready var state_machine: StateMachine = get_parent().find_child("StateMachine")
@onready var snowball_path: Resource = preload("res://entities/projectiles/snowball.tscn")
@onready var shield: Sprite2D  = $Shield
@onready var health_component: HealthComponent = $HealthComponent

var shoot_sound: AudioStream = preload("res://entities/assets/sounds/player/Shoot.wav")
#var stop_time_sound: AudioStream = preload("res://entities/assets/sounds/za-warudo.mp3")

enum PowerupState {
	INACTIVE,
  	SHIELD,
	CLONE
}

var attack: Attack = Attack.new(1, self.global_position, 5)
var can_shoot: bool = true

const SPEED: float = 300.0
var powerupState: PowerupState = PowerupState.INACTIVE

var is_time_stopped: bool = false
var clones: Array = []

func _physics_process(delta) -> void:
	if "Idle" == state_machine.current_state.name:
		return
	move()
	shoot()
	handle_time_stop()

func _on_projectile_timeout() -> void:
	can_shoot = true

func move() -> void:
	var direction: float = Input.get_axis("left", "right")
	velocity.x = direction * SPEED

	move_and_slide()

func shoot() -> void:
	if !is_time_stopped:
		if Input.is_action_just_released("action") and can_shoot:
			var instance: Snowball = snowball_path.instantiate();
			instance.transform = $CollisionShape2D.global_transform
			get_parent().add_child(instance)
			can_shoot = false
			$Projectile.start()
			$AudioStreamPlayer.stream = shoot_sound
			$AudioStreamPlayer.play()

func handle_time_stop() -> void:
	if Input.is_action_just_pressed("F"):
		if is_time_stopped:
			start_time()
		else:
			stop_time()

func stop_time() -> void:
	is_time_stopped = true
	for node in get_tree().get_nodes_in_group("Stoppable"):
		node.set_process(false)
		node.set_physics_process(false)
#	$AudioStreamPlayer.stream = stop_time_sound
#	$AudioStreamPlayer.play()

func start_time() -> void:
	is_time_stopped = false
	for node in get_tree().get_nodes_in_group("Stoppable"):
		node.set_process(true)
		node.set_physics_process(true)

func activate_powerup() -> void:
	var powerups = ["SHIELD", "CLONE"]
	var random_index = randi() % powerups.size()
	var powerup = powerups[random_index]
	match powerup:
		"SHIELD":
			powerupState = PowerupState.SHIELD
			shield.visible = true
			health_component.increase_health()
			$Powerup.start()
		"CLONE":
			activate_clone_powerup()

func _on_powerup_timeout() -> void:
	powerupState = PowerupState.INACTIVE
	shield.visible = false
	for clone in clones:
		if clone:
			clone.queue_free()
	clones = []

func activate_clone_powerup() -> void:
	powerupState = PowerupState.CLONE

	var clone_left: Node = self.duplicate()
	clone_left.global_position = self.global_position + Vector2(-55, 0)
	clone_left.scale = Vector2(0.5, 0.5)
	get_parent().add_child(clone_left)
	clones.append(clone_left)

	var clone_right: Node = self.duplicate()
	clone_right.global_position = self.global_position + Vector2(55, 0)
	clone_right.scale = Vector2(0.5, 0.5)
	get_parent().add_child(clone_right)
	clones.append(clone_right)
	$Powerup.start()
