extends RigidBody2D

signal explode

var rng := RandomNumberGenerator.new()
var explosion_particles_scene := load("res://objects/ParticlesAsteroidExplosion.tscn")
var asteroid_small_scene := load("res://objects/AsteroidSmall.tscn")
var is_exploded := false

var explosion_pitch = 1

signal score_changed
var score_value = 100
var points_scored_scene = load("res://UI/PointsScored.tscn")

func _ready() -> void:
	var main_camera = get_node("/root/Game/MainCamera")
	self.connect("explode", main_camera, "asteroid_exploded")
	var label = get_tree().get_root().get_node("Game/GUI/MarginContainer/HBoxContainer/VBoxContainer/Score")
	self.connect("score_changed", label, "update_score")
	
func explode():
	
	# to prevent exploding twice
	if is_exploded:
		return
	is_exploded = true
	
	_explosion_particles()
	_play_explosion_sound()
	
	emit_signal("explode")
	emit_signal("score_changed", score_value)
	_spawn_score()
	
	_spawn_asteroids_small(4)
	get_parent().remove_child(self)
	queue_free()

func _spawn_score():
	var points_scored = points_scored_scene.instance()
	points_scored.get_node("Label").text = str(score_value)
	points_scored.position = self.position

	get_parent().add_child(points_scored)
	
func _play_explosion_sound():
	var explosion_sound = AudioStreamPlayer2D.new()
	explosion_sound.stream = load("res://assets/audio/sfx/AsteroidExplosion.wav")
	explosion_sound.pitch_scale = explosion_pitch
	explosion_sound.position = self.position
	get_parent().add_child(explosion_sound)
	explosion_sound.play(0)

func _explosion_particles():
	var explosion_particles = explosion_particles_scene.instance()
	explosion_particles.position = self.position
	get_parent().add_child(explosion_particles)
	explosion_particles.emitting = true

func _spawn_asteroids_small(num):
	for i in range(num):
		_spawn_asteroid_small()

func _spawn_asteroid_small():
	var asteroid_small = asteroid_small_scene.instance()
	asteroid_small.position = self.position
	_randomize_trajectory(asteroid_small)
	get_parent().add_child(asteroid_small)  


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()

func _randomize_trajectory(asteroid):
	asteroid.angular_velocity = rand_range(-4, 4) # random spin
	asteroid.angular_damp = 0
	
	# randomizing value, by drawing -1 or 0 or 1
	rng.randomize()
	var lv_x = rng.randi_range(-1, 1)
	var lv_y = rng.randi_range(-1, 1)
	
	# random direction
	asteroid.linear_velocity = Vector2(lv_x * 400, lv_y * 400)
	asteroid.linear_damp = 0
	
