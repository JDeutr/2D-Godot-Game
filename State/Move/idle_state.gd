extends State

func enter(_msg: Dictionary = {}) -> void:
	player.velocity = Vector2.ZERO

func physics_update(_delta: float) -> void:
	var input_vec := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vec != Vector2.ZERO:
		transitioned.emit(self, "Move")
		return
	player.move_and_slide()

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("dodge") and player.dodge.try_dodge():
		transitioned.emit(self, "Dodge")
