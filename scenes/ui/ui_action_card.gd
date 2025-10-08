extends Button
class_name UIActionCard

var action: ActionBase

func _ready() -> void:
	self.pressed.connect(on_action_selected)

func setup(_action: ActionBase) -> void:
	self.action = _action
	self.text = self.action.action_name

func on_action_selected() -> void:
	ManagerPlayerAction.set_action_selected(self.action)
