extends TextureButton

var achievement

func add_achievement(_achievement):
	achievement = _achievement
	$Sprite.texture = load(achievement["TexturePath"])
	update()

func update():
	if achievement and achievement["IsCompleted"]:
		self.texture_normal = load("res://scenes/achievements/achievement_slots/completed_normal.png")
		self.texture_pressed = load("res://scenes/achievements/achievement_slots/completed_selected.png")
		self.texture_hover = load("res://scenes/achievements/achievement_slots/completed_hover.png")
