extends CharacterBody2D

const SPEED = 100
@onready var sprite = $AnimatedSprite2D

var extra_direction := Vector2.ZERO  # движение с мобильных кнопок

func _physics_process(delta):
	var direction = Vector2.ZERO

	# Клавиатура / стандартный Input Map
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Прибавляем направление от экранных кнопок
	direction += extra_direction

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED
		move_and_slide()

		# Анимация
		if abs(direction.x) > abs(direction.y):
			sprite.play("walk_right" if direction.x > 0 else "walk_left")
		else:
			sprite.play("walk_down" if direction.y > 0 else "walk_up")
	else:
		velocity = Vector2.ZERO
		sprite.stop()
