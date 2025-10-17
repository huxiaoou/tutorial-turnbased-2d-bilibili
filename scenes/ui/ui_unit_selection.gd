extends PanelContainer

@onready var ui_level_selection: PanelContainer = $"../UILevelSelection"
@onready var button_start: Button = $MarginContainer/VBoxContainer/ContainerButton/ButtonStart
@onready var button_back: Button = $MarginContainer/VBoxContainer/ContainerButton/ButtonBack
@onready var container_unit_card: VBoxContainer = $MarginContainer/VBoxContainer/ContainerUnitsInfo/UnitSelection/ContainerUnitCard
@onready var icon_unit: TextureRect = $MarginContainer/VBoxContainer/ContainerUnitsInfo/UnitInfo/MarginContainer/VBoxContainer/IconName/IconUnit
@onready var name_unit: Label = $MarginContainer/VBoxContainer/ContainerUnitsInfo/UnitInfo/MarginContainer/VBoxContainer/IconName/NameUnit
@onready var description_unit: Label = $MarginContainer/VBoxContainer/ContainerUnitsInfo/UnitInfo/MarginContainer/VBoxContainer/DescriptionUnit

@export var scene_ui_unit_card: PackedScene
@export var unit_resources: Array[UnitResource]

func _ready() -> void:
	button_start.pressed.connect(on_button_start_pressed)
	button_back.pressed.connect(on_button_back_pressed)
	for unit_resource in unit_resources:
		var ui_unit_card: UIUnitCard = scene_ui_unit_card.instantiate()
		container_unit_card.add_child(ui_unit_card)
		ui_unit_card.set_up(unit_resource)
		ui_unit_card.unit_hovered.connect(on_unit_hovered)
		ui_unit_card.unit_selected.connect(on_unit_selected)
		ui_unit_card.unit_deselected.connect(on_unit_deselected)
	
func on_button_start_pressed() -> void:
	get_tree().change_scene_to_packed(ManagerGame.selected_level_resource.level_scene)
	return

func on_button_back_pressed() -> void:
	ui_level_selection.visible = true
	visible = false
	return

func on_unit_hovered(unit_resource: UnitResource) -> void:
	icon_unit.texture = unit_resource.unit_icon
	name_unit.text = unit_resource.unit_name
	description_unit.text = unit_resource.unit_description

func on_unit_selected(unit_resource: UnitResource) -> void:
	ManagerGame.selected_player_resources.append(unit_resource)
	return

func on_unit_deselected(unit_resource: UnitResource) -> void:
	ManagerGame.selected_player_resources.erase(unit_resource)
	return
