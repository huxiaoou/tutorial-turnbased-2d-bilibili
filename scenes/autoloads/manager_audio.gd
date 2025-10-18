extends Node

@onready var audio_player_click_sound: AudioStreamPlayer = $AudioPlayerClickSound
@onready var audio_player_music: AudioStreamPlayer = $AudioPlayerMusic


func _ready() -> void:
	audio_player_music.finished.connect(on_music_finished)


func register_button(button: Button) -> void:
	button.pressed.connect(on_button_pressed)


func on_music_finished() -> void:
	audio_player_music.play()


func on_button_pressed() -> void:
	audio_player_click_sound.play()
