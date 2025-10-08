extends Node2D
class_name Unit

@onready var manager_actions: ManagerActions = $ManagerActions
@export var is_enemy: bool = false

var grid_position: Vector2i:
	get: return ManagerGrid.get_grid_position(self.global_position)
