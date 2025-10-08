extends Node
class_name	ActionBase

@export var action_id: String
@export var action_name: String

var unit: Unit
var is_active: bool = false
var on_action_finished: Callable

func _ready() -> void:
	self.unit = self.owner
	# print("Owner = " + str(self.owner)) # Unit
	# print("Parent = " + str(self.get_parent())) # ManagerActions

func start(_target_grid_position: Vector2i, _on_action_finished: Callable) -> void:
	print("Start Action " + self.action_name)
	self.is_active = true
	self.on_action_finished = _on_action_finished
	
func finish() -> void:
	self.is_active = false
	self.on_action_finished.call()
