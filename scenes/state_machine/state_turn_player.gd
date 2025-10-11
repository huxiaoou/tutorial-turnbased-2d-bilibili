extends StateBase

var listen_for_input: bool = false

func enter() -> void:
	super.enter()
	self.listen_for_input = true
	
func exit() -> void:
	self.listen_for_input = false
	
func _unhandled_input(event: InputEvent) -> void:
	if not self.listen_for_input:
		return
	if event.is_action_pressed("left_mouse_click"):
		ManagerPlayerAction.try_perform_action_selected()
