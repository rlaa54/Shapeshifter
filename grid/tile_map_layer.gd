extends TileMapLayer

class_name Tile_map_layer

# 타일의 종류
enum Tile { NORMAL, OBSTACLE, START_POINT, END_POINT}
# 원의 종류
# 자연스러운 원을 원할 경우 0.5를 더해야 함
enum Circle { VERYSMALL = 2, SMALL = 3, NORMAL = 5, BIG = 7, VERYBIG = 9 }


const BASE_LINE_WIDTH = 3.0
const DRAW_COLOR = Color.WHITE

# 원에 포함된 타일들의 로컬좌표
var circletiles : Array[PackedVector2Array]

var cell_size = tile_set.tile_size
@export var num_tiles = Vector2i(16, 16)

# the object for pathfinding on 2d grids.
var _astar = AStarGrid2D.new()

var _start_point = Vector2i()
var _end_point = Vector2i()
var _path = PackedVector2Array()

func _ready() -> void:
	GameManager.tml = self

	# 원의 종류 만큼
	for c in Circle:
		# Circle[c]는 enum의 값을 가져온다
		# 원의 반지름
		# 우리가 원하는 건 거기에 0.5를 더한
		# 자연스러운 원이다
		circletiles.append(bounding_box_circle(Vector2(0,0), Circle[c] + 0.5))

	# Region should match the size of the playable area plus one (in tiles).
	# In this demo, the playable area is 17×9 tiles, so the rect size is 18×10.
	_astar.region = Rect2i(0, 0, num_tiles.x, num_tiles.y)
	_astar.cell_size = cell_size
	_astar.offset = cell_size * 0.5
	_astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ALWAYS
	_astar.update()
	
	# 왼쪽에서 오른쪽으로 위에서 아래로 모든 타일을 검사하여
	# 그 타일이 장애물 타일이면 AStarGrid2D에 장애물로 등록한다.
	for i in range(_astar.region.position.x, _astar.region.end.x):
		for j in range(_astar.region.position.y, _astar.region.end.y):
			var pos = Vector2i(i, j)
			if get_cell_source_id(pos) == Tile.OBSTACLE:
				_astar.set_point_solid(pos)

# Draw the grid
func _draw() -> void:
	draw_grid()

	draw_rect(Rect2(Vector2.ZERO, Vector2(cell_size.x * num_tiles.x, cell_size.y * num_tiles.y)), Color.RED, false)

	# draw_circle(Vector2(64 +128*2, 64), BASE_LINE_WIDTH * 20.0, Color.RED)
	
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

# 로컬 포지션을 받아 그 타일이 이동 가능한지 체크
# 이동 가능하면 true 반환, 불가능하다면 false 반환
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
# 그리고 그 타일들의 로컬좌표를 배열에 담아 반환
func bounding_box_circle(center : Vector2, radius : float) -> PackedVector2Array:
	# 타일의 좌표를 가질 배열
	var local_tiles : PackedVector2Array
	var min_tiles = -(num_tiles.x / 2.0)
	var max_tiles = num_tiles.x / 2.0

	var top = clampf(ceil(center.y - radius), min_tiles, max_tiles)
	var bottom = clampf(floor(center.y + radius), min_tiles, max_tiles)
	var left = clampf(ceil(center.x - radius), min_tiles, max_tiles)
	var right = clampf(floor(center.x + radius), min_tiles, max_tiles)

	for y in range(top, bottom + 1):
		for x in range(left, right + 1):
			if inside_circle(center, Vector2(x, y), radius):
				local_tiles.append(map_to_local(Vector2(x, y)))
	return local_tiles

# 원의 경계 안에 있는 타일들을 검사하는 방법
# sqrt 연산을 쓰기 때문에 조금 느릴 수 있다
# 자주 쓰이지는 않음
# 원의 경계가 필요할 때 사용
func outline_circle(center : Vector2, radius : float) -> PackedVector2Array:
	var local_tiles : PackedVector2Array

	for r in range(0, floor(radius * sqrt(0.5)) + 1):
		var d = floor(sqrt(radius * radius - r * r))
		local_tiles.append(map_to_local(Vector2(center.x - d, center.y + r)))
		local_tiles.append(map_to_local(Vector2(center.x + d, center.y + r)))
		local_tiles.append(map_to_local(Vector2(center.x - d, center.y - r)))
		local_tiles.append(map_to_local(Vector2(center.x + d, center.y - r)))
		local_tiles.append(map_to_local(Vector2(center.x - r, center.y + d)))
		local_tiles.append(map_to_local(Vector2(center.x + r, center.y + d)))
		local_tiles.append(map_to_local(Vector2(center.x - r, center.y - d)))
		local_tiles.append(map_to_local(Vector2(center.x + r, center.y - d)))
	return local_tiles

# localpos에는 로컬 좌표를 넣어야 함
func circle_tile_move(localpos: Vector2, dcircle_tiles : PackedVector2Array) -> PackedVector2Array:
	# cell_size.x/2, cell_size.y/2를 빼는 이유는
	# 타일만큼만 움직여야 되는데
	# 타일의 중앙이 한 번 더 들어감
	localpos -= Vector2(cell_size.x/2, cell_size.y/2)	
	
	for c in dcircle_tiles.size():
		dcircle_tiles.set(c, dcircle_tiles[c] + localpos)
	
	return dcircle_tiles

func get_circletiles(circle : Circle) -> PackedVector2Array:
	match circle:
		Circle.VERYSMALL:
			return circletiles[0]
		Circle.SMALL:
			return circletiles[1]
		Circle.NORMAL:
			return circletiles[2]
		Circle.BIG:
			return circletiles[3]
		Circle.VERYBIG:
			return circletiles[4]
		_:
			print("Circle type not found")
			return []