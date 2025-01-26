extends Area2D

@export var damage = 1
@onready var collision = $CollisionShape2D
@onready var disabletimer = $DisableHitBoxTimer



func tempdisable():
	collision.call_deferred("set","disabled", true)
	disabletimer.start()


func _on_disable_hit_box_timer_timeout() -> void:
	collision.call_deferred("set","disabled", false)
