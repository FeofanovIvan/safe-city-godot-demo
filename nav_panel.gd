extends Control

@onready var target_icon: TextureButton = $TargetIcon
@onready var icon_layer_main: TextureRect = $TargetIcon/IconLayer
@onready var target_list: TextureRect = $TargetList
@onready var icon_layer_list: TextureRect = $TargetList/IconLayer

# Кнопки целей
@onready var house_button: TextureButton = $TargetList/HouseButton
@onready var school_button: TextureButton = $TargetList/SchoolButton
@onready var store_button: TextureButton = $TargetList/StoreButton
@onready var playground_button: TextureButton = $TargetList/PlaygroundButton

# Целевые узлы (объекты на сцене)
@onready var mom_target = get_node("/root/Main/MomTarget")
@onready var teacher_target = get_node("/root/Main/TeacherTarget")
@onready var seller_target = get_node("/root/Main/SellerTarget")
@onready var classmate_target = get_node("/root/Main/ClassmateTarget")


# Словарь узлов
var target_nodes := {}

# Текущая выбранная цель
var current_target_name: String = ""

func _ready():
	target_list.visible = false
	target_icon.visible = true

	# Словарь целей
	target_nodes = {
		"Дом": mom_target,
		"Школа": teacher_target,
		"Магазин": seller_target,
		"Площадка": classmate_target
	}

	# Цель по умолчанию — Дом
	_set_target_icon(house_button.texture_normal, "Дом")

	# Подключаем сигналы кнопок
	house_button.connect("pressed", _on_target_button_pressed.bind(house_button, "Дом"))
	school_button.connect("pressed", _on_target_button_pressed.bind(school_button, "Школа"))
	store_button.connect("pressed", _on_target_button_pressed.bind(store_button, "Магазин"))
	playground_button.connect("pressed", _on_target_button_pressed.bind(playground_button, "Площадка"))

	target_icon.connect("pressed", _on_target_icon_pressed)

func _on_target_icon_pressed():
	target_icon.visible = false
	target_list.visible = true

func _on_target_button_pressed(button: TextureButton, label: String):
	_set_target_icon(button.texture_normal, label)
	target_list.visible = false
	target_icon.visible = true
	print("Цель выбрана: %s" % label)

func _set_target_icon(texture: Texture2D, label: String):
	current_target_name = label  # Сохраняем текущую цель
	for icon_layer in [icon_layer_main, icon_layer_list]:
		icon_layer.texture = texture
		icon_layer.expand = true
		icon_layer.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

# Получить координаты текущей цели
func get_current_target_position() -> Vector2:
	match current_target_name:
		"Дом":
			return get_node("/root/Main/MomTarget").global_position
		"Школа":
			return get_node("/root/Main/TeacherTarget").global_position
		"Магазин":
			return get_node("/root/Main/SellerTarget").global_position
		"Площадка":
			return get_node("/root/Main/ClassmateTarget").global_position
		_:
			return Vector2.ZERO
