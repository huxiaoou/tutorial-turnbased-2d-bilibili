extends Node
class_name	ActionBase

@export var action_id: String
@export var action_name: String
@export var action_icon: Texture2D
@export var grid_color: Color = Color.WHITE
@export var action_point_cost: int = 1

var unit: Unit
var is_active: bool = false
var on_action_finished: Callable

func _ready() -> void:
	self.unit = self.owner
	# print("Owner = " + str(self.owner)) # Unit
	# print("Parent = " + str(self.get_parent())) # ManagerActions

func start(_target_grid_position: Vector2i, _on_action_finished: Callable) -> void:
	print("Start Action " + self.action_name)
	self.is_active = true
	self.on_action_finished = _on_action_finished
	self.unit.cur_action_point -= self.action_point_cost
	
func finish() -> void:
	self.is_active = false
	self.on_action_finished.call()

func get_action_grids(_unit_grid: Vector2i = self.unit.grid_position) -> Array[Vector2i]:
	return []

func is_obstacle(grid_position: Vector2i) -> bool:
	if ManagerGrid.is_grid_occupied(grid_position):
		return false
	return not ManagerGrid.is_grid_walkable(grid_position)
	
func is_occupant_ally(grid_position: Vector2i) -> bool:
	if not ManagerGrid.is_grid_occupied(grid_position):
		return false
	return ManagerGrid.get_grid_occupant(grid_position).is_enemy == unit.is_enemy

func hit_obstacle(starting_grid: Vector2i, ending_grid: Vector2i) -> bool:
	var starting_pos: Vector2 = ManagerGrid.get_world_position(starting_grid)
	var ending_pos: Vector2 = ManagerGrid.get_world_position(ending_grid)
	var query_param = PhysicsRayQueryParameters2D.create(starting_pos, ending_pos, 2)
	var result:Dictionary = get_tree().root.world_2d.direct_space_state.intersect_ray(query_param)
	return not result.is_empty()
	
