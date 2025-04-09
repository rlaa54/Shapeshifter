@icon("res://Asset/Art/icons/behavior_tree/fail.svg")

extends Decorator

class_name AlwaysFailDecorator

# perform 결과를 반전시키거나(failer, inverter, succeder)

func perform(action, blackboard):
    for c in get_children():
        var response = c.perform(action, blackboard)
        if response == RUNNING:
            return RUNNING
        return FAILURE