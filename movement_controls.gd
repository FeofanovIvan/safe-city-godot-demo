extends Control

@onready var player = get_node("/root/Main/Player")  # адаптируй путь до узла Player при необходимости

func _ready():
	# Подключаем сигналы нажатия и отпускания
	$Button_Up.button_down.connect(_on_up_down)
	$Button_Up.button_up.connect(_on_button_released)

	$Button_Down.button_down.connect(_on_down_down)
	$Button_Down.button_up.connect(_on_button_released)

	$Button_Left.button_down.connect(_on_left_down)
	$Button_Left.button_up.connect(_on_button_released)

	$Button_Right.button_down.connect(_on_right_down)
	$Button_Right.button_up.connect(_on_button_released)

# Обработка направления при удержании
func _on_up_down():
	player.extra_direction = Vector2.UP

func _on_down_down():
	player.extra_direction = Vector2.DOWN

func _on_left_down():
	player.extra_direction = Vector2.LEFT

func _on_right_down():
	player.extra_direction = Vector2.RIGHT
	print("→ RIGHT button pressed")

# Сброс направления при отпускании
func _on_button_released():
	player.extra_direction = Vector2.ZERO
