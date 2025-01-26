extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disabletimer = $DisableTimer

signal hurt(damage)

#area de hurtbox 
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: #Cooldown
					collision.call_deferred("set","disabled", true)
					disabletimer.start()
				1: #HitOnce
					pass
				2: #DisableHitBox
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			emit_signal("hurt",damage)
			if area.has_method("hit"):
				area.hit(1)


func _on_disable_timer_timeout() -> void:
	collision.call_deferred("set","disabled", false)
