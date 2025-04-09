extends Node2D

var action_queue : Array[Action] = [] # 실행할 액션을 저장하는 큐 혹시 몰라서 일단 만들어봄
var idx  = 0 # 현재 턴의 캐릭터
var active_characters = [] # 활성화된 모든 캐릭터
var turn_count : float = 0.0 # 게임 시작 시 1.0로 초기화해야 함
var pc : Player_character = null # 플레이어 캐릭터
var tml : TileMapLayer # 타일맵 레이어
enum Direction { NW, N, NE, W, E, SW, S, SE, NONE }

# 액션큐의 액션을 실행하고 판정함
func executeAction() -> void:
	while (not action_queue.is_empty()):
		# 제일 앞의 액션을 꺼내 옴
		var action = action_queue.pop_front()
		# 플레이어를 위한 액션판정루프
		while (true):
			# result는 ActionResult
			# 액션을 실행하고 그 결과를 반환
			var result = action.perform()
			# action이 실패 했다면
			# 몬스터는 잘못된 행동을 하지 않고 플레이어는 잘못된 인풋을 할 수도 있으므로
			# 플레이어의 경우만 생각한다면
			# 턴을 넘기지 않고
			# 다시 행동을 선택하게 함
			# 플레이어의 인풋 대기 상태로
			# 몬스터는 플레이어의 행동을 보고 반응함으로 본질적으로 이 경우에는 액션큐는 비어있어야 함
			if not result.succeeded:
				return
			# alternate는 예를 들어 캐릭터가 문 앞에서 이동 할 경우 문을 여는 행위
			# 의도에 맞게 자동으로 행위를 바꾼다
			if result.alternative == null:
				break
			# alternate가 있다면 다음 action으로 바꿔줌
			action = result.alternative
		
		# 플레이어의 액션이 끝남
		# TODO:다음 액션으로 넘어가기 위해 몬스터들의 actionpoint를 회복시켜야 함
		if action.host == pc:
			player_turn_end()
		
		# TODO:몬스터 AI가 행동을 결정해야 함

	# 모든 액션이 끝나고 턴이 끝남
	# TODO: PC의 action_speed 만큼 턴을 증가시켜야 함
	# veryfast 0.25 fast 0.5 normal 1.0 slow 1.5 veryslow 2.0
	turn_count += 1.0
	

# 플레이어의 액션이 끝남
func player_turn_end() -> void:
	pass

# 플레이어의 턴이 시작됨
func player_turn_start() -> void:
	pass

# 컴퓨터의 턴이 시작됨
func computer_turn_start() -> void:
	pass

# 컴퓨터의 턴이 끝남
func computer_turn_end() -> void:
	pass

# 액션큐에 액션을 추가함
func addAction(action: Action) -> void:
	# 액션을 추가할 수 있는지 확인
	# 현재는 액션의 주인으로 판정하지만
	if action.host.canAddAction():
		action_queue.append(action)