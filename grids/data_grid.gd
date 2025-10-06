class_name DataGrid

var walkable: bool = true
var occupant: Unit = null

func is_occupied_by_unit() -> bool:
	return self.occupant != null
