extends Node

class_name Action

# 액션의 스피드 enum
enum Speed { VERYSLOW = 200, SLOW = 150, NORMAL = 100, FAST = 50, VERYFAST = 25, LIGHT = 0 }

# action의 스피드
var action_speed : Speed = Speed.NORMAL
# 이 액션의 주인
var host : Character_base

func _init(pchar : Character_base) -> void:
	host = pchar

# action_speed를 변경함
func setSpeed(speed : Speed) -> void:
	action_speed = speed

# tick은 action을 실행하고 그 결과를 반환
# success 또는 failure 또는 다른 action을 담은 ActionResult를 반환
func perform() -> ActionResult:
	return ActionResult.failure()

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