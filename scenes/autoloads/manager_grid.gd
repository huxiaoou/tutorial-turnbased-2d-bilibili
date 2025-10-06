extends Node

var layer_nav: LayerNav

func get_grid_position(world_position: Vector2) -> Vector2i:
	return layer_nav.local_to_map(layer_nav.to_local(world_position))
	
func get_world_position(grid_position: Vector2i) -> Vector2:
	return layer_nav.to_global(layer_nav.map_to_local(grid_position))
	
func get_mouse_world_position() -> Vector2:
	return layer_nav.get_global_mouse_position()

func get_mouse_grid_position() -> Vector2i:
	return self.get_grid_position(self.get_mouse_world_position())

func get_nav_grid_path(start_grid_position: Vector2i, end_grid_position: Vector2i) -> Array[Vector2i]:
	return layer_nav.a_star.get_id_path(start_grid_position, end_grid_position)

func get_nav_world_path(start_grid_position: Vector2i, end_grid_position: Vector2i) -> Array[Vector2]:
	var grid_path: Array[Vector2i] = self.get_nav_grid_path(start_grid_position, end_grid_position)
	var world_path: Array[Vector2] = []
	for grid_position in grid_path:
		var world_position = self.get_world_position(grid_position)
		world_path.append(world_position)
	return world_path
