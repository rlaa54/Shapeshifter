extends CharacterBody2D

class_name Character_base

@export var stats : Basic_stat

var nextAction : Action = null

func _ready():
	stats.ready(self)

	# 생성되면 GameManager에 등록
	GameManager.characters.append(self)

func get_action() -> Action:
	var action = nextAction
	# only perform once
	nextAction = null
	return action

func setNextAction(action: Action) -> void:
	nextAction = action

# 몬스터의 경우만 작동해야 함
# action은 실행이 성공 할 때 마다 action point를 소비하고 실행되어야 함
func consumeAP(ap : Action.Speed) -> void:
	# 0이하로 내려가지 않게 함
	if stats.cur_action_point - ap < 0:
		stats.cur_action_point = 0
	else:
		stats.cur_action_point -= ap

# 몬스터의 경우만 작동해야 함
# 플레이어의 행동속도에 반응해 action_point를 회복함
func regenAP(ap : Action.Speed) -> void:
	stats.cur_action_point += ap

# 몬스터의 경우만 작동해야 함
# action point가 100이상이면 action_queue에 action을 추가할 수 있음
# 그리고 플레이어의 경우는 언제나 true를 반환하도록 해야 함
func canAddAction() -> bool:
	return stats.cur_action_point >= stats.max_action_point