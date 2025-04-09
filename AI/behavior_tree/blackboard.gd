extends RefCounted

class_name Blackboard

# 전역(또는 특정 AI 엘리먼트 공유)으로 사용될 수 있는 key-value 형태의 저장소.
# set_value(key, value, blackboard_name)은 특정 “blackboard_name” 공간에 key/value를 저장.
# get_value, has, erase 같은 메서드를 통해 상태를 공유·조회·삭제.
# Decorator나 ConditionLeaf 등에서 blackboard를 참조하여(예: 공격 가능 여부, 적이 보이는지 등) 
# 로직을 결정할 수 있습니다.

var blackboard = {}

func set_value(key, value, blackboard_name = 'default'):
	if not blackboard.has(blackboard_name):
		blackboard[blackboard_name] = {}

	blackboard[blackboard_name][key] = value

func get_value(key, default_value = null, blackboard_name = 'default'):
	if has(key, blackboard_name):
		return blackboard[blackboard_name].get(key, default_value)
	return default_value


func has(key, blackboard_name = 'default'):
	return blackboard.has(blackboard_name) and blackboard[blackboard_name].has(key) and blackboard[blackboard_name][key] != null

func erase(key, blackboard_name = 'default'):
	if blackboard.has(blackboard_name):
		blackboard[blackboard_name][key] = null