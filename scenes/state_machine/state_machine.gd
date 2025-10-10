extends Node
class_name StateMachine

@export var state_start: StateBase
var states: Dictionary[String, StateBase] = {}
var state_cur: StateBase
var is_launched: bool = false

func _ready() -> void:
	for state: StateBase in self.get_children():
		states[state.state_name] = state
		state.state_changed.connect(on_state_changed)
	return

func launch() -> void:
	is_launched = true
	self.state_cur = self.state_start
	self.state_cur.enter()

func _process(delta: float) -> void:
	if self.is_launched:
		self.state_cur.on_process(delta)
	return

func _physics_process(delta: float) -> void:
	if self.is_launched:
		self.state_cur.on_physics_process(delta)
	return
	
func on_state_changed(state_name: String) -> void:
	var new_state: StateBase = self.states.get(state_name)
	if new_state != null:
		self.state_cur.exit()
		self.state_cur = new_state
		self.state_cur.enter()
	return
	
