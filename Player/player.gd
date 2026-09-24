extends CharacterBody2D
class_name Player

@export var base_speed: int = 200
var speed: float

@onready var dodge: DodgeComponent = $DodgeComponent
@onready var move_state_machine: StateMachine = $MoveStateMachine
@onready var combat_state_machine: StateMachine = $CombatStateMachine

func _ready() -> void:
	speed = base_speed
	move_state_machine.start()
	combat_state_machine.start()
