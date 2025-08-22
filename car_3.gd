extends Node2D

@export var speed := 80
@export var reset_y := -1500   # Верхняя стартовая позиция
@export var end_y := 2200      # Нижняя граница (конец пути)

func _process(delta):
	position.y += speed * delta
	if position.y > end_y:
		position.y = reset_y
