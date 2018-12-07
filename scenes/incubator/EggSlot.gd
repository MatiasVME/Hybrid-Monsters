extends TextureButton

var egg_data

func add_egg(_egg_data):
	egg_data = _egg_data
	
	$Sprite.texture = load(egg_data["TexturePath"])
	
	$Sprite.material.set_shader_param("r_1", egg_data["Colors"][0])
	$Sprite.material.set_shader_param("r_2", egg_data["Colors"][1])
	$Sprite.material.set_shader_param("r_3", egg_data["Colors"][2])
	

#func update():
