extends AnimatedSprite2D

@onready var player: Player = owner as Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sprite_frames.has_animation("Idle-forward"):
		sprite_frames.set_animation_speed("Idle-forward", 1)
	if sprite_frames.has_animation("Idle-back"):
		sprite_frames.set_animation_speed("Idle-back", 1)


func _physics_process(delta: float) -> void:
	var direction = get_global_mouse_position() - player.global_position
	var facing_back = direction.y < 0

	var current_state_name = player.move_state_machine.current_state.name
	var anim_name = ""

	match current_state_name:
		"Move":
			anim_name = "Walk-back" if facing_back else "Walk-forward"
		"Idle":
			anim_name = "Idle-back" if facing_back else "Idle-forward"

	if anim_name != "" and animation != anim_name:
		play(anim_name)

	if direction.x != 0:
		flip_h = direction.x > 0
