extends StaticBody2D

@onready var hit_box = $HitBox

func _ready():
	hit_box.damaged.connect(take_damage)

func take_damage(_hurt_box: HurtBox) -> void:
	queue_free() 
