extends Node

class_name State

signal Transitioned

# 상태에 진입할 때
func Enter():
    pass

# 상태에서 나갈 때
func Exit():
    pass

# 상태에서 업데이트할 때
func Update(_delta : float):
    pass

# 상태에서 물리 업데이트할 때
func Physics_Update(_delta : float):
    pass