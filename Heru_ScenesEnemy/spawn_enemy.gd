extends Node2D

@export var Minion_Scene : PackedScene 
@export var Tanque_Scene : PackedScene
@export var Asesino_Scene : PackedScene
@export var Hydra_Scene : PackedScene

@export var Spawn_Minion : float = 2
@export var Spawn_Tanque : float = 5
@export var Spawn_Asesino : float = 3
@export var Spawn_Hydra : float = 2


func _ready() -> void:
	$Timer_Minion.wait_time = Spawn_Minion
	$Timer_Tanque.wait_time = Spawn_Tanque
	$Timer_Asesino.wait_time = Spawn_Asesino
	$Timer_Hydra.wait_time = Spawn_Hydra


func _process(delta: float) -> void:
	var player = get_parent().get_node("Player") 
	position = player.position if player else Vector2(1280 / 2, 720 / 2)


#Spawnear Minion
func _on_timer_minion_timeout() -> void:
	
	var RanMX = [position.x + $ZoneMinion.position.x, position.x + $ZoneMinion.position.x + $ZoneMinion.size.x]
	var RanMY = [position.y + $ZoneMinion.position.y, position.y + $ZoneMinion.position.y + $ZoneMinion.size.y]
	
	var minion = Minion_Scene.instantiate()
	get_parent().add_child(minion)
	
	minion.position.y = randi_range(RanMY[0], RanMY[1])
	
	if minion.position.y <= RanMY[0] + 20 or minion.position.y >= RanMY[1] - 20:
		minion.position.x = randi_range(RanMX[0], RanMX[1])
	else:
		minion.position.x = RanMX[randi_range(0, 1)]


#Spawnear tanque
func _on_timer_tanque_timeout() -> void:
	
	var RanTX = [position.x + $ZoneTanque.position.x, position.x + $ZoneTanque.position.x + $ZoneTanque.size.x]
	var RanTY = [position.y + $ZoneTanque.position.y, position.y + $ZoneTanque.position.y + $ZoneTanque.size.y]
	
	var tanque = Tanque_Scene.instantiate()
	get_parent().add_child(tanque)
	
	tanque.position.y = randi_range(RanTY[0], RanTY[1])
	
	if tanque.position.y <= RanTY[0] + 20 or tanque.position.y >= RanTY[1] - 20:
		tanque.position.x = randi_range(RanTX[0], RanTX[1])
	else:
		tanque.position.x = RanTX[randi_range(0, 1)]


#Spawnear Asesino
func _on_timer_asesino_timeout() -> void:
	
	var RanAX = [position.x + $ZoneAsesino.position.x, position.x + $ZoneAsesino.position.x + $ZoneAsesino.size.x]
	var RanAY = [position.y + $ZoneAsesino.position.y, position.y + $ZoneAsesino.position.y + $ZoneAsesino.size.y]
	
	var asesino = Asesino_Scene.instantiate()
	get_parent().add_child(asesino)
	
	asesino.position.y = randi_range(RanAY[0], RanAY[1])
	
	if asesino.position.y <= RanAY[0] + 20 or asesino.position.y >= RanAY[1] - 20:
		asesino.position.x = randi_range(RanAX[0], RanAX[1])
	else:
		asesino.position.x = RanAX[randi_range(0, 1)]


#Spawnear Hydra
func _on_timer_hydra_timeout() -> void:
	pass # Replace with function body.
