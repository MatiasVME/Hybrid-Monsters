extends TextureButton

var hm_item

func update():
	if hm_item is Main.HMAttack:
		$Sprite.material.set_shader_param("r_1", Elements.get_color_element(hm_item.primary_element))
		$Sprite.material.set_shader_param("r_2", Elements.get_color_element(hm_item.secundary_element))
