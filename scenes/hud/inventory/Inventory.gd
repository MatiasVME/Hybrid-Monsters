extends Node2D

var rec_item = preload("res://scenes/hud/inventory/Item.tscn")

func _ready():
	var inv = DataManager.inventories[0].get_inv()
	
	for item in inv:
		add_item(item)

func add_item(hm_item):
	var item_gui = rec_item.instance()
	item_gui.hm_item = hm_item

	$Inv/HBox/Items/VBox.add_child(item_gui)
	
	item_gui.text = hm_item.item_name
	item_gui.icon = load(hm_item.get_texture_path())