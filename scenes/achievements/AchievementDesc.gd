extends ColorRect

var achievement

# Debe ser seteado primero el hm_item
func update():
	if not achievement:
		return
	
	$Name.text = achievement["Name"]
	
	if achievement["IsCompleted"]:
		$Completed.text = str("< Completed >")
	else:
		$Completed.text = str("< Not Completed >")
		
	$Description.text = achievement["Description"]

