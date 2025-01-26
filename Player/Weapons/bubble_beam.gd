extends Area2D

## Variables
var level = 1 ## Nivel del arma
var hits = 1 ## Número de impactos que puede recibir el proyectil
var speed = 100 ## Rapidez del proyectil
var damage = 5 ## Daño provocado por el proyectil
var knockback = 100 ## Retroceso del enemigo al impactar con el proyectil
var size = 1.0 ## Tamaño del proyectil

var direction = Vector2.ZERO ## Dirección del disparo

@onready var player = get_tree().get_root().get_node("Player") ## Nodo del jugador

func _ready():
	## Establece los stats según el nivel
	match level:
		1:
			hits = 1
			speed = 400
			damage = 5
			knockback = 100
			size = 1.0
	
	## Crea un tween (una pequeña animación generada por código)
	scale = 0.1 * Vector2(size, size)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(size, size), 1)
	tween.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

func _physics_process(delta):
	## Cambia la posición del proyectil
	position += speed * direction * delta

func hit():
	## Controla el impacto del proyectil con un enemigo
	hits -= 1
	if hits <= 0:
		queue_free()

func _on_timer_timeout():
	## Destruye el proyectil cuando el tiempo llega a cero
	queue_free()
