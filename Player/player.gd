extends CharacterBody2D

## ---------- STATS ----------
var speed = 80 ## Rapidez del jugador
var health = 80 ## Vida actual del jugador
var max_health = 80 ## Vida máxima del jugador

## ---------- ATAQUES ----------
var bubble_blast = preload("res://Player/Weapons/bubble_blast.tscn")
var bubble_beam = preload("res://Player/Weapons/bubble_beam.tscn")
var whirlpool = preload("res://Player/Weapons/whirlpool.tscn")

## Nodos de ataque
@onready var bubble_blast_timer = get_node("%BubbleBlastTimer")
@onready var bubble_blast_attack_timer = get_node("%BubbleBlastAttackTimer")
@onready var bubble_beam_timer = get_node("%BubbleBeamTimer")
@onready var bubble_beam_attack_timer = get_node("%BubbleBeamAttackTimer")
@onready var whirlpool_timer = get_node("%WhirlpoolTimer")
@onready var whirlpool_attack_timer = get_node("%WhirlpoolAttackTimer")

## Bubble Blast
var bubble_blast_ammo = 0 ## Cantidad de disparos
var bubble_blast_baseammo = 5 ## Cantidad de proyectiles por disparo
var bubble_blast_speed = 1.5 ## Rapidez de los proyectiles
var bubble_blast_level = 1 ## Nivel del arma

## Bubble Beam
var bubble_beam_ammo = 0 ## Cantidad de disparos
var bubble_beam_baseammo = 20 ## Cantidad de proyectiles por disparo
var bubble_beam_speed = 4 ## Rapidez de los proyectiles
var bubble_beam_level = 0 ## Nivel del arma
var bubble_beam_direction = Vector2.ZERO ## Dirección del disparo

## Whirlpool
var whirlpool_ammo = 0 ## Cantidad de disparos
var whirlpool_baseammo = 1 ## Cantidad de proyectiles por disparo
var whirlpool_speed = 10 ## Rapidez de los proyectiles
var whirlpool_level = 0 ## Nivel del arma

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
		sprite.flip_h = true
	elif x_direction < 0:
		sprite.flip_h = false
	
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
	
	## Bubble Beam
	if bubble_beam_level > 0:
		bubble_beam_timer.wait_time = bubble_beam_speed
		if bubble_beam_timer.is_stopped():
			bubble_beam_timer.start()
	
	## Whirlpool
	if whirlpool_level > 0:
		whirlpool_timer.wait_time = whirlpool_speed
		if whirlpool_timer.is_stopped():
			whirlpool_timer.start()

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

func _on_bubble_beam_timer_timeout():
	## Carga la munición
	bubble_beam_ammo = bubble_beam_baseammo
	bubble_beam_direction = global_position.direction_to(get_global_mouse_position())
	bubble_beam_attack_timer.start()

func _on_bubble_beam_attack_timer_timeout():
	## Dispara el ataque
	if bubble_beam_ammo> 0:
		var bubble_beam_attack = bubble_beam.instantiate()
		bubble_beam_attack.position = position
		bubble_beam_attack.level = bubble_beam_level
		bubble_beam_attack.direction = bubble_beam_direction
		add_child(bubble_beam_attack)
		bubble_beam_ammo -= 1
		if bubble_beam_ammo > 0:
			bubble_beam_attack_timer.start()
		else :
			bubble_beam_attack_timer.stop()

func _on_whirlpool_timer_timeout():
	## Carga la munición
	whirlpool_ammo = whirlpool_baseammo
	whirlpool_attack_timer.start()

func _on_whirlpool_attack_timer_timeout():
	## Dispara el ataque
	if whirlpool_ammo> 0:
		var whirlpool_attack = whirlpool.instantiate()
		whirlpool_attack.position = position
		whirlpool_attack.level = whirlpool_level
		add_child(whirlpool_attack)
		whirlpool_ammo -= 1
		if whirlpool_ammo > 0:
			whirlpool_attack_timer.start()
		else :
			whirlpool_attack_timer.stop()


func _on_hurt_box_hurt(damage: Variant) -> void:
	health -= damage # Replace with function body.
	
