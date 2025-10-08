extends ActionBase
class_name ActionFireball

func start(target_grid_position: Vector2i, _on_action_finished: Callable) -> void:
	super.start(target_grid_position, _on_action_finished)
	self.finish()
