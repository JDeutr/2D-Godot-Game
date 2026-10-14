extends CharacterBody2D
class_name Enemy

@onready var target = get_tree().get_first_node_in_group("player")
@onready var move_state_machine: StateMachine = $MoveStateMachine

const maxHealth: float = 200
var currentHealth: float = maxHealth

@export var speed: float = 50;
@export var sprite: Sprite2D;

func _ready() -> void:
	$HP.max_value = maxHealth
	$HP.value = currentHealth
	move_state_machine.start()

func take_damage(damage: int):
	currentHealth -= damage
	$HP.visible = true
	$HP.value = currentHealth
	$Timer.start(1.0)
	
	if currentHealth <= 0:
		queue_free()


func _on_timer_timeout() -> void:
	$HP.visible = false;
