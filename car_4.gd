extends Node2D

@export var speed := 130
@export var reset_y := 1000   # Начальная позиция (внизу)
@export var end_y := -2500     # Крайняя верхняя точка

func _process(delta):
	position.y -= speed * delta
	if position.y < end_y:
		position.y = reset_y
