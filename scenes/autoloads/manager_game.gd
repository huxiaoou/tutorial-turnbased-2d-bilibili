extends Node

signal game_over()
signal victory()

var selected_player_resources: Array[UnitResource]
var maximum_unit_count: int = 3
var selected_level_resource: ResourceLevel
var player_units: Array[Unit]
var enemy_units: Array[Unit]

func register_unit(unit: Unit) -> void:
	if unit.is_enemy:
		enemy_units.append(unit)
	else:
		player_units.append(unit)
	unit.unit_died.connect(on_unit_died)
	return

func unregister_unit(unit: Unit) -> void:
	if unit.is_enemy:
		enemy_units.erase(unit)
	else:
		player_units.erase(unit)
		if ManagerPlayerAction.unit_selected == unit and not player_units.is_empty():
			ManagerPlayerAction.set_unit_selected(player_units[0])
	return

func spawn_player_units() -> void:
	var spawn_pos_idx: int = 0
	var spawn_positions: Array[Node2D] =  get_tree().current_scene.player_spawn_positions
	for unit_resource: UnitResource in selected_player_resources:
		if spawn_pos_idx < spawn_positions.size():
			var unit: Unit = unit_resource.unit_scene.instantiate()
			get_tree().current_scene.add_child(unit)
			unit.global_position = spawn_positions[spawn_pos_idx].global_position
			spawn_pos_idx += 1

func on_unit_died(unit: Unit) -> void:
	if unit.is_enemy and enemy_units.is_empty():
		print("Victory")
		victory.emit()
	if not unit.is_enemy and player_units.is_empty():
		print("Game Over")
		game_over.emit()
	return

func exit_game() -> void:
	selected_player_resources.clear()
	player_units.clear()
	enemy_units.clear()
	ManagerGrid.layer_nav = null
	ManagerGrid.layer_vis = null
	ManagerPlayerAction.is_performing_action = false
	ManagerPlayerAction.action_selected = null
	ManagerPlayerAction.unit_selected = null
	ManagerEnemyAction.is_performing_action = false
