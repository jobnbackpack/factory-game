class_name Player extends CharacterBody2D

@onready var hurt_box: HurtBox = $Interactions/HurtBox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var speed = 100  # speed in pixels/sec
var direction: Vector2 = Vector2.ZERO

signal DirectionChanged(new_direction: Vector2)
 
func _physics_process(delta):
	var new_direction = Input.get_vector("left", "right", "up", "down")
	
	if new_direction != direction:
		direction = new_direction
		DirectionChanged.emit(new_direction)
		
	if direction > Vector2.LEFT:
		animated_sprite_2d.flip_h = true
	elif direction < Vector2.RIGHT:
		animated_sprite_2d.flip_h = false
	
	velocity = direction * speed
	
	if velocity != Vector2.ZERO:
		animated_sprite_2d.play("run")
	else: 
		animated_sprite_2d.play("idle")

	move_and_slide()
	
func _input(event: InputEvent):
	if event.is_action("attack"):
		await get_tree().create_timer(0.075).timeout
		hurt_box.monitoring = true
		await get_tree().create_timer(0.075).timeout
		hurt_box.monitoring = false
	
