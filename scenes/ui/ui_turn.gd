extends MarginContainer

@onready var button_end_turn: Button = $ButtonEndTurn
@onready var label_turn: Label = $LabelTurn

func _ready() -> void:
	button_end_turn.pressed.connect(on_button_end_turn_pressed)
	ManagerTurn.turn_player_started.connect(on_turn_player_started)
	ManagerTurn.turn_enemy_started.connect(on_turn_enemy_started)
	
	
func on_button_end_turn_pressed() -> void:
	if ManagerPlayerAction.is_performing_action or ManagerEnemyAction.is_performing_action:
		return
	ManagerTurn.start_turn_enemy()
	return

func on_turn_player_started() -> void:
	label_turn.text = "Player's Turn"

func on_turn_enemy_started() -> void:
	label_turn.text = "Enemy's Turn"
