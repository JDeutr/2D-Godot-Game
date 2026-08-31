extends CharacterBody2D

## - CONSTS - ##



## - VARS - ##

var currMoveState : MoveState
var currCombatState : CombatState
var dodgeCharges : int = 3
var maxDodgeCharges : int = 3
var lastVelocity : Vector2 = Vector2(0,0)

@onready var dodgeCooldown : Timer = $DodgeCooldown

@export var BASE_SPEED : int = 200
@export var DODGE_MULTIPLIER : float = 2
@export var speed : float
@export var dodgeMult : float = 2.5

enum MoveState {
	NOT_MOVING,
	MOVING,
	DODGING
}

enum CombatState {
	OUT_OF_COMBAT,
	ATTACKING,
	RELOADING
}

func _ready() -> void:
	# INIT TROEP OP LEVEL START
	set_process_input(true)
	
	# STATE
	currMoveState = MoveState.NOT_MOVING
	currCombatState = CombatState.OUT_OF_COMBAT
	
	dodgeCooldown.set_wait_time(3)
	if !dodgeCooldown.timeout.is_connected(_on_dodge_cooldown_timeout):
		dodgeCooldown.timeout.connect(_on_dodge_cooldown_timeout)


## - PROCESSES - ##

func _process(delta: float) -> void:

	pass

func _physics_process(delta: float) -> void:
	# CONTROLLER SHIT
	moveStateController()
	combatStateController()

	# OTHER SHIT
	movePlayer()
	checkDodgeCharges()


## - ACTIONS - ##

func movePlayer():
	lastVelocity = velocity if velocity != Vector2.ZERO else lastVelocity

	velocity = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down") * speed


	move_and_slide()

func dodge() -> void:
	# Check currState
	# If currState != dodging, set to dodging (if not on Cooldown and no charges)
	# If currState = dodging, do nothing
	if (currMoveState != MoveState.DODGING
		and dodgeCharges > 0
		and $DodgeActionTimer.is_stopped()):
			dodgeCharges -= 1
			$DodgeActionTimer.start(0.3)

func checkDodgeCharges() -> void:
	if (dodgeCharges < maxDodgeCharges
		and dodgeCooldown.is_stopped()):
			dodgeCooldown.start()

func moveStateController() -> void:
	if velocity == Vector2(0,0):
		currMoveState = MoveState.NOT_MOVING
		speed = BASE_SPEED

	elif !$DodgeActionTimer.is_stopped():
		currMoveState = MoveState.DODGING
		speed = DODGE_MULTIPLIER * BASE_SPEED

	else:
		currMoveState = MoveState.MOVING
		speed = BASE_SPEED

func combatStateController() -> void:
	pass


## - INPUTS - ##

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dodge"):
		dodge()


## - CONNECTORS - ##

func _on_dodge_cooldown_timeout() -> void:
	if dodgeCharges < maxDodgeCharges:
		dodgeCharges += 1
	pass # Replace with function body.
