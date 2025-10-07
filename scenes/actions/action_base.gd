extends Node
class_name	ActionBase

@export var action_id: String
@export var action_name: String

var unit: Unit
var is_active: bool = false
var on_action_finished: Callable

func _ready() -> void:
	self.unit = self.owner

func start(target_grid_position: Vector2i, on_action_finished: Callable) -> void:
	self.is_active = true
	self.on_action_finished = on_action_finished
	
func finish() -> void:
	self.is_active = false
	self.on_action_finished.call()
