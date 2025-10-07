extends ActionBase
class_name ActionMove

var path: Array[Vector2]
var speed: float = 200

func start(target_grid_position: Vector2i, on_action_finished: Callable) -> void:
	super.start(target_grid_position, on_action_finished)
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
	else:
		self.finish()
	return
