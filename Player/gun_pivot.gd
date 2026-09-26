extends Marker2D

const BULLET_SCENE := preload("res://Projectile/Projectile.tscn")

@export var fire_rate: float = 0.2
@export var bullet_velocity: float = 300
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

func _shoot() -> void:
	_can_fire = false
	var bullet := BULLET_SCENE.instantiate()
	bullet.setup($Gun/Muzzle.global_position, _aim_direction, bullet_velocity)
	get_tree().current_scene.add_child(bullet)

	await get_tree().create_timer(fire_rate).timeout
	_can_fire = true
