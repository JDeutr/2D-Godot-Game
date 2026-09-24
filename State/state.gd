extends Node
class_name State

@onready var player: Player = owner as Player

signal transitioned(state: State, new_state_name: String)

func enter(_msg: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass
