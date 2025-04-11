extends Action

class_name MoveAction

# 이 액션의 호스트
var character : Character_base
# 캐릭터의 현재 위치
var characterpos : Vector2
# 이 액션의 호스트가 가고자 하는 로컬좌표
var localpos : Vector2
# 이 액션의 호스트가 가고자 하는 방향
var dir : Vector2i

func _init(pos : Vector2i, pchar : Character_base) -> void:
	super._init(pchar)
	dir = pos
	character = pchar

func perform() -> ActionResult:
	# 캐릭터의 현재 위치를 가져옴
	# ex) (0, 0) + (1, 1) = (1, 1)
	# (1, 1) => (198, 198)
	characterpos = character.position
	# 캐릭터의 현재 위치를 타일좌표로 변환 후 
	# 방향을 더하고 그 값을 다시 로컬좌표로 변환 함
	localpos = GameManager.tml.map_to_local(GameManager.tml.local_to_map(characterpos) + dir)

	# 가려는 방향으로 장애물이 있다면
	if not GameManager.tml.is_point_walkable(localpos):
		return ActionResult.failure()
	# 장애물이 없다면
	else:
		# TODO: 장애물이 아니라 적이 있다거나 다른 상황이 있을 경우 추가해야함
		# 그 방향으로 이동한다
		character.position = localpos
		return ActionResult.success()
