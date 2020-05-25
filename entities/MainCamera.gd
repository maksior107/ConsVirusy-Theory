extends Camera2D



func _on_Player_laser_shoot():
	$Screenshake.start(0.1, 15, 4, 0)

func asteroid_exploded():
	$Screenshake.start(0.1, 15, 12, 2)
	
func asteroid_small_exploded():
	$Screenshake.start(0.1, 15, 8, 1)
