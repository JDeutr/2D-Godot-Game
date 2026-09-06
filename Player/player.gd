extends CharacterBody2D
class_name Player

@export var base_speed: int = 200
var speed: float

@onready var dodge: DodgeComponent = $DodgeComponent
@onready var move_state_machine: StateMachine = $MoveStateMachine
@onready var combat_state_machine: StateMachine = $CombatStateMachine

func _ready() -> void:
	speed = base_speed
	_assign_player_ref(move_state_machine)
	_assign_player_ref(combat_state_machine)
	move_state_machine.start()
	combat_state_machine.start()

func _assign_player_ref(sm: StateMachine) -> void:
	for state in sm.states.values():
		state.player = self
