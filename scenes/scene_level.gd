extends Node

func _ready() -> void:
	var action: ActionBase = get_tree().current_scene.get_node("Unit").manager_actions.get_action("action_move")
	ManagerPlayerAction.set_action_selected(action)
