extends Node2D

var player_scene = load("res://characters/Player.tscn")

var intro_passed := false
var game_started := false
var game_over := false

func _ready() -> void:
	freeze_game()
	connect("resized", self, "call_wrap_around")
	
func freeze_game():
	$VirusSpawner/SpawnTimer.stop()
	$GUI/MarginContainer/HBoxContainer/VBoxContainer/Score.visible = false
	$Player.visible = false
	

func call_wrap_around():
	get_tree().call_group("wrap_around", "recalculate_wrap_area")

func _unhandled_input(event):
	if(game_over and event.is_action_released("restart_game")):
		_restart_game()
	elif(!intro_passed and event.is_action_released("ui_accept")):
		_show_intro()
	elif(!game_started and event.is_action_released("ui_accept")):
		_start_game()
		
func _show_intro():
	intro_passed = true
	$ThemeScreen.visible = false
	$IntroScreen.visible = true
		
func _start_game():
	game_started = true
	$IntroScreen.visible = false
	$Player.visible = true
	$GUI/MarginContainer/HBoxContainer/VBoxContainer/Score.visible = true
	$VirusSpawner.restart()
	
func _on_Player_player_died():
	$MusicPlayer.stop()
	$MusicPlayer.stream = load("res://assets/audio/music/sawsquarenoise_-_06_-_Towel_Defence_Jingle_Loose.ogg")
	$MusicPlayer.stream.loop = false
	$MusicPlayer.volume_db = -5
	
	$VirusSpawner/SpawnTimer.stop()
	
	for a in get_tree().get_nodes_in_group("viruses"):
		if(!a.is_queued_for_deletion() and a.has_node("AudioStreamPlayer2D")):
			a.get_node("AudioStreamPlayer2D").stop()
	
	$GameOverTimer.start()
	
func _on_GameOverTimer_timeout():
	$MusicPlayer.play(0)
	$GameOverLabel.visible = true
	game_over = true
		
func _restart_game():
	_undo_game_over()
	_respawn_player()
	$VirusSpawner.restart()
	$GUI/MarginContainer/HBoxContainer/VBoxContainer/Score.reset()
	game_over = false

func _undo_game_over():
	$GameOverLabel.visible = false
	$MusicPlayer.stop()
	$MusicPlayer.stream = load("res://assets/audio/music/sawsquarenoise_-_03_-_Towel_Defence_Ingame.ogg")
	$MusicPlayer.stream.loop = true
	$MusicPlayer.volume_db = -10
	$MusicPlayer.play(0)
	
func _respawn_player():
	var player = player_scene.instance()
	player.position = Vector2(626, 680)
	add_child(player)
