extends TileMapLayer

class_name Tile_map_layer

# 타일의 종류
enum Tile { NORMAL, OBSTACLE, START_POINT, END_POINT}

const BASE_LINE_WIDTH = 3.0
const DRAW_COLOR = Color.WHITE

var cell_size = tile_set.tile_size
@export var num_tiles = Vector2i(16, 16)

# the object for pathfinding on 2d grids.
var _astar = AStarGrid2D.new()

var _start_point = Vector2i()
var _end_point = Vector2i()
var _path = PackedVector2Array()

func _ready() -> void:
	GameManager.tml = self
	# Region should match the size of the playable area plus one (in tiles).
	# In this demo, the playable area is 17×9 tiles, so the rect size is 18×10.
	_astar.region = Rect2i(0, 0, num_tiles.x, num_tiles.y)
	_astar.cell_size = cell_size
	_astar.offset = cell_size * 0.5
	_astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ALWAYS
	_astar.update()

	for i in range(_astar.region.position.x, _astar.region.end.x):
		for j in range(_astar.region.position.y, _astar.region.end.y):
			var pos = Vector2i(i, j)
			if get_cell_source_id(pos) == Tile.OBSTACLE:
				_astar.set_point_solid(pos)

# Draw the grid
func _draw() -> void:
	draw_grid()

	draw_rect(Rect2(Vector2.ZERO, Vector2(cell_size.x * num_tiles.x, cell_size.y * num_tiles.y)), Color.RED, false)

	draw_circle(Vector2(128, 128), BASE_LINE_WIDTH * 20.0, Color.RED)
	
	if _path.is_empty():
		return

	var last_point = _path[0]
	for index in range(1, len(_path)):
		var current_point = _path[index]
		draw_line(last_point, current_point, DRAW_COLOR, BASE_LINE_WIDTH, true)
		draw_circle(current_point, BASE_LINE_WIDTH * 2.0, DRAW_COLOR)
		last_point = current_point
	
func draw_grid():
	for x in num_tiles.x + 1:
		draw_line(Vector2(x * cell_size.x, 0),
				  Vector2(x * cell_size.x, num_tiles.y * cell_size.y),
				  DRAW_COLOR, 1.0)
	for y in num_tiles.y + 1:
		draw_line(Vector2(0, y * cell_size.y),
				  Vector2(num_tiles.x * cell_size.x, y * cell_size.y),
				  DRAW_COLOR, 1.0)

# 로컬 포지션을 받아 맵에 맞춰 변환 후 타일의 정중앙 로컬 포지션으로 변환
func round_local_position(local_position):
	return map_to_local(local_to_map(local_position))

func is_point_walkable(local_position):
	var map_position = local_to_map(local_position)
	if _astar.is_in_boundsv(map_position):
		return not _astar.is_point_solid(map_position)
	return false

func clear_path():
	if not _path.is_empty():
		_path.clear()
		erase_cell(_start_point)
		erase_cell(_end_point)
		# Queue redraw to clear the lines and circles.
		queue_redraw()

func find_path(local_start_point, local_end_point):
	clear_path()

	_start_point = local_to_map(local_start_point)
	_end_point = local_to_map(local_end_point)
	_path = _astar.get_point_path(_start_point, _end_point)

	if not _path.is_empty():
		set_cell(_start_point, 0, Vector2i(Tile.START_POINT, 0))
		set_cell(_end_point, 0, Vector2i(Tile.END_POINT, 0))

	# redraw the lines and circles from the start to the end point.
	queue_redraw()

	return _path.duplicate()

# 원 안에 있는 지 체크하고 불타입 반환
func inside_circle(center : Vector2, tile : Vector2, radius : float) -> bool:
	var dx = center.x - tile.x
	var dy = center.y - tile.y
	var distance = dx * dx + dy * dy
	return distance <= radius * radius

# 모든 타일을 검사할 수 없으니
# 사각 경계를 그려
# 경계 안의 타일들이 
# 원 안에 있는지 타일을 검사하는 방법
func bounding_box_check(center : Vector2, radius : float) -> void:
	var top = ceil(center.y - radius)
	var bottom = floor(center.y + radius)
	var left = ceil(center.x - radius)
	var right = floor(center.x + radius)

	for y in range(top, bottom):
		for x in range(left, right):
			if inside_circle(center, Vector2(x, y), radius):
				var circle_in_tile = Vector2(x, y)
				

# 사용 예시
func test_bbc():
	var center = GameManager.pc.position
	var radius = (GameManager.pc.stats.visible_range * cell_size.x) + (cell_size.x / 2.0)
	bounding_box_check(center, radius)