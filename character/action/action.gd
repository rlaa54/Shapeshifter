extends Node2D

class_name Action

# 액션의 스피드 enum
enum Speed { VERYSLOW = 150, SLOW = 125, NORMAL = 100, FAST = 50, VERYFAST = 25, LIGHT = 0 }

# host는 action을 실행하는 캐릭터
var host : Character_base
# action의 스피드
var action_speed : Speed = Speed.NORMAL

func _init(speed : Speed, pHost : Character_base) -> void:
	# action의 스피드를 초기화
	action_speed = speed
	# TODO: host 초기화 해줘야 함
	host = pHost

# action_speed를 변경함
func setSpeed(speed : Speed) -> void:
	action_speed = speed

# perform은 action을 실행하고 그 결과를 반환
# success 또는 failure 또는 다른 action을 담은 ActionResult를 반환
func perform() -> ActionResult:
	host.consumeAP(action_speed)
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