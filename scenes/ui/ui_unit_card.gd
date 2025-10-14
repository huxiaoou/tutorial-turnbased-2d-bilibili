extends Button
class_name UIUnitCard

signal unit_hovered(unit_resource: UnitResource)

@onready var selected_indicator: TextureRect = $SelectedIndicator

var unit_resource: UnitResource
var is_selected: bool = false

func _ready() -> void:
	pressed.connect(on_button_pressed)
	mouse_entered.connect(on_mouse_entered)
	selected_indicator.visible = false
	
func set_up(unit_resource: UnitResource) -> void:
	self.unit_resource = unit_resource
	text = unit_resource.unit_name
	
func on_button_pressed() -> void:
	if is_selected:
		is_selected = false
		selected_indicator.visible = false
	else:
		is_selected = true
		selected_indicator.visible = true
	
func on_mouse_entered() -> void:
	unit_hovered.emit(unit_resource)
	return
