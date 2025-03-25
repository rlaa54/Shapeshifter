@icon("res://Asset/Art/behavior_tree/icons/sequencer.svg")

extends Composite

class_name SequenceComposite

# sequence(모든 자식이 순차 SUCCESS를 만족해야 SUCCESS)

func tick(actor, blackboard):
    for c in get_children():
        var response = c.tick(actor, blackboard)

        if response != SUCCESS:
            return response

    return SUCCESS