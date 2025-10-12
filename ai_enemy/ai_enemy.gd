extends Node
class_name AIEnemy

@export var unit: Unit

func think() -> DataAIAction:
	return null

func try_perform_move_action(action_attack: ActionBase, data_ai_aciton: DataAIAction) -> bool:
	if action_attack == null:
		return false
	var action_move: ActionBase = unit.manager_actions.get_action("action_move")
	if action_move == null:
		return false
	if unit.cur_action_point < action_move.action_point_cost:
		return false
	var targets_number: int = 0
	var target_grid_position: Vector2i
	for grid_position in action_move.get_action_grids():
		var targets: Array[Unit] = get_targets_in_grids(action_attack.get_action_grids(grid_position))
		if targets.size() > targets_number:
			targets_number = targets.size()
			target_grid_position = grid_position
	if targets_number == 0:
		return false
	data_ai_aciton.action = action_move
	data_ai_aciton.grid_position = target_grid_position
	return true

func try_perform_attack_action(action_attack: ActionBase, data_ai_aciton: DataAIAction) -> bool:
	if action_attack == null:
		return false
	if unit.cur_action_point < action_attack.action_point_cost:
		return false
	var targets: Array[Unit] = get_targets_in_grids(action_attack.get_action_grids())
	if targets.is_empty():
		return false
	var target: Unit = targets.pick_random()
	data_ai_aciton.action = action_attack
	data_ai_aciton.grid_position = target.grid_position
	return true

func get_targets_in_grids(grids: Array[Vector2i]) -> Array[Unit]:
	var targets: Array[Unit] = []
	for grid in grids:
		if ManagerGrid.is_grid_occupied(grid) and not ManagerGrid.get_grid_occupant(grid).is_enemy:
			targets.append(ManagerGrid.get_grid_occupant(grid))
	return targets
