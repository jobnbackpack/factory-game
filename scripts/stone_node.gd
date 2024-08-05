extends StaticBody2D

@onready var interaction_area = $InteractionArea

func _ready():
	$HitBox.Damaged.connect(TakeDamage)

func TakeDamage(_damage: int) -> void:
	queue_free()
