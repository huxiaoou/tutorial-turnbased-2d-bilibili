extends Node2D

class_name Unit

signal unit_died(unit: Unit)
signal action_points_changed(action_point: int)

@onready var manager_actions: ManagerActions = $ManagerActions
@onready var area_unit: AreaUnit = $AreaUnit
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var slot_weapon: Node2D = $AnimatedSprite2D/SlotWeapon
@onready var health: Health = $Health
@onready var audio_player_die: AudioStreamPlayer = $Sounds/AudioPlayerDie
@onready var audio_player_hit: AudioStreamPlayer = $Sounds/AudioPlayerHit

@export var is_enemy: bool = false
@export var max_action_points: int = 2

var is_dead: bool = false

var grid_position: Vector2i:
	get:
		return ManagerGrid.get_grid_position(self.global_position)

var cur_action_point: int:
	set(value):
		cur_action_point = value
		action_points_changed.emit(value)


func _ready() -> void:
	ManagerTurn.turn_player_started.connect(on_turn_player_started)
	ManagerTurn.turn_enemy_started.connect(on_turn_enemy_started)
	area_unit.unit_selected.connect(on_unit_selected)
	cur_action_point = max_action_points
	ManagerGame.register_unit(self)
	health.health_changed.connect(on_health_changed)


func on_health_changed(health_point: int) -> void:
	if health_point <= 0:
		die()
	return


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
	audio_player_hit.play()
	health.take_damage(damage)
	return


func die() -> void:
	is_dead = true
	audio_player_die.play()
	ManagerGrid.set_grid_occupant(grid_position, null)
	ManagerGrid.set_grid_walkable(grid_position, true)
	ManagerGame.unregister_unit(self)
	unit_died.emit(self)
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()
	return
