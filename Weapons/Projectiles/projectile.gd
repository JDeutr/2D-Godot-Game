extends Area2D

@export var speed: float = 4.0
@export var lifetime: float = 1.0
@export var damage_component: DamageComponent

var direction: Vector2 = Vector2.RIGHT

func setup(spawn_position: Vector2, 
 			fire_direction: Vector2, 
			velocity: float,
			damage: int,
			pierce: int) -> void:
	global_position = spawn_position
	direction = fire_direction
	rotation = fire_direction.angle()
	speed = velocity
	
	damage_component.setup(damage, pierce)


func _ready() -> void:
	$Lifetime.wait_time = lifetime
	$Lifetime.one_shot = true
	$Lifetime.timeout.connect(queue_free)
	$Lifetime.start()


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_damage_component_finished() -> void:
	queue_free()
