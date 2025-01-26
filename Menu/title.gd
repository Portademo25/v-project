extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_but_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")


func _on_quit_butts_pressed() -> void:
	get_tree().quit()


func _on_options_buts_pressed() -> void:
	pass # Replace with funz
