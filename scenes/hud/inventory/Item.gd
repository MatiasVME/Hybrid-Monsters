extends HBoxContainer

var hm_item

func update():
	$Image.material.set_shader_param("r_1", Elements.get_color_element(hm_item.primary_element))
	$Image.material.set_shader_param("r_2", Elements.get_color_element(hm_item.secundary_element))
	
	print("xds")
	print(Elements.get_color_element(hm_item.primary_element))
	print(Elements.get_color_element(hm_item.secundary_element))