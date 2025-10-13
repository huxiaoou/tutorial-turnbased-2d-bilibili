extends Node2D

@onready var bar_health: ProgressBar = $BarHealth
@onready var label_action_point: Label = $LabelActionPoint

@export var unit: Unit
@export var health: Health

func _ready() -> void:
	health.health_changed.connect(on_health_changed)
	unit.action_points_changed.connect(on_action_points_changed)
	call_deferred("initialize")
	
func initialize() -> void:
	bar_health.min_value = 0
	bar_health.max_value = health.max_health
	bar_health.value = health.cur_health
	
func on_health_changed(health_point: int) -> void:
	bar_health.value = health_point
	
func on_action_points_changed(action_point: int) -> void:
	label_action_point.text = str(action_point)
