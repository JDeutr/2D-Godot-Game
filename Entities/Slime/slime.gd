extends CharacterBody2D
class_name Enemy

@onready var target = get_tree().get_first_node_in_group("player")

@export var health: HealthComponent;
@export var health_bar: ProgressBar;
@export var max_health: int = 100;
@export var armour: int = 5;
@export var speed: float = 50;
@export var sprite: Sprite2D;


func _ready() -> void:
	health.setup(max_health, armour)
	health_bar.setup(max_health)
	health_bar.max_value = max_health

func _physics_process(delta: float) -> void:
	move(delta)
	
func move(delta: float) -> void:
	var direction = (target.position - position).normalized()
	velocity = lerp(velocity, direction * speed, 8.5 * delta)
	move_and_slide()
	
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
		

func _on_health_component_died() -> void:
	queue_free();
