extends Node
class_name DodgeComponent

@export var dodge_mult: float = 2.5
@export var max_charges: int = 3
@export var cooldown_time: float = 3.0
@export var dodge_duration: float = 0.3

var charges: int

signal dodgeCharges_changed(charges)

@onready var cooldown: Timer = $DodgeCooldown
@onready var action_timer: Timer = $DodgeActionTimer

func _ready() -> void:
	charges = max_charges
	dodgeCharges_changed.emit(charges)

	cooldown.wait_time = cooldown_time
	cooldown.one_shot = true
	action_timer.one_shot = true
	cooldown.timeout.connect(_on_cooldown_timeout)

func try_dodge() -> bool:
	if charges <= 0:
		return false
	charges -= 1
	dodgeCharges_changed.emit(charges)
	action_timer.start(dodge_duration)
	if cooldown.is_stopped():
		cooldown.start()
	return true

func _on_cooldown_timeout() -> void:
	if charges < max_charges:
		charges += 1
		cooldown.start()
		dodgeCharges_changed.emit(charges)
