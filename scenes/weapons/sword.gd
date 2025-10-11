extends Node2D
class_name Sword

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var finish_action: Callable
var unit: Unit
var damage: int = 5
var target: Unit

func set_up(_finish_action: Callable, _unit: Unit, target_grid_position: Vector2i) -> void:
	self.finish_action = _finish_action
	self.unit = _unit
	target = ManagerGrid.get_grid_occupant(target_grid_position)
	animation_player.play("attack")
	if target_grid_position.y > unit.grid_position.y:
		self.rotation_degrees = 180
	elif target_grid_position.y < unit.grid_position.y:
		self.rotation_degrees = 0
	else:
		self.rotation_degrees = 90
	
func deal_damage() -> void:
	if target != null and target.is_enemy != unit.is_enemy:
		target.take_damage(self.damage)

func animation_finished() -> void:
	self.finish_action.call()
	queue_free()
	return
