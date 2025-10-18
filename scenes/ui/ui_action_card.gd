extends Button

class_name UIActionCard

var action: ActionBase
@onready var texture_rect: TextureRect = $TextureRect


func _ready() -> void:
	ManagerAudio.register_button(self)
	self.pressed.connect(on_action_selected)


func setup(_action: ActionBase) -> void:
	self.action = _action
	#self.text = self.action.action_name
	texture_rect.texture = action.action_icon


func on_action_selected() -> void:
	ManagerPlayerAction.set_action_selected(self.action)
