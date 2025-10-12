extends Projectile

var radius_damage: int = 1

func deal_damage() -> void:
	for i in range(-radius_damage, radius_damage + 1):
		for j in range(-radius_damage, radius_damage + 1):
			var potential_grid: Vector2i = target_grid_position + Vector2i(i, j)
			var target: Unit = ManagerGrid.get_grid_occupant(potential_grid)
			if target and target.is_enemy != unit.is_enemy:
				target.take_damage(damage)
	
