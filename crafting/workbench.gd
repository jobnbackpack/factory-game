extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea

var open := false

func _ready():
	interaction_area.interaction_called.connect(on_interaction)
	interaction_area.interaction_area_left.connect(on_interaction_area_left)

func on_interaction():
	if open:
		CraftingGui.hide_crafting_gui()
		open = false
	else:
		CraftingGui.show_crafting_gui()
		open = true
	
func on_interaction_area_left():
	CraftingGui.hide_crafting_gui()
	open = false


