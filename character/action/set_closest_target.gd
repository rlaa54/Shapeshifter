extends Action

# 가장 가까운 적을 찾고, 그 적을 blackboard에 저장합니다.
func perform(actor, blackboard):
    var target = actor.get_closest_enemy()
    if target == null:
        return FAILURE
    blackboard.set_value("target", target)
    return SUCCESS