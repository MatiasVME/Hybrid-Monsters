extends Node2D

var current_achievement

func _ready():
	AchievementsManager.get_node("HookAchievements").connect("complete_achievement", self, "_on_complete_achievement")

func update():
	$Achievement.texture = load(current_achievement["TexturePath"])
	$Title.text = current_achievement["Name"]
	
func _on_complete_achievement(achievement):
	current_achievement = achievement
	update()
	$Anim.play("show_and_hide")