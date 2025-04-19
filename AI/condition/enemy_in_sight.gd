extends ConditionLeaf

func tick(actor, blackboard):
    # 시야 내의 적이 없을 때
    if actor.sight.enemys.size() == 0:
        return FAILURE
    for enemy in actor.sight.enemys:
        # 시야 내의 적을 블랙보드에 등록함
        blackboard.set_value("sight_in_enemy", enemy)
    return SUCCESS
