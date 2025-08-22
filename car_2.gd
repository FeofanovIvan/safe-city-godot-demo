extends Node2D

@export var speed := 150
@export var travel_distance := 3200

var start_x
var end_x

func _ready():
	start_x = position.x
	end_x = start_x - travel_distance

func _process(delta):
	position.x -= speed * delta
	if position.x < end_x:
		position.x = start_x
