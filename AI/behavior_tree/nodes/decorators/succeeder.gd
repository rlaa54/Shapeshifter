@icon("res://Asset/Art/icons/behavior_tree/succeed.svg")

extends Decorator

class_name AlwaysSucceedDecorator

# tick 결과를 반전시키거나(failer, inverter, succeder)

func tick(actor, blackboard):
    for c in get_children():
        var response = c.tick(actor, blackboard)
        if response == RUNNING:
            return RUNNING
        return SUCCESS