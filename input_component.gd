extends Node2D

class_name Input_component

@export var character : Character_base
@export var move_component : Move_component

@onready var tile_map_layer = $"/root/World/TileMapLayer"

var click_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event):
	click_position = get_global_mouse_position()
	if tile_map_layer.is_point_walkable(click_position):
		if event.is_action_pressed(&"move_to"):
			move_component.path = tile_map_layer.find_path(character.position, click_position)
			# 시작 지점을 제거
			# 제거하는 이유는 루프에서 이동하기 전에 한 번 더 실행되는 것을 방지하기 위함
			move_component.path.remove_at(0)
			# 시작 지점을 제거 하기 때문에 캐릭터가 있는 위치로 이동하려 한다면
			# 참조 오류가 발생하기 때문에 비어있다면 바로 리턴
			if move_component.path.is_empty():
				return	
			move_component.is_moving = true
			move_component.next_point = move_component.path[0]
