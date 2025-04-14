extends CharacterBody2D

class_name Character_base

@export var stats : Basic_stat

var nextAction : Action = null
var ai : StateMachine = null

func _ready():
	stats.ready(self)
	ai = $Ai_component
	# 생성되면 GameManager에 등록
	GameManager.active_characters.append(self)

# 가장 가까운 적을 찾아 반환
func get_closest_enemy() -> Character_base:
	var closest_enemy = null
	var closest_distance = INF

	# 게임매니저에 등록된 캐릭터들 중에서 찾음
	for c in GameManager.active_characters:
		# 다른 타입의 캐릭터만 검사함
		# 예를 들어 플레이어면 몬스터만
		# 몬스터면 플레이어만			
		if c.stats.type == stats.type:
			continue

		# 자신은 제외
		if c == self:
			continue

		var distance = position.distance_to(c.position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = c

	return closest_enemy

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