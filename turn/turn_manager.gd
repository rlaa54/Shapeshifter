extends Node2D

class_name Turn_manager

signal turn_started(current_entity)
signal turn_ended(current_entity)

enum TurnState { PLAYER_TURN, ALLY_TURN, ENEMY_TURN }

var turn_order = [] # 턴 순서 리스트
var current_turn_index = 0 # 현재 턴의 주체 인덱스
var action_queue = []
var current_state : TurnState

func _ready() -> void:
	turn_order = ["Player", "Ally", "Enemy"]
	current_state = TurnState.PLAYER_TURN
	start_current_state()

func start_current_state() -> void:
	match current_state:
		TurnState.PLAYER_TURN:
			print("Player's turn!")
			start_turn()
			# 플레이어 입력 대기 등 추가 로직
		TurnState.ALLY_TURN:
			print("Ally's turn!")
			start_turn()
		TurnState.ENEMY_TURN:
			print("Enemy's turn!")
			start_turn()

func change_state(new_state: TurnState) -> void:
	current_state = new_state
	start_current_state()

func start_turn() -> void:
	var current_entity = turn_order[current_turn_index]
	print("Turn start: " + current_entity)
	turn_started.emit(current_entity)

	if current_entity == "Player":
        # 플레이어가 행동할 수 있도록 대기
		pass
	else:
        # AI 캐릭터의 행동 실행
		process_ai_turn(current_entity)

func end_turn() -> void:
	var current_entity = turn_order[current_turn_index]
	turn_ended.emit(current_entity)

	match current_state:
		TurnState.PLAYER_TURN:
			print("Player's turn ended!")
			change_state(TurnState.ALLY_TURN)
		TurnState.ALLY_TURN:
			print("Ally's turn ended!")
			change_state(TurnState.ENEMY_TURN)
		TurnState.ENEMY_TURN:
			print("Enemy's turn ended!")
			change_state(TurnState.PLAYER_TURN)

func process_queue() -> void:
	while action_queue.size() > 0:
		var action = action_queue.pop_front()
		await action.call()
    
	end_turn()

func process_ai_turn(entity_name) -> void:
	print(entity_name + " is thinking...")

	await get_tree().create_timer(0.5).timeout  # 적/동료 AI가 일정 시간 후 행동
	queue_action(func():
		print(entity_name + " performs an action!")
	)

	await process_queue()

func queue_action(action: Callable) -> void:
	action.call()  # 액션 실행 후 곧바로 턴 종료
	end_turn()