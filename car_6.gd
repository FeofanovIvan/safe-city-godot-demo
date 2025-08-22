extends Node2D

@export var speed := 150
@export var turn_x := 3000
@export var end_distance := 500  # расстояние после поворота
@export var turn_angle := 30     # угол поворота (в градусах)

var has_turned := false
var direction := Vector2.RIGHT
var tween: Tween
var start_position: Vector2
var turn_position_x: float

func _ready():
	start_position = position  # сохраняем изначальную позицию объекта
	reset_car()

func _process(delta):
	if not has_turned:
		position += direction * speed * delta

		if position.x >= turn_position_x:
			has_turned = true
			tween = create_tween()
			tween.tween_property(self, "rotation_degrees", turn_angle, 1.0)
			await tween.finished

			direction = Vector2.RIGHT.rotated(deg_to_rad(turn_angle))

	else:
		position += direction * speed * delta

		# Вычисляем расстояние от точки поворота
		var distance_from_turn = position.distance_to(Vector2(turn_position_x, start_position.y))

		if distance_from_turn >= end_distance:
			reset_car()

func reset_car():
	position = start_position
	rotation_degrees = 0
	direction = Vector2.RIGHT
	has_turned = false
	turn_position_x = position.x + (turn_x - start_position.x)
