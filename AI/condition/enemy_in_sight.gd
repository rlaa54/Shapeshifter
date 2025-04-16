extends ConditionLeaf

func tick(actor, blackboard):
    # 시야 안에 적이 있는지 검사함
    var sight = actor.stats.visible_range + 0.5