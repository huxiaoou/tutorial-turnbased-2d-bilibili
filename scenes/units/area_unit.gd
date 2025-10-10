extends Area2D
class_name AreaUnit

signal unit_selected()
var is_mouse_hover: bool = false

func on_mouse_entered() -> void:
	is_mouse_hover = true
	
func on_mouse_exited() -> void:
	is_mouse_hover = false

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_click"):
		if is_mouse_hover:
			unit_selected.emit()
