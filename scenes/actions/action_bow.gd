extends ActionBase

class_name ActionBow

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var scene_bow: PackedScene


func start(target_grid_position: Vector2i, _on_action_finished: Callable) -> void:
	super.start(target_grid_position, _on_action_finished)
	if target_grid_position.x > unit.grid_position.x:
		unit.animated_sprite_2d.scale.x = 1
	elif target_grid_position.x < unit.grid_position.x:
		unit.animated_sprite_2d.scale.x = -1
	var bow: Bow = self.scene_bow.instantiate()
	unit.slot_weapon.add_child(bow)
	bow.setup(finish, unit, target_grid_position)
	audio_stream_player.play()


func get_action_grids(unit_grid: Vector2i = self.unit.grid_position) -> Array[Vector2i]:
	var results: Array[Vector2i] = []
	var max_range: int = 3
	for i in range(-max_range, max_range + 1):
		if i == 0:
			continue
		var potential_grid: Vector2i = unit_grid + Vector2i(i, 0)
		if self.is_valid_action_grid(unit_grid, potential_grid):
			results.append(potential_grid)
		potential_grid = unit_grid + Vector2i(0, i)
		if self.is_valid_action_grid(unit_grid, potential_grid):
			results.append(potential_grid)
	return results


func is_valid_action_grid(unit_grid: Vector2i, grid_position: Vector2i) -> bool:
	if self.is_obstacle(grid_position):
		return false
	if self.is_occupant_ally(grid_position):
		return false
	if self.hit_obstacle(unit_grid, grid_position):
		return false
	return true
