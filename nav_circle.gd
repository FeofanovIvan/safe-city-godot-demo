extends Control

@onready var arrow: TextureRect = $Arrow
@onready var nav_panel = get_node("/root/Main/CanvasLayer/NavPanel")
@onready var player_shape = get_node("/root/Main/Player/CollisionShape2D")  # Точное указание на CollisionShape2D

func _process(delta):
	var camera := get_viewport().get_camera_2d()
	if camera == null:
		print("Камера не найдена")
		return

	if nav_panel == null:
		print("NavPanel не найден")
		return

	if player_shape == null:
		print("CollisionShape2D игрока не найден")
		return

	var target_world_position = nav_panel.get_current_target_position()
	if target_world_position == null:
		print("Цель не установлена")
		return

	# Получаем глобальную позицию коллизионного центра игрока
	var player_pos: Vector2 = player_shape.get_global_transform().origin

	# Вектор направления от игрока к цели
	var direction = (target_world_position - player_pos).normalized()

	# Угол поворота стрелки
	arrow.rotation = direction.angle()
