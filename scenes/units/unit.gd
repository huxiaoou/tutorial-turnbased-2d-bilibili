extends Node2D
class_name Unit

@onready var manager_actions: ManagerActions = $ManagerActions
@onready var area_unit: AreaUnit = $AreaUnit
@export var is_enemy: bool = false

var grid_position: Vector2i:
	get: return ManagerGrid.get_grid_position(self.global_position)

func _ready() -> void:
	area_unit.unit_selected.connect(on_unit_selected)
	ManagerGame.register_unit(self)

func on_unit_selected() -> void:
	ManagerPlayerAction.set_unit_selected(self)
