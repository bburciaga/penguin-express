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
	print(get_parent().name, ' is damaged')
	health -= attack.damage

func increase_health() -> void:
	health += 1;
	
func game_over() -> void:
	if "Player" == get_parent().name and 1 > health:
		$"../AudioStreamPlayer".stream = lose_game_sound
		$"../AudioStreamPlayer".play()
		get_tree().change_scene_to_file("res://scenes/finish/finish.tscn")
