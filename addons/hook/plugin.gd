tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("HookHelper", "Node", preload("nodes/HookHelper.gd"), preload("icons/hook_helper.png"))
	add_custom_type("HookDelivery", "Node", preload("nodes/HookDelivery.gd"), preload("icons/hook_delivery.png"))
	add_custom_type("HookAchievements", "Node", preload("nodes/HookAchievements.gd"), preload("icons/hook_achievements.png"))
	
func _exit_tree():
	remove_custom_type("HookHelper")
	remove_custom_type("HookDelivery")
	remove_custom_type("HookAchievements")
