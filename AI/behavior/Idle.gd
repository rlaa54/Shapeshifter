extends State

class_name Idle

@export var enemy : Character_base

func Enter():
    # IDLE 상태에 진입할 때 호출됩니다.
    # 필요한 초기화 작업을 수행합니다.
    pass

func Update(_delta: float):
    # IDLE 상태에서 업데이트를 수행합니다.
    # 필요한 업데이트 작업을 수행합니다.
    pass

func Physics_Update(_delta: float):
    # IDLE 상태에서 물리 업데이트를 수행합니다.
    # 필요한 물리 연산을 수행합니다.
    pass