# health_component.gd
class_name HealthComponent
extends Node

signal health_changed(current: int, max_value: int)
signal damaged(amount: int)
signal died

const MAX_ARMOUR := 10.0
const MAX_REDUCTION := 0.5

var max_health : int
var armour : int
var current: int

func setup(o_max_health: int, o_armour: int):
	max_health = o_max_health
	armour = o_armour
	current = max_health

func get_reduction() -> float:
	# Diminishing returns: armour 10 = 50%, armour 5 = 37.5%
	var t := clampf(armour / MAX_ARMOUR, 0.0, 1.0)
	return MAX_REDUCTION * (1.0 - pow(1.0 - t, 2.0))

func take_damage(amount: int) -> void:
	if current <= 0:
		return
	var final := maxi(1, roundi(amount * (1.0 - get_reduction())))
	current = maxi(0, current - final)
	damaged.emit(final)
	health_changed.emit(current, max_health)
	if current == 0:
		died.emit()

func heal(amount: int) -> void:
	current = mini(max_health, current + amount)
	health_changed.emit(current, max_health)
