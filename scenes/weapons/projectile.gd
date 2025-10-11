extends Node2D
class_name Projectile

@export var damage: int = 5
@export var speed: float = 500

var finish_action: Callable
var unit: Unit
var target_grid_position: Vector2i
var target_world_position: Vector2

func set_up(_finish_action: Callable, _unit: Unit, _target_grid_position) -> void:
	self.finish_action = _finish_action
	self.unit = _unit
	self.target_grid_position = _target_grid_position
	self.target_world_position = ManagerGrid.get_world_position(_target_grid_position)
	look_at(target_world_position)
	
func deal_damage() -> void:
	var target: Unit = ManagerGrid.get_grid_occupant(self.target_grid_position)
	if target and target.is_enemy != unit.is_enemy:
		target.take_damage(damage)

func _process(delta: float) -> void:
	self.global_position = self.global_position.move_toward(target_world_position, delta * self.speed)
	if self.global_position == self.target_world_position:
		self.deal_damage()
		self.finish_action.call()
		queue_free()
		
