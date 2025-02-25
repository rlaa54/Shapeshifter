extends Node2D

class_name Move_component

@export var character : Character_base

@onready var tile_map_layer = $"/root/World/TileMapLayer"
@onready var world = $"/root/World"

var path = PackedVector2Array()
var next_point = Vector2()

var is_moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !(is_moving):
		return
	move_to(next_point)

func move_to(local_position):
	character.position = local_position
	path.remove_at(0)
	if path.size() <= 0:
		is_moving = false
		tile_map_layer.clear_path()
		return
	next_point = path[0]
