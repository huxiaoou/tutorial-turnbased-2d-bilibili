extends StateBase

var go_to_player_turn: bool = false

func enter() -> void:
	super.enter()
	ManagerTurn.turn_player_started.connect(on_player_turn_started)
	go_to_player_turn = false

func on_process(delta: float) -> void:
	if go_to_player_turn:
		state_changed.emit("StateTurnPlayer")
		return
	ManagerEnemyAction.try_perform_ai_action()

func exit() -> void:
	ManagerTurn.turn_player_started.disconnect(on_player_turn_started)

func on_player_turn_started() -> void:
	go_to_player_turn = true
	
