extends Node2D

func _ready():
	DeliveryManager.connect("new_delivery", self, "_on_new_delivery")

func _on_new_delivery(delivery):
	if delivery[0] == "ShopItems":
		$ShopAnim.play("show")
		ItemGenerator.create_item_pack_for_shop(DataManager.shop_inventory, DataManager.players[Main.current_player].level)
		DataManager.save_user_config()