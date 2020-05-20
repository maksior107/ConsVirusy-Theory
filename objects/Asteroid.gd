extends RigidBody2D

var rng := RandomNumberGenerator.new()

var asteroid_small_scene := load("res://objects/AsteroidSmall.tscn")
var is_exploded := false

func explode():
	
	# to prevent exploding twice
	if is_exploded:
		return
	is_exploded = true
	
	_spawn_asteroids_small(4)
	get_parent().remove_child(self)
	queue_free()

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
	
