extends ColorRect

var hm_item

# Debe ser seteado primero el hm_item
func update():
	$Name.text = hm_item.item_name
	$Type.text = str("<", hm_item.get_item_type_name(), ">")
	$Weight.text = str("Weight: ", hm_item.weight)
	$BuyPrice.text = str("Buy Price: ", hm_item.buy_price)
	$SellPrice.text = str("Sell Price: ", hm_item.sell_price)

func hide_drop():
	$Drop.visible = false