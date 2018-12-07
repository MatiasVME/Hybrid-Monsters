extends TextureButton

var current_egg
var cracked_texture

func _ready():
	randomize()
	
func update_with(current_egg_data):
	print(current_egg_data)
	current_egg = current_egg_data
	
	$EggSprite.texture = load(current_egg["TexturePath"])
	$EggSprite.material.set_shader_param("r_1", current_egg["Colors"][0])
	$EggSprite.material.set_shader_param("r_2", current_egg["Colors"][1])
	$EggSprite.material.set_shader_param("r_3", current_egg["Colors"][2])

func _on_Egg_button_down():
	$Anim.play("touch")
	
	var rand_sound = int(round(rand_range(SoundManager.HIT_EGG_1, SoundManager.HIT_EGG_2)))
	SoundManager.play_sound(rand_sound)
	
	EggFactory.force_step(current_egg["Delivery"])
	
	cracked_texture = EggFactory.get_crack_texture(EggFactory.get_crack_level(current_egg))
	print(cracked_texture)
	
	if cracked_texture:
		$EggSprite/Crack.texture = load(cracked_texture)
	else:
		$EggSprite/Crack.texture = null
	
	_on_Timer_timeout()
	
func _on_Timer_timeout():
	if current_egg:
		$Time.text = EggFactory.get_time_to_open(current_egg["Delivery"])
