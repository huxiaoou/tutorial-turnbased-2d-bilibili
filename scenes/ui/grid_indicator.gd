extends Node2D

var mouse_grid_position: Vector2i

func _process(delta: float) -> void:
	var new_mouse_grid_position: Vector2i = ManagerGrid.get_mouse_grid_position()
	if new_mouse_grid_position != mouse_grid_position:
		mouse_grid_position = new_mouse_grid_position
		global_position = ManagerGrid.get_world_position(mouse_grid_position)
	return
