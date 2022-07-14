extends CanvasLayer

signal start_game

onready var start_menu = $StartMenu
onready var game_over_menu = $GameOverMenu
onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
onready var high_score_label = $GameOverMenu/VBoxContainer/HighScoreLabel

var started = false

func game_over(score, highscore):
	score_label.text = "SCORE : %d" % score
	high_score_label.text = "BEST : %d" % highscore
	game_over_menu.show()

func _process(delta):
	if Input.is_action_just_pressed("fly") && !started:
		$Tween.interpolate_property(start_menu, "modulate:a", 1, 0, 0.5)
		$Tween.start()
		emit_signal("start_game")
		start_menu.hide()
		started = true

func _on_Restart_pressed():
	get_tree().reload_current_scene()
