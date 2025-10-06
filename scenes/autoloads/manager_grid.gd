extends Node

var layer_nav: TileMapLayer

func get_grid_position(world_position: Vector2) -> Vector2i:
	return layer_nav.local_to_map(layer_nav.to_local(world_position))
	
func get_world_position(grid_position: Vector2i) -> Vector2:
	return layer_nav.to_global(layer_nav.map_to_local(grid_position))
	
func get_mouse_world_position() -> Vector2:
	return layer_nav.get_global_mouse_position()

func get_mouse_grid_position() -> Vector2i:
	return get_grid_position(get_mouse_world_position())
