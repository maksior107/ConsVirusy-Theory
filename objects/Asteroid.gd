extends RigidBody2D

var is_exploded := false

func explode():
	
	# to prevent exploding twice
	if is_exploded:
		return
	is_exploded = true
	
	get_parent().remove_child(self)
	queue_free()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
