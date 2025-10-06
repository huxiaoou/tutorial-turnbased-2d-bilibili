extends Node2D
class_name Unit

var target_global_position: Vector2
var move_speed: float = 500
var grid_position: Vector2i:
	get: return ManagerGrid.get_grid_position(self.global_position)
var grid_path: Array[Vector2] = []

func _unhandled_input(event: InputEvent) -> void:
	# Not using input
	# differeniate from left mouse click in ui
	# process after all the UI input been processed
	# so preventing unit moving when clicking UI
	
	if event.is_action_pressed("left_mouse_click"):
		var mouse_grid_position: Vector2i = ManagerGrid.get_mouse_grid_position()
		self.target_global_position = ManagerGrid.get_world_position(mouse_grid_position)
		self.grid_path = ManagerGrid.get_nav_world_path(
			self.grid_position,
			mouse_grid_position,
		)
	return

func _process(delta: float) -> void:
	if not self.grid_path.is_empty():
		self.move(self.grid_path[0], delta)
		if self.global_position == self.grid_path[0]:
			self.grid_path.remove_at(0)
	return

func move(_target_global_position: Vector2, delta: float) -> void:
	self.global_position = self.global_position.move_toward(_target_global_position, self.move_speed * delta)
	return
