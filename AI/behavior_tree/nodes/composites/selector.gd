@icon("res://Asset/Art/icons/behavior_tree/selector.svg")

extends Composite

class_name SelectorComposite

# selector(어느 한 자식이나 특정 조건 충족 시 SUCCESS)

func perform(actor, blackboard):
    for c in get_children():
        var response = c.perform(actor, blackboard)

        if response != FAILURE:
            return response

    return FAILURE