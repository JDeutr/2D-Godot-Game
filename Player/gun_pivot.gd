extends Marker2D

const BULLET_SCENE := preload("res://Projectile/Projectile.tscn")

@export var fire_rate: float = 5  # shots per second
@export var bullet_velocity: float = 300
@export_range(0, 360) var firing_spread: float = 2;
@export var max_ammo: int = 30;
@export var reload_time: float = 4;

var current_ammo: int = max_ammo
var _aim_direction: Vector2
var _fire_accumulator: float = 0.0

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

	var fire_interval := 1.0 / fire_rate

	if Input.is_action_just_pressed("shoot"):
		_shoot()
		_fire_accumulator = 0.0
	elif Input.is_action_pressed("shoot"):
		_fire_accumulator += delta
		var shots_fired := 0
		while _fire_accumulator >= fire_interval and shots_fired < 10:
			_shoot()
			_fire_accumulator -= fire_interval
			shots_fired += 1
	else:
		_fire_accumulator = 0.0

	if Input.is_action_just_pressed("reload"):
		_reload()

func _shoot() -> void:
	#if current_ammo == 0:
		#_reload()
		#return

	current_ammo -= 1
	$AudioStreamPlayer2D.play(0)

	var bullet := BULLET_SCENE.instantiate()
	var spread = deg_to_rad(
		randf_range(-firing_spread/2, firing_spread/2))
	var firing_direction = _aim_direction.rotated(spread)

	bullet.setup(
		$Gun/Muzzle.global_position,
		firing_direction,
		bullet_velocity)

	get_tree().current_scene.add_child(bullet)

func _reload() -> void:
	print("RELOADING....")
