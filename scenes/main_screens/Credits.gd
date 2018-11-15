extends Node2D

func _ready():
	pass

func _on_Credits_meta_clicked(meta):
	OS.shell_open(meta)

