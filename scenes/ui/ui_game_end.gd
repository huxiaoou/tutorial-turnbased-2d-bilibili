extends MarginContainer

@onready var label: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var button: Button = $PanelContainer/MarginContainer/VBoxContainer/Button

var game_finished: bool = false

func _ready() -> void:
	ManagerGame.game_over.connect(on_game_over)
	ManagerGame.victory.connect(on_victory)
	button.pressed.connect(on_exit_button_pressed)
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if game_finished:
			return
		label.text = "Return to Menu"
		visible = !visible

func on_victory() -> void:
	label.text = "Congratulations! You've win the game."
	visible = true
	game_finished = true

func on_game_over() -> void:
	label.text = "YOU DIE!"
	visible = true
	game_finished = true
	
func on_exit_button_pressed() -> void:
	ManagerGame.exit_game()
	get_tree().change_scene_to_file("res://scenes/scene_start_menu.tscn")
	print("Exit Game")
