extends Area2D

@export var experiencia = 1

var spr_green = preload("res://Assets/Temp/Bubble.png")
var spr_blue = preload("res://Assets/Temp/Bubble.png")
var spr_red = preload("res://Assets/Temp/Bubble.png")



var target = null
var speed = 0



@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $AudioStreamPlayer2D

func _ready() -> void:
	if experiencia < 5 :
		return
	elif experiencia < 25:
		sprite.texture = spr_blue
	else:
		sprite.texture = spr_red
		
		
		
func _physics_process(delta: float) -> void:
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2*delta
		
		

func collect():
	sound.play()
	collision.call_deferred("set","disabled", true)
	sprite.visible = false
	return experiencia
	


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
