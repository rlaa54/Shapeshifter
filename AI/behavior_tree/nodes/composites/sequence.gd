@icon("res://Asset/Art/icons/behavior_tree/sequencer.svg")

extends Composite

class_name SequenceComposite

# sequence(모든 자식이 순차 SUCCESS를 만족해야 SUCCESS)

func perform(actor, blackboard):
    for c in get_children():
        var response = c.perform(actor, blackboard)

        if response != SUCCESS:
            return response

    return SUCCESS