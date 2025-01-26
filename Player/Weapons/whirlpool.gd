extends Area2D

## Variables
var level = 1 ## Nivel del arma
var damage = 1 ## Daño provocado por el proyectil
var knockback = 100 ## Retroceso del enemigo al impactar con el proyectil
var size = 8.0 ## Tamaño del proyectil

var direction = Vector2.ZERO ## Dirección del disparo

@onready var player = get_tree().get_root().get_node("Player") ## Nodo del jugador

func _ready():
	## Establece la dirección según la posición del mouse
	direction = global_position.direction_to(get_global_mouse_position())
	
	## Establece los stats según el nivel
	match level:
		1:
			damage = 1
			knockback = 100
			size = 8.0
	
	## Crea un tween (una pequeña animación generada por código)
	scale = 0.1 * Vector2(size, size)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(size, size), 1)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 2)
	tween.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

func _physics_process(delta):
	## Cambia la posición y rotación del proyectil
	position = player.position
	rotation -= 2 * delta

func _on_timer_timeout():
	## Destruye el proyectil cuando el tiempo llega a cero
	queue_free()
