class_name HurtBox extends Area2D

@export var damage: int = 1

func _ready():
	area_entered.connect(handle_area_entered)

func handle_area_entered(area: Area2D) -> void:
	if area is HitBox:
		area.take_damage(self)
