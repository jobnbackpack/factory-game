extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"

signal interaction_called
signal interaction_area_left

var interact: Callable = func():
	interaction_called.emit()
	pass
	

func _on_body_entered(body):
	InteractionManager.register_area(self)
	

func _on_body_exited(body):
	InteractionManager.unregister_area(self)
	## TODO could be another interactionarea
	interaction_area_left.emit()
