extends Node
class_name Health

signal health_changed(health_point: int)

@export var max_health: int = 10
var cur_health: int

func _ready() -> void:
	cur_health = max_health

func take_damage(damage: int) -> void:
	cur_health = max(0, cur_health - damage)
	health_changed.emit(cur_health)
