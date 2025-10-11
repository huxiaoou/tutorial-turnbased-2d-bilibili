extends Node2D
class_name Bow

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var point_shoot: Node2D = $PointShoot
@export var scene_arrow: PackedScene

var finish_action: Callable
var unit: Unit
var target_grid_position: Vector2i

func setup(_finish_action: Callable, _unit: Unit, _target_grid_position: Vector2i) -> void:
	self.finish_action = _finish_action
	self.unit = _unit
	self.target_grid_position = _target_grid_position
	if target_grid_position.y > unit.grid_position.y:
		self.rotation_degrees = 90
	if target_grid_position.y < unit.grid_position.y:
		self.rotation_degrees = -90
	animation_player.play("shoot")

func shoot() -> void:
	var arrow: Projectile = self.scene_arrow.instantiate()
	get_tree().current_scene.add_child(arrow)
	arrow.global_position = point_shoot.global_position
	arrow.set_up(self.finish_action, self.unit, self.target_grid_position)
