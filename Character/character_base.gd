extends CharacterBody2D

@export var maxTimeUnit: int = 100
@export var curTimeUnit: int = 0

@onready var tile_map_layer = $"../TileMapLayer"

var click_position = Vector2()
var path = PackedVector2Array()
var next_point = Vector2()

var is_moving = false

func _ready():
	curTimeUnit = maxTimeUnit

func _process(_delta):
	if !(is_moving):
		return
	move_to(next_point)

func _unhandled_input(event):
	click_position = get_global_mouse_position()
	if tile_map_layer.is_point_walkable(click_position):
		if event.is_action_pressed(&"move_to"):
			path = tile_map_layer.find_path(position, click_position)
			# 시작 지점을 제거
			path.remove_at(0)
			is_moving = true
			next_point = path[0]


func move_to(local_position):
	print("이동전타임유닛:",curTimeUnit)
	if position.distance_to(local_position) <= 128:
		curTimeUnit -= 4
		print("-4")
	else :
		curTimeUnit -= 6
		print("-6")
	print("이동후타임유닛:",curTimeUnit, "\n")
	position = local_position
	path.remove_at(0)
	if path.size() <= 0:
		is_moving = false
		tile_map_layer.clear_path()
		return
	next_point = path[0]