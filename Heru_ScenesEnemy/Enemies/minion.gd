extends CharacterBody2D

@export var Target_Scene : PackedScene
@export var Speed : int = 25
@export var HP : int = 50

var target = null 

var lag = 0
var Hurt = false

func _ready() -> void:
	if Target_Scene:
		for child in get_parent().get_children():
			if child.scene_file_path == Target_Scene.resource_path:
				target = child
				break
	else:
		print("No hay ninguna escena asignada")

func _physics_process(delta: float) -> void:
	
	#Movimiento
	var target_position = target.position if target else Vector2(640, 360)
	var point = (target_position - position).normalized()
	var direction = point
	
	#lag = lag + (360 / 60) if lag < 360 else lag * 0
	var low = 1#abs(cos(deg_to_rad(lag)))
	
	direction = lerp(direction, point, 10)
	
	position += ((Speed * direction) * low) * delta
	#move_and_slide()


#func _hurt(power):
	#Hurt = true
	#HP -= power
	#modulate = Color.ORANGE_RED
	#await (get_tree().create_timer(0.2).timeout)
	#modulate = Color.WHITE
	#Hurt = false 


func _on_hurt_box_hurt(damage: Variant) -> void:
	HP -= damage
	if HP < 0:
		queue_free()
