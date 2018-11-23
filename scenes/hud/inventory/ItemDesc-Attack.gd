extends ColorRect

var hm_item

func update():
	$Damage.text = str("Damage: ", hm_item.damage)
	$PrimaryE.text = str("Primary Element: ", hm_item.primary_element_name)
	$SecundaryE.text = str("Secundary Element: ", hm_item.secundary_element_name)
