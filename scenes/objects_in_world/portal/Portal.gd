extends "../ObjectInWorld.gd"

func _ready():
	pass

func touch(who):
	.touch(who)
	
	yield(who.get_node("Anim"), "animation_finished")
	
	get_tree().change_scene("res://scenes/levels/Levels.tscn")