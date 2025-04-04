extends Action

class_name WalkAction

var dir : GameManager.Direction
var localpos : Vector2
var tilesize : int
var dirpos : Vector2 = Vector2.ZERO
var tile_map_layer : TileMapLayer

# 각종 초기화
func _init(pDir : GameManager.Direction, pHost : Character_base, pActionspeed : Action.Speed) -> void:
	super._init(pHost, pActionspeed)
	dir = pDir
	tile_map_layer = GameManager.tml
	tilesize = tile_map_layer.cell_size.x

func perform() -> ActionResult:
	localpos = host.position
	dirpos = Vector2.ZERO
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
		# TODO: 그냥 쉬기 액션을 추가해야 함
		return ActionResult.success()

	# 가려는 방향으로 장애물이 있다면
	if not tile_map_layer.is_point_walkable(dirpos):
		return ActionResult.failure()
	# 장애물이 없다면
	else:
		# TODO: 장애물이 아니라 적이 있다거나 다른 상황이 있을 경우 추가해야함
		# 그 방향으로 이동한다
		host.position = dirpos
		return ActionResult.success()
