extends Node2D

signal wall_created(wall)

export(PackedScene) var Wall

onready var _timer = $Timer

func _ready():
	randomize()

func _on_Timer_timeout():
	spawn_pipe()

func spawn_pipe():
	var wall = Wall.instance()
	wall.position.y = randi() % 200 + 100
	add_child(wall)
	emit_signal("wall_created", wall)

func start():
	_timer.start()

func stop():
	_timer.stop()
