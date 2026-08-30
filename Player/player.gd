extends CharacterBody2D

var speed : int = 200
var lastVelocity : Vector2 = Vector2(0,0)
var dodgeMult : float = 2.5

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

func _process(delta: float) -> void:
	
	
	pass

func _physics_process(delta: float) -> void:
	movePlayer()
	
	pass

func dodge() -> void:
	velocity = lastVelocity * dodgeMult
	print("DODGING")

func movePlayer():
	velocity = Input.get_vector(
		"move_left", 
		"move_right", 
		"move_up", 
		"move_down") * speed
	
	lastVelocity = velocity if velocity != Vector2.ZERO else lastVelocity
	
	move_and_slide()
