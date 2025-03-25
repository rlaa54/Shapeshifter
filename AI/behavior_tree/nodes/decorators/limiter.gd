@icon("res://Asset/Art/behavior_tree/icons/limiter.svg")

extends Decorator

class_name LimiterDecorator

# 제한 조건을 걸거나(limiter)

@onready var cache_key = 'limiter_%s' % self.get_instance_id()

@export var max_count : float = 0

func tick(actor, blackboard):
    var current_count = blackboard.get_value(cache_key)

    if current_count == null:
        current_count = 0

    if current_count <= max_count:
        blackboard.set_value(cache_key, current_count + 1)
        return self.get_child(0).tick(actor, blackboard)

    else:
        return FAILED