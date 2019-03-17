extends "../Attack.gd"

func _ready():
	update()
	var rand_sound = int(round(rand_range(SoundManager.Sound.SWORD_1, SoundManager.Sound.SWORD_3)))
	SoundManager.play_sound(rand_sound)

# Actualiza la data del sword, como por ejemplo el skin
func update():
	if item == null:
		print("No se puede actualizar ya que no hay item")
		return

	var sword_texture = load(item.texture_path)
	$Sprite.texture = sword_texture
	
	$Sprite.material.set_shader_param("r_1", Elements.get_color_element(item.primary_element))
	$Sprite.material.set_shader_param("r_2", Elements.get_color_element(item.secundary_element))
