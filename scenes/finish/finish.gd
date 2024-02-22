extends Node2D

func _ready():
	$GameOverAudio.play()
	
func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_quit_pressed():
	get_tree().quit()
