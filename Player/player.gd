extends CharacterBody2D

## ---------- STATS ----------
var speed = 80 ## Rapidez del jugador
var health = 80 ## Vida actual del jugador
var max_health = 80 ## Vida máxima del jugador
var experiencia = 0 ## Experiencia a recolectar
var experiencia_level = 1 ## Level del personaje
var collected_experiencia = 0 ## coleccion de exp

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
@onready var expBar = get_node("%ExperienciaBar")
@onready var lbllevel = get_node("%lbl_level")
## ---------- FUNCIONES ----------
func _ready():
	attack()
	set_expBar(experiencia, calculate_experienciacap())

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


func _on_hurt_box_hurt(damage: Variant) -> void:
	health -= damage # Replace with function body.
	


func _on_grab_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		calculate_experiencia(gem_exp)
		
func calculate_experiencia(gem_exp):
	var exp_required = calculate_experienciacap()
	collected_experiencia += gem_exp
	if experiencia + collected_experiencia > exp_required:
		collected_experiencia -= exp_required-experiencia
		experiencia_level += 1
		lbllevel.text = str("Level ",experiencia_level)
		experiencia = 0
		exp_required = calculate_experienciacap()
		calculate_experiencia(0)
	else:
		experiencia += collected_experiencia
		collected_experiencia = 0
	set_expBar(experiencia,exp_required)

func calculate_experienciacap():
	var exp_cap = experiencia_level
	if experiencia_level < 25:
		exp_cap = experiencia_level*5
	elif experiencia_level < 40:
		exp_cap + 95 * (experiencia_level-19)*8
	else:
		exp_cap + 255 + (experiencia-39)*12
		
	return exp_cap

func set_expBar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value
	
