extends Node

signal game_over()
signal victory()

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

func on_unit_died(unit: Unit) -> void:
	if unit.is_enemy and enemy_units.is_empty():
		print("Victory")
		victory.emit()
	if not unit.is_enemy and player_units.is_empty():
		print("Game Over")
		game_over.emit()
	return
