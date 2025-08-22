extends Node2D

@export var speed := 150
@export var turn_x := 500               # расстояние по прямой до поворота
@export var end_distance := 3000         # расстояние после поворота
@export var start_angle := 34           # начальный угол движения
@export var turn_angle := -34           # угол поворота

var has_turned := false
var direction := Vector2.RIGHT.rotated(deg_to_rad(start_angle))
var tween: Tween
var start_position: Vector2
var turn_position: Vector2
var traveled_after_turn := 0.0

func _ready():
	start_position = position
	rotation_degrees = start_angle
	turn_position = position + direction.normalized() * turn_x

func _process(delta):
	if not has_turned:
		var move = direction * speed * delta
		position += move

		# Проверка расстояния до точки поворота
		if position.distance_to(turn_position) <= speed * delta:
			has_turned = true

			# Анимация поворота
			tween = create_tween()
			tween.tween_property(self, "rotation_degrees", start_angle + turn_angle, 1.5)
			await tween.finished

			# Меняем направление
			direction = direction.rotated(deg_to_rad(turn_angle))
			traveled_after_turn = 0.0
	else:
		var move = direction * speed * delta
		position += move
		traveled_after_turn += move.length()

		if traveled_after_turn >= end_distance:
			reset_car()

func reset_car():
	position = start_position
	rotation_degrees = start_angle
	direction = Vector2.RIGHT.rotated(deg_to_rad(start_angle))
	has_turned = false
	turn_position = position + direction.normalized() * turn_x
	traveled_after_turn = 0.0
