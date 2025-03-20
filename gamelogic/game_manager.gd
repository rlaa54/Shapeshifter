extends Node2D

var action_queue = [] # 실행할 액션을 저장하는 큐 혹시 몰라서 일단 만들어봄
var idx  = 0 # 현재 턴의 캐릭터
var characters = [] # 화면 상의 모든 캐릭터를 포함하며 화면을 떠나서 처리하려는 모든 캐릭터
@onready var pc = $"/root/World/Player_character" # 플레이어 캐릭터
@onready var tml = $"/root/World/TileMapLayer" # 타일맵 레이어
enum Direction { NW, N, NE, W, E, SW, S, SE, NONE }

func _process(_delta: float) -> void:
	# 스피드가 빠른 캐릭터는 한 턴에 여러 번 움직일 수 있으므로 매 프레임마다 처리해야 함
	gameloop()

func gameloop() -> void:
	# 현재 캐릭터의 action을 가져옴
	var action = characters[idx].get_action()
	
	# 현재 캐릭터가 계획한 action이 없다면 다음 캐릭터로 넘어가지 않음
	if not action:
		return

	while (true):
		# action을 실행
		# result는 ActionResult를 반환받음
		var result = action.perform()
		# action이 실패했다면 다음 캐릭터로 넘어가지 않음
		if not result.succeeded: 
			return
		# alternate는 예를 들어 캐릭터가 문 앞에서 이동 할 경우 문을 여는 행위
		# 의도에 맞게 자동으로 행위를 바꾼다
		if result.alternative == null:
			break
		# alternate가 있다면 다음 action으로 바꿔줌
		action = result.alternative

	# 다음 캐릭터로 넘어가기
	idx = (idx + 1) % characters.size()
