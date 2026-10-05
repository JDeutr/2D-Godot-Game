extends Marker2D

const BUFFER_TIME: float = 0.1

@export var bullet_scene: PackedScene = preload("res://weapons/projectiles/rocket/rocket.tscn")
@export var fire_rate: float = 5  # shots per second
@export var bullet_velocity: float = 300
@export_range(0, 360) var firing_spread: float = 2
@export var max_ammo: int = 304
@export var reload_time: float = 4
@export var _projectile_amount: int = 1

var current_ammo: int = max_ammo

var _aim_direction: Vector2
var _fire_accumulator: float = 0.0
var _cooldown: float = 0.0
var _buffer_timer: float = 0.0


func _process(delta: float) -> void:
	var mouse_pos := get_global_mouse_position()
	_aim_direction = (mouse_pos - global_position).normalized()
	rotation = (mouse_pos - global_position).angle() - PI

	if mouse_pos.x > global_position.x:
		scale.y = -1
	else:
		scale.y = 1

	if mouse_pos.y > global_position.y:
		z_index = 1
	else:
		z_index = -1

	for n in _projectile_amount:
		_handle_shooting(delta)

	if Input.is_action_just_pressed("reload"):
		_reload()


func _handle_shooting(delta: float) -> void:
	_cooldown -= delta
	_buffer_timer = maxf(_buffer_timer - delta, 0.0)

	if Input.is_action_just_pressed("shoot"):
		_buffer_timer = BUFFER_TIME

	var wants_to_shoot := Input.is_action_pressed("shoot") or _buffer_timer > 0.0
	if not wants_to_shoot:
		_cooldown = maxf(_cooldown, 0.0)
		return

	var interval := 1.0 / fire_rate
	var shots_fired := 0
	while _cooldown <= 0.0 and shots_fired < 10:
		_shoot()
		_cooldown += interval
		_buffer_timer = 0.0
		shots_fired += 1

	_cooldown = maxf(_cooldown, 0.0)


func _shoot() -> void:
	current_ammo -= 1
	$GunSound.play(0)

	var bullet := bullet_scene.instantiate()
	var spread = deg_to_rad(randf_range(-firing_spread / 2, firing_spread / 2))
	var firing_direction = _aim_direction.rotated(spread)

	bullet.setup($Gun/Muzzle.global_position, firing_direction, bullet_velocity)

	get_tree().current_scene.add_child(bullet)


func _reload() -> void:
	print("RELOADING....")
