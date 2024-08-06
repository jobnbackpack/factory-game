class_name State_Attack extends State

var attacking: bool = false

@onready var walk: State = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var idle: State = $"../Idle"
@onready var hurt_box = %AttackHurtBox

## What happens when the player enters this State?
func Enter() -> void:
	attacking = true
	
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect(EndAttack)
	
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	pass
	
## What happens when the player exits this State?
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	hurt_box.monitoring = false
	pass
	
## What happens during the _process update in this State?
func Process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
## What happens during the _physics_process update in this State?
func Physics(_delta: float) -> State:
	return null
	
## What happens with input events in this State?
func HandleInput(_event: InputEvent) -> State:
	return null
	
func EndAttack(_newAnimName: String) -> void:
	attacking = false
