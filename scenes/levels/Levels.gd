extends Node

var rec_level_generator = preload("res://scenes/levels/LevelGenerator.tscn")

func _ready():
	var level_generator = rec_level_generator.instance()
	add_child(level_generator)
