extends StateBase

var listen_for_input: bool = false
var go_to_enemy_turn: bool = false

func enter() -> void:
	super.enter()
	ManagerTurn.turn_enemy_started.connect(on_turn_enemy_started)
	self.listen_for_input = true
	self.go_to_enemy_turn = false

func on_process(delta) -> void:
	if self.go_to_enemy_turn:
		state_changed.emit("StateTurnEnemy")
	return

func exit() -> void:
	ManagerTurn.turn_enemy_started.disconnect(on_turn_enemy_started)
	self.listen_for_input = false

func _unhandled_input(event: InputEvent) -> void:
	if not self.listen_for_input:
		return
	if event.is_action_pressed("left_mouse_click"):
		ManagerPlayerAction.try_perform_action_selected()

func on_turn_enemy_started() -> void:
	if ManagerPlayerAction.is_performing_action:
		return
	self.go_to_enemy_turn = true
