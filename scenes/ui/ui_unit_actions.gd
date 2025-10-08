extends MarginContainer
class_name UIUnitAction

@export var ui_action_card_scene: PackedScene
@onready var action_container: HBoxContainer = $MarginContainer/ActionContainer

func _ready() -> void:
	call_deferred("update_ui_unit_actions")

func update_ui_unit_actions() -> void:
	var manager_actions: ManagerActions = get_tree().current_scene.get_node("Unit").get_node("ManagerActions")
	for node in self.action_container.get_children():
		node.queue_free()
	for action in manager_actions.actions:
		var ui_action_card: UIActionCard = ui_action_card_scene.instantiate()
		self.action_container.add_child(ui_action_card)
		ui_action_card.setup(action)
	return
