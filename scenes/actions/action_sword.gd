extends ActionBase
class_name ActionSword

func start(target_grid_position: Vector2i, on_action_finished: Callable) -> void:
	super.start(target_grid_position, on_action_finished)
	print("Start" + self.action_name)
	self.finish()
	
