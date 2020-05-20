extends "res://objects/Asteroid.gd"

func explode():
	
	# to prevent exploding twice
	if is_exploded:
		return
	is_exploded = true
	
	get_parent().remove_child(self)
	queue_free()
