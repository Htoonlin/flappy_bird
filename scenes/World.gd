extends Node2D

#Signals

#Nodes
onready var player = $Player
onready var hud = $HUD
onready var spawner = $WallSpawner

#Export variables

#Local variables
const SCORE_FILE_PATH = "user://highscore.save"
const PLAYER_Y_POS = 256
var score = 0 setget set_score
var highscore

func save_highscore():
	var file = File.new()
	file.open(SCORE_FILE_PATH, File.WRITE)
	file.store_var(highscore)
	file.close()
	
func load_highscore():
	var file = File.new()
	if file.file_exists(SCORE_FILE_PATH):
		file.open(SCORE_FILE_PATH, file.READ)
		highscore = file.get_var()
		file.close()
	else: 
		highscore = 0

func player_score():
	if(player.alive):
		self.score += 1
	
func set_score(new_score):
	score = new_score
	hud.update_score(new_score)

func new_game():
	self.score = 0
	spawner.start()
	hud.show_score()
	
func _ready():
	load_highscore()
	hud.hide_score()
	
func _on_wall_created(wall):
	wall.connect("get_score", self, "player_score")

func _on_Player_game_over():
	spawner.stop()
	player.position.y = PLAYER_Y_POS
	$Ground/AnimationPlayer.stop()
	get_tree().call_group("walls", "set_physics_process", false)
	if score > highscore:
		highscore = score
		save_highscore()
	print(highscore)
	$Menu.game_over(score, highscore)

func _on_ground_body_entered(body):
	if body is Player && body.has_method("die"):
		body.die()

func _on_Menu_start_game():
	new_game()
