extends WorldResourceData

@onready var hit_box = $HitBox
@onready var animation_player = $AnimationPlayer

var health: int = 10

func _ready():
	animation_player.play('RESET')
	hit_box.damaged.connect(take_damage)

func take_damage(_hurt_box: HurtBox) -> void:
	animation_player.play("hit")
	health -= _hurt_box.damage
	if health <= 0:
		drop_items()
		queue_free() 

