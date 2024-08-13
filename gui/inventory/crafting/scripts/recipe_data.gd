class_name RecipeData extends Resource

@export var label: String
@export var ingredients: Array[IngredientData]
@export var crafting_time: float
@export var result_item: ItemData

func can_craft():
	var current_inv = PlayerManager.INVENTORY_DATA.slots
	var ingredient_results: Array = []
	for ingredient in ingredients:
		var quantity: int = 0
		for slot in current_inv:
			if slot and slot.item_data and ingredient.item == slot.item_data:
				if slot.quantity >= ingredient.amount:
					quantity += slot.quantity
					continue
				else:
					quantity += slot.quantity
		
		ingredient_results.append({"label": ingredient.item.name, "result": quantity >= ingredient.amount})
	
	return ingredient_results.filter(func(item): return item.result).size() == ingredients.size()

		
