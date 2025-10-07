extends Node
class_name ManagerActions

var actions: Array[ActionBase] = []

func _ready() -> void:
	for action: ActionBase in self.get_children():
		self.actions.append(action)

func get_action(action_id: String) -> ActionBase:
	var results = actions.filter(func(action: ActionBase): return action.action_id == action_id)
	if not results.is_empty():
		return results[0]
	return null
