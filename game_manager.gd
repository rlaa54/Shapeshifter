extends Node2D

signal turn_started(current_entity)
signal turn_ended(current_entity)

enum TurnState { PLAYER_TURN, ENEMY_TURN }

var turn_order = [] # 턴 순서 리스트
var current_turn_index = 0 # 현재 턴의 주체 인덱스
var action_queue = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turn_order = ["Player", "Ally", "Enemy"]
	start_turn()

func start_turn() -> void:
	var current_entity = turn_order[current_turn_index]
	print("Turn start: " + current_entity)
	emit_signal("turn_started", current_entity)

	if current_entity == "Player":
        # 플레이어가 행동할 수 있도록 대기
		pass
	else:
        # AI 캐릭터의 행동 실행
		process_ai_turn(current_entity)

func end_turn() -> void:
	var current_entity = turn_order[current_turn_index]
	print("Turn end: " + current_entity)
	emit_signal("turn_ended", current_entity)

    # 다음 턴으로 변경 (순환 구조)
	current_turn_index = (current_turn_index + 1) % turn_order.size()
    
	start_turn()

func process_queue():
	while action_queue.size() > 0:
		var action = action_queue.pop_front()
		await action.call()
    
	end_turn()

func process_ai_turn(entity_name):
	print(entity_name + " is thinking...")

	await get_tree().create_timer(0.5).timeout  # 적/동료 AI가 일정 시간 후 행동
	queue_action(func():
		print(entity_name + " performs an action!")
	)

	await process_queue()

func queue_action(action: Callable):
	action.call()  # 액션 실행 후 곧바로 턴 종료
	end_turn()