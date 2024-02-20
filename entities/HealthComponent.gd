class_name HealthComponent
extends Node2D

@export var MAX_HEALTH: float = 10.0
@onready var PLAYER: Node = get_node("/root/PlayerVariables")
var health: float
var lose_health_sound: AudioStream = preload("res://entities/assets/sounds/player/LoseHealth.wav")
var lose_game_sound: AudioStream = preload("res://entities/assets/sounds/player/LoseGame.wav")

func _ready() -> void:
	health = MAX_HEALTH

func _process(delta) -> void:
	game_over()

func damage (attack: Attack, activate: bool = false) -> void:
	health -= attack.damage
	
	var animation: AnimatedSprite2D = get_parent().get_node("AnimatedSprite2D")
	if health >= 1:
		$"../AudioStreamPlayer".stream = lose_health_sound
		$"../AudioStreamPlayer".play()
		#animation.play("Hurt")
		#await animation.animation_finished
		#animation.animation = "Idle"
	#else:
		#PLAYER.score += 5
		#animation.play("Death")
		#await animation.animation_finished
		#self.queue_free()
	if health <= 0:
		$"../AudioStreamPlayer".stream = lose_game_sound
		$"../AudioStreamPlayer".play()
		get_parent().queue_free()

func increase_health() -> void:
	health += 1;
	
func game_over() -> void:
	if "Player" == get_parent().name and 1 > health:
		get_tree().change_scene_to_file("res://menus/finish/Finish.tscn")
