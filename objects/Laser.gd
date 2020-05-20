extends Area2D

var direction := Vector2(0, -1)
var projectile_speed := 1000

func _process(delta):
	self.position += direction * projectile_speed * delta


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()