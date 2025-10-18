extends PanelContainer

@onready var ui_unit_selection: PanelContainer = $"../UIUnitSelection"
@onready var container_level: GridContainer = $MarginContainer/VBoxContainer/ContainerLevel
@export var scene_level_card_ui: PackedScene
@export var resources_level: Array[ResourceLevel]


func _ready() -> void:
	var data_save: DataSave = ManagerSave.load_data()
	for resource_level in resources_level:
		var ui_level_card: UILevelCard = scene_level_card_ui.instantiate()
		container_level.add_child(ui_level_card)
		ui_level_card.setup(resource_level)
		ui_level_card.level_selected.connect(on_level_selected)
		if data_save and data_save.level_completed.has(resource_level.level_name):
			ui_level_card.completed_tag.visible = true
	return


func on_level_selected(resource_level: ResourceLevel) -> void:
	ManagerGame.selected_level_resource = resource_level
	visible = false
	ui_unit_selection.visible = true
	return
