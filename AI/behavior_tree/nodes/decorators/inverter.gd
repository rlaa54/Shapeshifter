@icon("res://Asset/Art/icons/behavior_tree/inverter.svg")

extends Decorator

class_name InverterDecorator

# perform 결과를 반전시키거나(failer, inverter, succeder)

func perform(action, blackboard):
    for c in get_children():
        var response = c.perform(action, blackboard)

        if response == SUCCESS:
            return FAILURE
        if response == FAILURE:
            return SUCCESS

        return RUNNING