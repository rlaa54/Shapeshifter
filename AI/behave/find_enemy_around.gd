extends BehaveLeaf

class_name FindEnemyAround

func tick(actor, blackboard):
    # 가장 가까운 적을 찾음
    # 캐릭터는 자신을 제외한 적들 중에서 가장 가까운 적을 찾음
    var closest_enemy = actor.get_closest_enemy()
    # 가장 가까운 적이 없다면 실패
    if closest_enemy == null:
        return FAILURE
    # 가장 가까운 적을 blackboard에 저장함
    blackboard.set_value("closest_enemy", closest_enemy)
    return SUCCESS