extends Node2D

func _ready():
	update_all()
	
	Main.connect("gold_changed", self, "on_gold_changed")

func update_all():
	update_gold()
	update_emerald()
	
func update_gold():
	$GoldAmount.text = str(Main.current_gold)
	
func update_emerald():
	$EmeraldAmount.text = str(Main.current_emeralds)

func on_gold_changed(current_gold):
	update_gold()
	$GoldAnim.play("gold")
	