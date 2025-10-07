extends Node2D
class_name Unit

@onready var manager_actions: ManagerActions = $ManagerActions
var grid_position: Vector2i:
	get: return ManagerGrid.get_grid_position(self.global_position)
var grid_path: Array[Vector2] = []
var is_performing_action: bool = false

func _unhandled_input(event: InputEvent) -> void:
	# Not using input
	# differeniate from left mouse click in ui
	# process after all the UI input been processed
	# so preventing unit moving when clicking UI
	if self.is_performing_action:
		return
	
	if event.is_action_pressed("left_mouse_click"):
		var mouse_grid_position: Vector2i = ManagerGrid.get_mouse_grid_position()
		self.is_performing_action = true
		manager_actions.get_action("action_move").start(
			mouse_grid_position,
			self.on_action_finished,
		)
	return

func on_action_finished() -> void:
	self.is_performing_action = false
