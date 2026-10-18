class_name DamageComponent
extends Area2D

signal hit(target: Node)
signal finished 

var damage: int
var pierce: int

func _ready() -> void:
	collision_layer = 0
	body_entered.connect(_on_body_entered)
	
func setup(o_damage: int, o_pierce: int):
	damage = o_damage
	pierce = o_pierce

func _on_body_entered(body: Node) -> void:
	var health := body.get_node_or_null("HealthComponent") as HealthComponent
	if health == null:
		return
		
	health.take_damage(damage)
	hit.emit(body)
	
	if pierce <= 0:
		finished.emit()
	else:
		pierce -= 1
