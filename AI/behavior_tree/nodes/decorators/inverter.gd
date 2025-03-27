@icon("res://Asset/Art/icons/behavior_tree/inverter.svg")

extends Decorator

class_name InverterDecorator

# tick 결과를 반전시키거나(failer, inverter, succeder)

func tick(action, blackboard):
    for c in get_children():
        var response = c.tick(action, blackboard)

        if response == SUCCESS:
            return FAILURE
        if response == FAILURE:
            return SUCCESS

        return RUNNING