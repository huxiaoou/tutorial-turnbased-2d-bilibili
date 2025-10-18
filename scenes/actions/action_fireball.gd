extends ActionBase

class_name ActionFireball

@export var scene_fireball: PackedScene
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func start(target_grid_position: Vector2i, _on_action_finished: Callable) -> void:
	super.start(target_grid_position, _on_action_finished)
	if target_grid_position.x > unit.grid_position.x:
		unit.animated_sprite_2d.scale.x = 1
	elif target_grid_position.x < unit.grid_position.x:
		unit.animated_sprite_2d.scale.x = -1
	var fireball: Projectile = self.scene_fireball.instantiate()
	get_tree().current_scene.add_child(fireball)
	fireball.global_position = unit.slot_weapon.global_position
	fireball.set_up(finish, unit, target_grid_position)
	audio_stream_player.play()


func get_action_grids(unit_grid: Vector2i = self.unit.grid_position) -> Array[Vector2i]:
	var results: Array[Vector2i] = []
	var max_range: int = 3
	for i in range(-max_range, max_range + 1):
		for j in range(-max_range, max_range + 1):
			if i == 0 and j == 0:
				continue
			var potential_grid: Vector2i = unit_grid + Vector2i(i, j)
			if self.is_obstacle(potential_grid):
				continue
			if self.is_occupant_ally(potential_grid):
				continue
			if self.hit_obstacle(unit_grid, potential_grid):
				continue
			results.append(potential_grid)
	return results
