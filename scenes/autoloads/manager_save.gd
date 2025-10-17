extends Node

var data_saved: DataSave

func save_data(level_name: String) -> void:
	if data_saved == null:
		data_saved = DataSave.new()
	if not data_saved.level_completed.has(level_name):
		data_saved.level_completed.append(level_name)
	
	ResourceSaver.save(data_saved, "user://save_data.tres")

func load_data() -> DataSave:
	if not ResourceLoader.exists("user://save_data.tres"):
		return null
	data_saved = ResourceLoader.load("user://save_data.tres") as DataSave
	return data_saved
