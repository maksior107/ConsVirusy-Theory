extends Node

var virus_scene = load("res://objects/Virus.tscn")

var virus_spawn_interval := 2.0
var difficulty_index := 1.5

func _spawn_virus():
	var virus = virus_scene.instance()
	
	_set_virus_position(virus)
	_set_virus_trajectory(virus)
	
	add_child(virus)

func _on_SpawnTimer_timeout():
	_spawn_virus()

func _set_virus_position(virus):
	var rect = get_viewport().size
	virus.position = Vector2(rand_range(0, rect.x), -100) 

func _set_virus_trajectory(virus):
	virus.angular_velocity = rand_range(-4, 4) # random spin
	virus.angular_damp = 0 # slowing spin (angular velocity)
	virus.linear_velocity = Vector2(rand_range(-300, 300), 300) # random direction
	virus.linear_damp = 0


func _on_DifficultyTimer_timeout():
	$SpawnTimer.wait_time = float(virus_spawn_interval) / float(difficulty_index)
	difficulty_index += 1
	print($SpawnTimer.wait_time)
	
func restart():
	$SpawnTimer.stop()
	$DifficultyTimer.stop()
	virus_spawn_interval = 2.0
	difficulty_index = 1.5
	$SpawnTimer.wait_time = float(virus_spawn_interval) / float(difficulty_index)
	$SpawnTimer.start()
	$DifficultyTimer.start()
