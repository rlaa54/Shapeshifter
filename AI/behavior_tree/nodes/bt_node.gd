@icon("res://Asset/Art/icons/behavior_tree/action.svg")

extends Behavior_tree

class_name Bt_node

# Bt_node는 Behavior_tree를 확장해놓은 베이스 클래스이며, 
# 공통 함수 tick(...)과 SUCCESS, FAILURE, RUNNING 같은 enum을 정의합니다.

func tick(actor, blackboard):
    pass