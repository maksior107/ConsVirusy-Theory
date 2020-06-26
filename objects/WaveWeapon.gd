extends Node2D

var wave_scene := load("res://objects/Wave.tscn")

func shoot():
	var wave = wave_scene.instance();
	wave.global_position = self.global_position
	get_node("/root/Game").add_child(wave)
