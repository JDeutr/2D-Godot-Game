extends State

#@onready var hitbox: Hitbox = player.weapon_hitbox 

func enter(_msg: Dictionary = {}) -> void:
	pass
	#hitbox.monitoring = true
	#await get_tree().create_timer(0.2).timeout  
	#hitbox.monitoring = false
	#transitioned.emit(self, "OutOfCombat")
