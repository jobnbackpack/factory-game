extends StaticBody2D

@onready var hit_box = $HitBox

func _ready():
	hit_box.Damaged.connect(TakeDamage)

func TakeDamage(_damage: int) -> void:
	queue_free() 
