extends Node

@onready var layer_visual: TileMapLayer = $LayerVisual

func _ready() -> void:
	ManagerGrid.layer_vis = layer_visual
	var action: ActionBase = get_tree().current_scene.get_node("Unit").manager_actions.get_action("action_move")
	ManagerPlayerAction.set_action_selected(action)
