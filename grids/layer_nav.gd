extends TileMapLayer
class_name LayerNav

var a_star: AStarGrid2D
var grid_data_dict: Dictionary[Vector2i, DataGrid] = {}

func _ready() -> void:
	ManagerGrid.layer_nav = self
	self.initialize()
	return

func initialize() -> void:
	self.a_star = AStarGrid2D.new()
	self.a_star.region = get_used_rect()
	self.a_star.cell_size = tile_set.tile_size
	self.a_star.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	self.a_star.update()
	var used_cells: Array[Vector2i] = self.get_used_cells()
	for cell in used_cells:
		grid_data_dict[cell] = DataGrid.new()
		if not self.get_cell_tile_data(cell).get_custom_data("walkable"):
			self.a_star.set_point_solid(cell)
			grid_data_dict[cell].walkable = false
	return
