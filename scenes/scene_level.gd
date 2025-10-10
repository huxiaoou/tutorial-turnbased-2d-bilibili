extends Node

@onready var layer_visual: TileMapLayer = $LayerVisual
@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
	ManagerGrid.layer_vis = layer_visual
	for unit: Unit in ManagerGame.player_units:
		ManagerGrid.set_grid_walkable(unit.grid_position, false)
		ManagerGrid.set_grid_occupant(unit.grid_position, unit)
	for unit: Unit in ManagerGame.enemy_units:
		ManagerGrid.set_grid_walkable(unit.grid_position, false)
		ManagerGrid.set_grid_occupant(unit.grid_position, unit)
	if not ManagerGame.player_units.is_empty():
		var unit: Unit = ManagerGame.player_units[0]
		ManagerPlayerAction.set_unit_selected(unit)
	state_machine.launch()
