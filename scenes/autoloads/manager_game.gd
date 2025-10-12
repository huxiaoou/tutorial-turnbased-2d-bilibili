extends Node

var player_units: Array[Unit]
var enemy_units: Array[Unit]

func register_unit(unit: Unit) -> void:
	if unit.is_enemy:
		enemy_units.append(unit)
	else:
		player_units.append(unit)
	return

func unregister_unit(unit: Unit) -> void:
	if unit.is_enemy:
		enemy_units.erase(unit)
	else:
		player_units.erase(unit)
		if ManagerPlayerAction.unit_selected == unit and not player_units.is_empty():
			ManagerPlayerAction.set_unit_selected(player_units[0])
	return
