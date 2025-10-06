extends Node

var layer_nav: LayerNav

func get_grid_position(world_position: Vector2) -> Vector2i:
	return self.layer_nav.local_to_map(layer_nav.to_local(world_position))
	
func get_world_position(grid_position: Vector2i) -> Vector2:
	return self.layer_nav.to_global(layer_nav.map_to_local(grid_position))
	
func get_mouse_world_position() -> Vector2:
	return self.layer_nav.get_global_mouse_position()

func get_mouse_grid_position() -> Vector2i:
	return self.get_grid_position(self.get_mouse_world_position())

func get_nav_grid_path(start_grid_position: Vector2i, end_grid_position: Vector2i) -> Array[Vector2i]:
	if not self.is_valid_grid(start_grid_position) or not self.is_valid_grid(end_grid_position):
		return []
	return self.layer_nav.a_star.get_id_path(start_grid_position, end_grid_position)

func get_nav_world_path(start_grid_position: Vector2i, end_grid_position: Vector2i) -> Array[Vector2]:
	var grid_path: Array[Vector2i] = self.get_nav_grid_path(start_grid_position, end_grid_position)
	var world_path: Array[Vector2] = []
	for grid_position in grid_path:
		var world_position = self.get_world_position(grid_position)
		world_path.append(world_position)
	return world_path

func is_valid_grid(grid_position: Vector2i) -> bool:
	return self.layer_nav.grid_data_dict.has(grid_position)

func is_grid_walkable(grid_position: Vector2i) -> bool:
	return is_valid_grid(grid_position) and self.layer_nav.grid_data_dict[grid_position].walkable

func set_grid_walkable(grid_position: Vector2i, walkable: bool) -> void:
	if not self.is_valid_grid(grid_position):
		return
	self.layer_nav.grid_data_dict[grid_position].walkable = walkable
	self.layer_nav.a_star.set_point_solid(grid_position, !walkable)
	return

func is_grid_occupied(grid_position: Vector2i) -> bool:
	return self.is_valid_grid(grid_position) and self.layer_nav.grid_data_dict[grid_position].is_occupied_by_unit()

func get_grid_occupant(grid_position: Vector2i) -> Unit:
	if not self.is_valid_grid(grid_position):
		return null
	return self.layer_nav.grid_data_dict[grid_position].occupant

func set_grid_occupant(grid_position: Vector2i, unit: Unit) -> void:
	if not self.is_valid_grid(grid_position):
		return
	self.layer_nav.grid_data_dict[grid_position].occupant = unit
	return
