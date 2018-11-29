extends TextureButton

var achievement

func add_achievement(_achievement):
	achievement = _achievement
	
	$Sprite.texture = load(achievement["TexturePath"])
	
	
