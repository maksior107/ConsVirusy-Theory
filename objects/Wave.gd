extends Area2D

var direction := Vector2(0, -1)
var projectile_speed := 1000

func _process(delta):
	self.position += direction * projectile_speed * delta


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_Wave_body_shape_entered(body_id, body, body_shape, area_shape):
	if (!self.is_queued_for_deletion() && body.is_in_group("viruses")):
		print("virus hit")
		body.call_deferred("explode")
		get_parent().remove_child(self)
		queue_free()
	