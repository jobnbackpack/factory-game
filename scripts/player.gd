extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var speed = 200  # speed in pixels/sec

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction > Vector2.LEFT:
		animated_sprite_2d.flip_h = true
	elif direction < Vector2.RIGHT:
		animated_sprite_2d.flip_h = false
	
	velocity = direction * speed

	move_and_slide()
