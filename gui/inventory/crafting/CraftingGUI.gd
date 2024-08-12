extends CanvasLayer

func _ready():
	hide_crafting_gui()
	
func show_crafting_gui():
	visible = true
	
func hide_crafting_gui():
	visible = false
	
func _input(event):
	if event.is_action_pressed("pause"):
		hide_crafting_gui()
	pass
	#if event.is_action_pressed("interact"):
		#CraftingGui.visible = false
		#get_viewport().set_input_as_handled()
