extends Node
class_name StateMachine

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

# state_machine.gd
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_state_transitioned)

	if initial_state:
		current_state = initial_state
	elif not states.is_empty():
		current_state = states.values()[0]

func start() -> void:
	if current_state:
		current_state.enter()
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child

	if initial_state:
		current_state = initial_state
	elif not states.is_empty():
		current_state = states.values()[0]
	
	current_state.enter()

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _on_state_transitioned(state: State, new_state_name: String) -> void:
	if state != current_state:
		return
	var new_state: State = states.get(new_state_name.to_lower())
	if not new_state:
		push_warning("StateMachine: no state named '%s'" % new_state_name)
		return
	current_state.exit()
	current_state = new_state
	current_state.enter()
