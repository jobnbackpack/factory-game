class_name Player extends CharacterBody2D

@onready var hurt_box: HurtBox = $Interactions/HurtBox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged(new_direction: Vector2)

func _ready():
	state_machine.Initialize(self)
	pass

func _process(delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	pass
	
func _physics_process(delta):
	move_and_slide()
	
func SetDirection() -> bool:
	var new_dir: Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	DirectionChanged.emit(cardinal_direction)
	return true
	
func UpdateAnimation(state: String) -> void:
	animation_player.play(state + "_" + AnimDirection() )
	pass
	
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
	
func _input(event: InputEvent):
	if event.is_action("attack"):
		await get_tree().create_timer(0.075).timeout
		hurt_box.monitoring = true
		await get_tree().create_timer(0.075).timeout
		hurt_box.monitoring = false
	
