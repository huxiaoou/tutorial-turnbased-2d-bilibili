extends MarginContainer
class_name UIUnitAction

@export var ui_action_card_scene: PackedScene
@onready var action_container: HBoxContainer = $MarginContainer/ActionContainer
var unit_selected: Unit = null

func _ready() -> void:
	ManagerPlayerAction.unit_is_selected.connect(on_unit_is_selected)

func on_unit_is_selected(unit: Unit) -> void:
	if self.unit_selected == unit:
		return
	self.unit_selected = unit
	self.update_ui_unit_actions()

func update_ui_unit_actions() -> void:
	var manager_actions: ManagerActions = unit_selected.manager_actions
	for node in self.action_container.get_children():
		node.queue_free()
	for action in manager_actions.actions:
		var ui_action_card: UIActionCard = ui_action_card_scene.instantiate()
		self.action_container.add_child(ui_action_card)
		ui_action_card.setup(action)
	return
