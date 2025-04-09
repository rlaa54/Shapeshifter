extends ConditionLeaf

# 타겟이 시야 안에 있니?
func perform(actor, blackboard):
    # actor는 플레이어 캐릭터
    # blackboard는 게임 상태를 저장하는 객체
    # actor와 blackboard는 Behavior_tree의 자식 노드에서 전달받습니다.
    
    var target = blackboard.get_value("target")
    if target == null:
        return FAILURE

    var distance = actor.position.distance_to(target.position)
    if distance <= actor.stats.local_visible_range:
        return SUCCESS

    return FAILURE