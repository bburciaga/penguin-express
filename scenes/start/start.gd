extends Node2D

func _ready():
	$GameStartAudio.play()
	
func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_quit_game_pressed():
	get_tree().quit()
