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
	
	func _init(s: bool) -> void:
		self.succeeded = s
	
	static func success() -> ActionResult:
		return ActionResult.new(true)

	static func failure() -> ActionResult:
		return ActionResult.new(false)

	# fix me 
	# alternate를 반환할 때 대안행동이 없으면 alternative는 null을 반환하고
	# alternative를 설정할 때는 그냥 설정할 수 있도록
	func alternate(a: Action) -> ActionResult:
		var result = ActionResult.new(true)
		result.alternative = a
		return result