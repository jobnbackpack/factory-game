@tool
class_name ItemPickup extends CharacterBody2D

@export var item_data: ItemData : set = _set_item_data

@onready var area = $Area2D
@onready var sprite = $Sprite2D

func _ready():
	_update_texture()
	if Engine.is_editor_hint():
		return
	area.body_entered.connect(_on_body_entered)
	
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	## slow down
	velocity -= velocity * delta * 4

func _on_body_entered(b) -> void:
	if b is Player:
		if item_data:
			if PlayerManager.INVENTORY_DATA.add_item(item_data) == true:
				item_picked_up()
	pass

func item_picked_up() -> void:
	area.body_entered.disconnect(_on_body_entered)
	## Play Audio
	visible = false
	## await audio played
	queue_free()

func _set_item_data(value: ItemData) -> void:
	item_data = value
	_update_texture()

func _update_texture() -> void:
	if item_data and sprite:
		sprite.texture = item_data.texture
	pass
