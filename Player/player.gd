extends CharacterBody2D

## ---------- STATS ----------
var speed = 80 ## Rapidez del jugador
var health = 80 ## Vida actual del jugador
var max_health = 80 ## Vida máxima del jugador

## ---------- ATAQUES ----------
var bubble_blast = preload("res://Player/Weapons/bubble_blast.tscn")

## Nodos de ataque
@onready var bubble_blast_timer = get_node("%BubbleBlastTimer")
@onready var bubble_blast_attack_timer = get_node("%BubbleBlastAttackTimer")

## Bubble Blast
var bubble_blast_ammo = 0 ## Cantidad de disparos
var bubble_blast_baseammo = 1 ## Cantidad de proyectiles por disparo
var bubble_blast_speed = 1.5 ## Rapidez de los proyectiles
var bubble_blast_level = 1 ## Nivel del arma

## ---------- ETC ----------
@onready var sprite = $Sprite2D ## Sprite del jugador

## ---------- FUNCIONES ----------
func _ready():
	attack()

func _physics_process(delta):
	movement()

func movement():
	## Controla el movimiento del jugador
	
	## Valores de los inputs
	var right = 1 if (Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D)) else 0
	var left = 1 if (Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A)) else 0
	var down = 1 if (Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S)) else 0
	var up = 1 if (Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W)) else 0
	
	## Dirección horizontal y vertical
	var x_direction = right - left
	var y_direction = down - up
	
	## Establece la orientación de la imagen
	if x_direction > 0:
		sprite.flip_h = false
	elif x_direction < 0:
		sprite.flip_h = true
	
	## Establece la velocidad
	velocity = speed * Vector2(x_direction, y_direction).normalized()
	move_and_slide()

func attack():
	## Controla el ataque del jugador
	
	## Bubble Blast
	if bubble_blast_level > 0:
		bubble_blast_timer.wait_time = bubble_blast_speed
		if bubble_blast_timer.is_stopped():
			bubble_blast_timer.start()

func _on_bubble_blast_timer_timeout():
	## Carga la munición
	bubble_blast_ammo = bubble_blast_baseammo
	bubble_blast_attack_timer.start()

func _on_bubble_blast_attack_timer_timeout():
	## Dispara el ataque
	if bubble_blast_ammo> 0:
		var bubble_blast_attack = bubble_blast.instantiate()
		bubble_blast_attack.position = position
		bubble_blast_attack.level = bubble_blast_level
		add_child(bubble_blast_attack)
		bubble_blast_ammo -= 1
		if bubble_blast_ammo > 0:
			bubble_blast_attack_timer.start()
		else :
			bubble_blast_attack_timer.stop()
