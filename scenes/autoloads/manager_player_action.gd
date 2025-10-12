extends Node

signal unit_is_selected(unit: Unit)

var is_performing_action: bool = false
var action_selected: ActionBase = null
var unit_selected: Unit = null

func set_unit_selected(unit: Unit) -> void:
	if is_performing_action:
		return
	if self.unit_selected == unit or unit.is_enemy:
		return
	self.unit_selected = unit
	print(unit.name + " selected")	
	unit_is_selected.emit(unit)
	self.set_action_selected(unit.manager_actions.get_action("action_move"))

func set_action_selected(action: ActionBase) -> void:
	if self.is_performing_action:
		return
	if self.action_selected == action:
		return
	print("Select " + action.action_name)
	self.action_selected = action
	ManagerGrid.visualize_grids(action_selected.get_action_grids(), action_selected.grid_color)
	return

func on_action_finished() -> void:
	self.is_performing_action = false

func try_perform_action_selected() -> void:
	if self.is_performing_action:
		return
	if self.action_selected == null:
		return
	var target_grid_position: Vector2i = ManagerGrid.get_mouse_grid_position()
	if not action_selected.get_action_grids().has(target_grid_position):
		return
	if unit_selected.cur_action_point < action_selected.action_point_cost:
		print("Not enough action points for " + unit_selected.name + " using " + action_selected.name)
		return
	self.is_performing_action = true
	self.action_selected.start(
		target_grid_position,
		on_action_finished
	)
