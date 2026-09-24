extends State

func physics_update(_delta: float) -> void:
	var input_vec := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vec == Vector2.ZERO:
		transitioned.emit(self, "Idle")
		return
	player.velocity = input_vec * player.speed
	player.move_and_slide()

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("dodge") and player.dodge.try_dodge() and player.velocity != Vector2.ZERO:
		transitioned.emit(self, "Dodge")
