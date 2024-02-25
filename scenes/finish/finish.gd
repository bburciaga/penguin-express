extends Node2D

@onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	$CurrentScore.text = "Current Score " + str(player_vars.score)
	player_vars.best_score = max(player_vars.score, player_vars.best_score)
	$BestScore.text = "Best Score " + str(player_vars.best_score)
	
func _process(delta):
	if !$GameOverAudio.is_playing():
		$GameOverAudio.play()

func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_quit_pressed():
	get_tree().quit()
