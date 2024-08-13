class_name WorldResourceData extends StaticBody2D

@export var drops: Array[DropData] = []
const PICKUP = preload("res://items/item_pickup/item_pickup.tscn")

func drop_items():
	if drops.size() == 0:
		return
	
	for i in drops.size():
		if drops[i] == null or drops[i].item == null:
			continue
		var drop_count: int = drops[i].get_drop_count()
		for j in drop_count:
			var drop: ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			self.get_parent().call_deferred("add_child", drop)
			drop.global_position = self.global_position
			drop.velocity = self.global_position * randf_range(1,4)
