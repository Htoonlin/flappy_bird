extends Node2D

class_name Wall

signal get_score

export var speed = 100
 
func _physics_process(delta):
	position.x -= speed * delta
	if global_position.x <= -30:
		queue_free()
 

func _on_ScoreArea_body_exited(body):
	if body is Player:
		$ScoreAudio.play()
		emit_signal("get_score")


func _on_hit_the_pipe(body):
	if body is Player && body.has_method("die"):
		$HitAudio.play()
		body.die()
