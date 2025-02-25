extends Node2D

class_name Action

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