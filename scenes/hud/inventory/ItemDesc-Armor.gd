extends ColorRect

var hm_item

func update():
	$Defence.text = str("Defence: ", hm_item.defence, "%")