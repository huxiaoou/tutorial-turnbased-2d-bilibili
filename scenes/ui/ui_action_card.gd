extends Button
class_name UIActionCard

var action: ActionBase

func setup(_action: ActionBase) -> void:
	self.action = _action
	self.text = self.action.action_name
