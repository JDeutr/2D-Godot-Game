extends State

var dodge_direction: Vector2

func enter(_msg: Dictionary = {}) -> void:
	dodge_direction = player.velocity.normalized() if player.velocity != Vector2.ZERO else Vector2.DOWN
	player.dodge.action_timer.timeout.connect(_on_dodge_finished, CONNECT_ONE_SHOT)

func physics_update(_delta: float) -> void:
	player.velocity = dodge_direction * player.speed * player.dodge.dodge_mult
	player.move_and_slide()

func _on_dodge_finished() -> void:
	var input_vec := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	transitioned.emit(self, "Move" if input_vec != Vector2.ZERO else "Idle")
