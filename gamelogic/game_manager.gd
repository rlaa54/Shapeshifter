extends Node2D

var action_queue = [] # 실행할 액션을 저장하는 큐 혹시 몰라서 일단 만들어봄
var current_character = null # 현재 턴의 캐릭터
var characters = [] # 화면 상의 모든 캐릭터를 포함하며 화면을 떠나서 처리하려는 모든 캐릭터

func _process(_delta: float) -> void:
	# 현재 캐릭터의 action을 가져옴
	var action = characters[current_character].get_action()
	
	# 현재 캐릭터가 계획한 action이 없다면 다음 캐릭터로 넘어가지 않음
	if action.is_empty():
		return

	while (true):
		# action을 실행
		var result = action.perform()
		# action이 실패했다면 다음 캐릭터로 넘어가지 않음
		if not result.succeeded: 
			return
		if result.alternate == null: 
			break
		action = result.alternate

	# 다음 캐릭터로 넘어가기
	current_character = (current_character + 1) % characters.size()
