extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var collision_shape_2d: CollisionShape2D = $"../CameraBoundary/CollisionShape2D"
@export var move_speed: int = 200

var lim_left: float
var lim_right: float
var lim_top: float
var lim_bottom: float

func _ready() -> void:
	var boundary_rect: Rect2 = collision_shape_2d.shape.get_rect()
	lim_left = collision_shape_2d.to_global(boundary_rect.position).x + get_viewport_rect().size.x / 2
	lim_top = collision_shape_2d.to_global(boundary_rect.position).y + get_viewport_rect().size.y / 2
	lim_right = collision_shape_2d.to_global(boundary_rect.end).x - get_viewport_rect().size.x / 2
	lim_bottom = collision_shape_2d.to_global(boundary_rect.end).y - get_viewport_rect().size.y / 2

func _process(delta: float) -> void:
	var move_direction: Vector2i = Input.get_vector("camera_move_left", "camera_move_right", "camera_move_up", "camera_move_down")
	var target_pos = global_position + move_direction * move_speed * delta
	target_pos.x = clamp(target_pos.x, lim_left, lim_right)
	target_pos.y = clamp(target_pos.y, lim_top, lim_bottom)
	global_position = target_pos
	return
