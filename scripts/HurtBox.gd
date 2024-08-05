class_name HurtBox extends Area2D

@export var damage: int = 1

func _ready():
	area_entered.connect(areaEntered)

func areaEntered(area: Area2D) -> void:
	if area is HitBox:
		area.TakeDamage(damage)
