extends RigidBody2D

class_name Player

#Signals
signal game_over

#Export variables
export var FLAP_FORCE = -200

#UI variables
onready var animator = $AnimationPlayer

#Variables
var alive = true
var started = false
const MAX_ROTATION_DEGREES = -30.0

func _physics_process(delta):
	if Input.is_action_just_pressed("fly") && alive:
		if !started:
			start()
		fly()
	 
	if rotation_degrees	<= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES	
		
	if linear_velocity.y > 0:
		if rotation_degrees <= 80:
			angular_velocity = 3
		else:
			angular_velocity = 0
			

func start():
	if started: return
	started = true
	gravity_scale = 5.0
	animator.play("Fly")
	
func fly(): 
	linear_velocity.y = FLAP_FORCE
	angular_velocity = -8.0
	$FlyAudio.play()
	
func die():
	if !alive: return
	print("Die!")
	$DieAudio.play()
	alive = false
	animator.stop()
	emit_signal("game_over")
	
