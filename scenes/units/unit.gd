extends Node2D
class_name Unit

@onready var manager_actions: ManagerActions = $ManagerActions
@onready var area_unit: AreaUnit = $AreaUnit
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var slot_weapon: Node2D = $AnimatedSprite2D/SlotWeapon

@export var is_enemy: bool = false
@export var max_action_points: int = 2

var cur_action_point: int

var grid_position: Vector2i:
	get: return ManagerGrid.get_grid_position(self.global_position)

func _ready() -> void:
	ManagerTurn.turn_player_started.connect(on_turn_player_started)
	ManagerTurn.turn_enemy_started.connect(on_turn_enemy_started)
	area_unit.unit_selected.connect(on_unit_selected)
	cur_action_point = max_action_points
	ManagerGame.register_unit(self)

func on_unit_selected() -> void:
	ManagerPlayerAction.set_unit_selected(self)

func on_turn_player_started() -> void:
	if is_enemy:
		return
	cur_action_point = max_action_points

func on_turn_enemy_started() -> void:
	if not is_enemy:
		return
	cur_action_point = max_action_points

func take_damage(damage: int) -> void:
	print(name + " take damage: " + str(damage))
	return
