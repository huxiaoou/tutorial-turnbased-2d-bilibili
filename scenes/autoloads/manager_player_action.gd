extends Node

var is_performing_action: bool = false
var action_selected: ActionBase = null

func set_action_selected(action: ActionBase) -> void:
	if self.is_performing_action:
		return
	if self.action_selected == action:
		return
	print("Select " + action.action_name)
	self.action_selected = action
	return

func on_action_finished() -> void:
	self.is_performing_action = false

func try_perform_action_selected() -> void:
	if self.is_performing_action:
		return
	if self.action_selected == null:
		return
	var target_grid_position: Vector2i = ManagerGrid.get_mouse_grid_position()
	self.is_performing_action = true
	self.action_selected.start(
		target_grid_position,
		on_action_finished
	)

func _unhandled_input(event: InputEvent) -> void:
	# Not using input
	# differeniate from left mouse click in ui
	# process after all the UI input been processed
	# so preventing unit moving when clicking UI
	if self.is_performing_action:
		return
	if event.is_action_pressed("left_mouse_click"):
		self.try_perform_action_selected()
	return
