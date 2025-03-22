extends Node2D

class_name Action

# host는 action을 실행하는 캐릭터
var host : Character_base

func _init() -> void:
	pass
	# host 초기화 해줘야 함
	# host = 

# action을 실행하기 위해 필요한 action point를 소비
func consumeAP(ap : Basic_stat.Speed) -> void:
	# 0이하로 내려가지 않게 함
	if host.stats.cur_action_point - ap < 0:
		host.stats.cur_action_point = 0
	else:
		host.stats.cur_action_point -= ap

# action point를 회복 
func regenAP(ap : Basic_stat.Speed) -> void:
	host.stats.cur_action_point += ap

# action point가 100이상이면 action_queue에 action을 추가할 수 있음
func canAddAction() -> bool:
	return host.stats.cur_action_point >= host.stats.max_action_point

# perform은 action을 실행하고 그 결과를 반환
# success 또는 failure 또는 다른 action을 담은 ActionResult를 반환
func perform() -> ActionResult:
	return ActionResult.success()

class ActionResult:
	# An alternate [Action] that should be performed instead of the one that failed.
	var alternative : Action = null
	# 'true' if the [Action] was successful and energy should be consumed
	var succeeded : bool
	
	func _init(pSucceeded: bool) -> void:
		self.succeeded = pSucceeded
	
	static func success() -> ActionResult:
		return ActionResult.new(true)

	static func failure() -> ActionResult:
		return ActionResult.new(false)

	static func alternate(pAlternative: Action) -> ActionResult:
		var result = ActionResult.new(true)
		result.alternative = pAlternative
		return result