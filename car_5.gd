extends Node2D  # или Sprite2D, если у тебя спрайт

@export var rotation_speed := 90  # градусов в секунду

func _process(delta):
	rotation_degrees += rotation_speed * delta
