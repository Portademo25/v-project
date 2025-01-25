extends Sprite2D
class_name Player

@export var Speed : int = 200

func _process(delta: float) -> void:
	position += (Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized() * Speed) * delta
