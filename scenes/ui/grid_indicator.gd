extends Node2D

var mouse_grid_position: Vector2i

func _process(_delta: float) -> void:
	var new_mouse_grid_position: Vector2i = ManagerGrid.get_mouse_grid_position()
	if new_mouse_grid_position != self.mouse_grid_position:
		self.mouse_grid_position = new_mouse_grid_position
		self.global_position = ManagerGrid.get_world_position(self.mouse_grid_position)
	return
