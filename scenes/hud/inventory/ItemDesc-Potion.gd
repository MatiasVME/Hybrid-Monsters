extends ColorRect

var hm_item

func update():
	if hm_item is Main.HMHealth:
		$Recharge.text = str("Recharge: ", hm_item.health)
