extends CanvasLayer

@onready var recipe_list = $Control/RecipeList
@onready var crafting_queue = $Control/CraftingQueue

var recipe_buttons: Array[Button] = []

signal shown
signal hidden

func _ready():
	hide_crafting_gui()
	
func show_crafting_gui():
	_build_crafting_list()
	visible = true
	shown.emit()
	
func hide_crafting_gui():
	visible = false
	hidden.emit()
	
func _input(event):
	if event.is_action_pressed("pause"):
		hide_crafting_gui()
	pass
	
func _remove_list():
	for btn in recipe_buttons:
		recipe_list.remove_child(btn)

func _build_crafting_list():
	_remove_list()
	var recipes = PlayerManager.RECIPES.recipes
	for recipe in recipes:
		var new_button = Button.new()
		new_button.text = recipe.label
		new_button.disabled = !recipe.can_craft()
		new_button.pressed.connect(craft.bind(recipe))
		
		recipe_buttons.append(new_button)
		recipe_list.add_child(new_button)

func craft(recipe: RecipeData):
	_remove_from_inventory(recipe)
	_build_crafting_list()
	
	var new_btn = Button.new()
	new_btn.text = recipe.label
	
	crafting_queue.add_child(new_btn)
	await get_tree().create_timer(recipe.crafting_time).timeout
	crafting_queue.remove_child(new_btn)
	PlayerManager.INVENTORY_DATA.add_item(recipe.result_item)

func _remove_from_inventory(recipe: RecipeData):
	var current_inv = PlayerManager.INVENTORY_DATA.slots
	for ingredient in recipe.ingredients:
		var amount: int = ingredient.amount
		for i in current_inv.size():
			if current_inv[i] and current_inv[i].item_data and ingredient.item == current_inv[i].item_data:
				if current_inv[i].quantity >= ingredient.amount:
					PlayerManager.INVENTORY_DATA.slots[i].quantity -= ingredient.amount
				else:
					amount -= PlayerManager.INVENTORY_DATA.slots[i].quantity
					PlayerManager.INVENTORY_DATA.slots[i].quantity = 0
	PlayerManager.INVENTORY_DATA.slot_changed()
	

