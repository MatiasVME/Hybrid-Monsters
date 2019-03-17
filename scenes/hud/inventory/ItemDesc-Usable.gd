extends ColorRect

var hm_item

func update():
	if hm_item is HMBook:
		var stat_name = hm_item.get_type_name()
		var max_stat_value = DataManager.stats[Main.current_player].get_stat_max_value(stat_name)
		var stat_value = DataManager.stats[Main.current_player].get_stat_value(stat_name)
		
		if max_stat_value == stat_value:
			$Use.disabled = true
