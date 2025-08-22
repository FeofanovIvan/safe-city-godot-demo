extends Control

@export var player_path: NodePath
var player

var is_up_pressed = false
var is_down_pressed = false
var is_left_pressed = false
var is_right_pressed = false

func _ready():
	player = get_node(player_path)

	$ButtonUp.pressed.connect(func(): 
		is_up_pressed = true
		_update_direction()
	)
	$ButtonDown.pressed.connect(func(): 
		is_down_pressed = true
		_update_direction()
	)
	$ButtonLeft.pressed.connect(func(): 
		is_left_pressed = true
		_update_direction()
	)
	$ButtonRight.pressed.connect(func(): 
		is_right_pressed = true
		_update_direction()
	)

	$ButtonUp.button_up.connect(func():
		is_up_pressed = false
		_update_direction()
	)
	$ButtonDown.button_up.connect(func():
		is_down_pressed = false
		_update_direction()
	)
	$ButtonLeft.button_up.connect(func():
		is_left_pressed = false
		_update_direction()
	)
	$ButtonRight.button_up.connect(func():
		is_right_pressed = false
		_update_direction()
	)

func _update_direction():
	var dir = Vector2.ZERO
	if is_up_pressed:
		dir.y -= 1
	if is_down_pressed:
		dir.y += 1
	if is_left_pressed:
		dir.x -= 1
	if is_right_pressed:
		dir.x += 1
	player.extra_direction = dir
