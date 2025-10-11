extends Node2D
class_name Unit

@onready var manager_actions: ManagerActions = $ManagerActions
@onready var area_unit: AreaUnit = $AreaUnit
@export var is_enemy: bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var slot_weapon: Node2D = $AnimatedSprite2D/SlotWeapon

var grid_position: Vector2i:
	get: return ManagerGrid.get_grid_position(self.global_position)

func _ready() -> void:
	area_unit.unit_selected.connect(on_unit_selected)
	ManagerGame.register_unit(self)

func on_unit_selected() -> void:
	ManagerPlayerAction.set_unit_selected(self)

func take_damage(damage: int) -> void:
	print(name + " take damage: " + str(damage))
	return
