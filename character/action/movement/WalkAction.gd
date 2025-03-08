extends Action

class_name WalkAction

var dir : GameManager.Direction
var localpos : Vector2
var tilesize : int
var dirpos : Vector2

@onready var tile_map_layer = $"/root/World/TileMapLayer"

func _init(pDir) -> void:
	dir = pDir

func _ready() -> void:
	tilesize = tile_map_layer.cell_size.x

func perform() -> ActionResult:
	localpos = GameManager.pc.position

	if dir == GameManager.Direction.NW:
		dirpos = localpos + Vector2(-tilesize, -tilesize)
	elif dir == GameManager.Direction.N:
		dirpos = localpos + Vector2(0, -tilesize)
	elif dir == GameManager.Direction.NE:
		dirpos = localpos + Vector2(tilesize, -tilesize)
	elif dir == GameManager.Direction.W:
		dirpos = localpos + Vector2(-tilesize, 0)
	elif dir == GameManager.Direction.E:
		dirpos = localpos + Vector2(tilesize, 0)
	elif dir == GameManager.Direction.SW:
		dirpos = localpos + Vector2(-tilesize, tilesize)
	elif dir == GameManager.Direction.S:
		dirpos = localpos + Vector2(0, tilesize)
	elif dir == GameManager.Direction.SE:
		dirpos = localpos + Vector2(tilesize, tilesize)
	elif dir == GameManager.Direction.NONE:
		# 만약 그냥 쉰다는 액션이 생기면 그걸 하도록 변경할 것!
		return ActionResult.success()

	# 가려는 방향으로 장애물이 있다면
	if tile_map_layer.is_point_walkable(dirpos):
		return ActionResult.failure()
	# 장애물이 없다면
	else:
		# TODO: 장애물이 아니라 적이 있다거나 다른 상황이 있을 경우 추가해야함
		# 그 방향으로 이동한다
		GameManager.pc.position = dirpos
		return ActionResult.success()
