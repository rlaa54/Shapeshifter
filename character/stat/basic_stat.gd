extends Resource

class_name Basic_stat

@export var max_health : int
# 플레이어의 경우 인풋에 따라 언제든지 행동해야 함으로 0으로 설정해야 함
@export var max_action_point : int = 100 
@export var visible_range : int

var cur_health : int
var cur_action_point : int = 0

func _ready():
    print("hello Basic_stat ready")
    visible_range_to_grid()

# 시야 범위가 짝수일 경우 +1을 해준다
# 왜냐하면 시야 범위는 홀수여야 한다
# 시야가 1이면 플레이어 1칸 
# 시야가 2이면 양옆으로 1칸씩 총 3칸이기 때문에
func visible_range_to_grid() -> void:
    # 만약 시야가 없다면 시야는 없어야 한다
    if visible_range == 0:
        visible_range = 0
    elif visible_range % 2 == 0:
        visible_range += 1