extends "res://objects/Virus.gd"

func _ready() -> void:
	var main_camera = get_node("/root/Game/MainCamera")
	self.connect("explode", main_camera, "rna_exploded")
	score_value = 200

func explode():
	
	# to prevent exploding twice
	if is_exploded:
		return
	is_exploded = true
	
	_explosion_particles()
	explosion_pitch = 1.2
	_play_explosion_sound()
	
	emit_signal("explode")
	emit_signal("score_changed", score_value)
	_spawn_score()
	
	get_parent().remove_child(self)
	queue_free()
