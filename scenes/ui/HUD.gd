extends CanvasLayer

onready var score_label = $Score

func update_score(score):
	score_label.text = str(score)
	
func hide_score():
	$Tween.interpolate_property(score_label, "modulate:a", 1, 0, 1)
	$Tween.start()
	score_label.hide()

func show_score():
	score_label.show()
	$Tween.interpolate_property(score_label, "modulate:a", 0, 1, 1)
	$Tween.start()
