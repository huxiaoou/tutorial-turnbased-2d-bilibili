extends Button

class_name UILevelCard

@onready var completed_tag: TextureRect = $CompletedTag

signal level_selected(resource_level: ResourceLevel)

var resource_level: ResourceLevel


func _ready() -> void:
	ManagerAudio.register_button(self)
	pressed.connect(on_button_pressed)


func setup(resource_level: ResourceLevel) -> void:
	self.resource_level = resource_level
	text = resource_level.level_name


func on_button_pressed() -> void:
	level_selected.emit(resource_level)
