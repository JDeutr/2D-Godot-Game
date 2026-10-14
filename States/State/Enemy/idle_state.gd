extends State

var speed: float = 50;

func physics_update(_delta: float) -> void:
	var enemy = owner as Enemy
	if is_instance_valid(enemy) and is_instance_valid(enemy.target):
		transitioned.emit(self, "Move")
		return
