extends CharacterBody2D


## - VARS - ##

var speed : int = 200
var lastVelocity : Vector2 = Vector2(0,0)
var dodgeMult : float = 2.5
var currMoveState : MoveState
var currCombatState : CombatState
var dodgeCharges : int = 3
var maxDodgeCharges : int = 3

@onready
var dodgeCooldown : Timer = $DodgeCooldown

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
	currMoveState = MoveState.NOT_MOVING
	currCombatState = CombatState.OUT_OF_COMBAT
	dodgeCooldown.set_wait_time(3)
	set_process_input(true)
	
	pass


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
	
	print(dodgeCharges)
	pass


## - ACTIONS - ##

func movePlayer():
	velocity = Input.get_vector(
		"move_left", 
		"move_right", 
		"move_up", 
		"move_down") * speed
	
	lastVelocity = velocity if velocity != Vector2.ZERO else lastVelocity
	
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
	dodgeCooldown.timeout.connect(_on_dodge_cooldown_timeout)
	if (dodgeCharges < maxDodgeCharges 
		and dodgeCooldown.is_stopped()):
			dodgeCooldown.start()

func moveStateController() -> void:
	if velocity == Vector2(0,0):
		currMoveState = MoveState.NOT_MOVING
		speed = 200
		
	elif !$DodgeActionTimer.is_stopped():
		currMoveState = MoveState.DODGING
		speed = 350
		
	else:
		currMoveState = MoveState.MOVING
		speed = 200

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
