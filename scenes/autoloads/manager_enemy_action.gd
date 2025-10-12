extends Node

var is_performing_action: bool = false

func try_perform_ai_action() -> void:
	if is_performing_action:
		return
	if not try_peform_action():
		ManagerTurn.start_turn_player()
	return

func try_peform_action() -> bool:
	for enemy: Unit in ManagerGame.enemy_units:
		if try_perform_enemy_action(enemy):
			return true
	return false

func try_perform_enemy_action(enemy: Unit) -> bool:
	var ai_enemy: AIEnemy = enemy.get_node_or_null("AIEnemy")
	if ai_enemy == null:
		return false
	var data_ai_action: DataAIAction = ai_enemy.think()
	if data_ai_action == null:
		return false
	
	is_performing_action = false
	data_ai_action.action.start(
		data_ai_action.grid_position,
		on_action_finished,
	)
	return true

func on_action_finished() -> void:
	is_performing_action = false
