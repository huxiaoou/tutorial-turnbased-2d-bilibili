extends ActionBase
class_name ActionSword

@export var scene_sword: PackedScene

func start(target_grid_position: Vector2i, _on_action_finished: Callable) -> void:
	super.start(target_grid_position, _on_action_finished)
	if target_grid_position.x > unit.grid_position.x:
		unit.animated_sprite_2d.scale.x = 1
	elif target_grid_position.x < unit.grid_position.x:
		unit.animated_sprite_2d.scale.x = -1
	var sword: Sword = scene_sword.instantiate()
	unit.slot_weapon.add_child(sword)
	sword.set_up(finish, unit, target_grid_position)

func get_action_grids(unit_grid: Vector2i = self.unit.grid_position) -> Array[Vector2i]:
	var results: Array[Vector2i] = []
	var radius: int = 1
	for i in range(-radius, radius + 1):
		for j in range(-radius, radius + 1):
			if i == 0 and j == 0:
				continue
			var potential_grid: Vector2i = unit_grid + Vector2i(i, j)
			if self.is_obstacle(potential_grid):
				continue
			if self.is_occupant_ally(potential_grid):
				continue	
			results.append(potential_grid)
	return results
