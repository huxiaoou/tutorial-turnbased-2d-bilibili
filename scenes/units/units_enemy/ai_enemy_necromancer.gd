extends AIEnemy

func think() -> DataAIAction:
	var data_ai_action: DataAIAction = DataAIAction.new()
	if try_perform_attack_action(unit.manager_actions.get_action("action_fireball"), data_ai_action):
		return data_ai_action
	elif try_perform_move_action(unit.manager_actions.get_action("action_fireball"), data_ai_action):
		return data_ai_action
	return null
