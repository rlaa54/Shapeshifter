extends Resource

class_name Basic_stat

enum Speed { VERYSLOW = 150, SLOW = 125, NORMAL = 100, FAST = 50, VERYFAST = 25, LIGHT = 0 }

@export var max_health : int
# 플레이어의 경우 인풋에 따라 언제든지 행동해야 함으로 0으로 설정해야 함
@export var max_action_point : int = 100 
@export var action_speed : Speed = Speed.NORMAL
@export var visible_range : int

var cur_health : int
var cur_action_point : int = 0

func _ready():
    print("hello Basic_stat ready")