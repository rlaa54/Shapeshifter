extends Node2D

class_name Input_component

var character : Character_base
var click_position = Vector2()
var isplayerinputend = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character = get_parent()

# 플레이어 인풋을 받는 부분
# 인풋을 받으면 액션을 실행함
func _unhandled_input(event):
	isplayerinputend = false
	if event.is_action_pressed("NW_move"):
		move(Vector2(-1, -1))
		isplayerinputend = true
	if event.is_action_pressed("N_move"):
		move(Vector2(0, -1))
		isplayerinputend = true
	if event.is_action_pressed("NE_move"):
		move(Vector2(1, -1))
		isplayerinputend = true
	if event.is_action_pressed("W_move"):
		move(Vector2(-1, 0))
		isplayerinputend = true
	if event.is_action_pressed("E_move"):
		move(Vector2(1, 0))
		isplayerinputend = true
	if event.is_action_pressed("SW_move"):
		move(Vector2(-1, 1))
		isplayerinputend = true
	if event.is_action_pressed("S_move"):
		move(Vector2(0, 1))
		isplayerinputend = true
	if event.is_action_pressed("SE_move"):
		move(Vector2(1, 1))
		isplayerinputend = true
	
	if isplayerinputend:
		# 플레이어 인풋이 끝나면 액션 루프를 실행
		GameManager.executeAction()

func move(dir : Vector2i) -> void:
	# 캐릭터가 가고자 하는 방향으로 액션에 넣음
	character.ai.action_behave(MoveAction.new(dir, character))