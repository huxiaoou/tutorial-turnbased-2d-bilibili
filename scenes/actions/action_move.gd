extends ActionBase
class_name ActionMove

var path: Array[Vector2]
var speed: float = 200

func start(target_grid_position: Vector2i, _on_action_finished: Callable) -> void:
	super.start(target_grid_position, _on_action_finished)
	self.path = ManagerGrid.get_nav_world_path(self.unit.grid_position, target_grid_position)
	return

func move(_target_global_position: Vector2, delta: float) -> void:
	self.unit.global_position = self.unit.global_position.move_toward(_target_global_position, self.speed * delta)
	return

func _process(delta: float) -> void:
	if not self.is_active:
		return
	if not self.path.is_empty():
		self.move(self.path[0], delta)
		if self.unit.global_position == self.path[0]:
			self.path.remove_at(0)
			ManagerGrid.visualize_grids(
				ManagerPlayerAction.action_selected.get_action_grids(), 
				ManagerPlayerAction.action_selected.grid_color
			)
	else:
		print("No path avaiable, action finished.")
		self.finish()
	return

func get_action_grids(unit_grid: Vector2i = self.unit.grid_position) -> Array[Vector2i]:
	var results: Array[Vector2i] = []
	var max_length: int = 3
	for i in range(-max_length, max_length + 1):
		for j in range(-max_length, max_length + 1):
			if i == 0 and j == 0:
				continue
			var potential_grid: Vector2i = unit_grid + Vector2i(i, j)
			var grid_path: Array[Vector2i] = ManagerGrid.get_nav_grid_path(unit_grid, potential_grid)
			var length: float = ManagerGrid.get_grid_path_length(grid_path)
			if length <= max_length and length > 0 and ManagerGrid.is_grid_walkable(potential_grid):
				results.append(potential_grid)
	return results
