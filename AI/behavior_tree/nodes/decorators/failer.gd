@icon("res://Asset/Art/behavior_tree/icons/fail.svg")

extends Decorator

class_name AlwaysFailDecorator

# tick 결과를 반전시키거나(failer, inverter, succeder)

func tick(action, blackboard):
    for c in get_children():
        var response = c.tick(action, blackboard)
        if response == RUNNING:
            return RUNNING
        return FAILURE