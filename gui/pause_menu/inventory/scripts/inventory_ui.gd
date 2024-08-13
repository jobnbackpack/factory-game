class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://gui/pause_menu/inventory/inventory_slot.tscn")

var focus_index: int = 0

@export var data: InventoryData

func _ready():
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	CraftingGui.shown.connect(update_inventory)
	CraftingGui.hidden.connect(clear_inventory)
	clear_inventory()
	data.changed.connect(on_inventory_changed)
	pass

func on_inventory_changed() -> void:
	clear_inventory()
	update_inventory()

func clear_inventory() -> void:
	for c in get_children():
		c.queue_free()

func update_inventory() -> void:
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
	
	get_child(0).grab_focus()
