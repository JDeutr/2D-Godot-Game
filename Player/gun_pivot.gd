extends Marker2D

const BULLET_SCENE := preload("res://Projectile/Projectile.tscn")

@export var fire_rate: float = 0.2
@export var bullet_velocity: float = 300
@export_range(0, 180) var firing_spread: float = 2;
@export var max_ammo: int = 30;
@export var reload_time: float = 4;

var current_ammo: int = max_ammo
var _can_fire: bool = true
var _aim_direction: Vector2

func _process(_delta: float) -> void:
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
		
	if Input.is_action_pressed("shoot") and _can_fire:
		_shoot()
		
	if Input.is_action_just_pressed("reload"):
		_reload()

func _shoot() -> void:
	if current_ammo == 0:
		_reload()
		
	_can_fire = false
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

	await get_tree().create_timer(1/fire_rate).timeout
	_can_fire = true


func _reload() -> void:
	print("RELOADING....")
