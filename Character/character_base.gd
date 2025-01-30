extends CharacterBody2D

enum State { IDLE, FOLLOW }

const MASS = 10.0
const ARRIVE_DISTANCE = 10.0

# @export var speed: float = 200.0
@export var maxTimeUnit: int = 100
@export var curTimeUnit: int = 0

var _state = State.IDLE
# var _velocity = Vector2()

@onready var tile_map_layer = $"../TileMapLayer"

var _click_position = Vector2()
var _path = PackedVector2Array()
var _next_point = Vector2()

func _ready():
	_change_state(State.IDLE)
	curTimeUnit = maxTimeUnit

func _process(_delta):
	if _state != State.FOLLOW:
		return
	var arrived_to_next_point = _move_to(_next_point)
	if arrived_to_next_point:
		_path.remove_at(0)
		if _path.is_empty():
			_change_state(State.IDLE)
			return
		_next_point = _path[0]

func _unhandled_input(event):
	_click_position = get_global_mouse_position()
	if tile_map_layer.is_point_walkable(_click_position):
		if event.is_action_pressed(&"move_to"):
			_change_state(State.FOLLOW)

func _move_to(local_position):
	print("이동전타임유닛:",curTimeUnit)
	if position.distance_to(local_position) == 128:
		curTimeUnit -= 4
	else :
		curTimeUnit -= 6
	print("이동후타임유닛:",curTimeUnit, "\n")
	position = local_position
	return position.distance_to(local_position) < ARRIVE_DISTANCE

func _change_state(new_state):
	if new_state == State.IDLE:
		tile_map_layer.clear_path()
	elif new_state == State.FOLLOW:
		_path = tile_map_layer.find_path(position, _click_position)
		if _path.size() < 2:
			_change_state(State.IDLE)
			return
		# The index 0 is the starting cell.
		# We don't want the character to move back to it in this example.
		_next_point = _path[1]
	_state = new_state	