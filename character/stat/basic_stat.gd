extends Resource

class_name Basic_stat

@export var max_health : int
# 플레이어의 경우 인풋에 따라 언제든지 행동해야 함으로 0으로 설정해야 함
@export var max_action_point : int = 100 
@export var visible_range : Tile_map_layer.Circle = Tile_map_layer.Circle.NORMAL

var cur_health : int
var cur_action_point : int = 0
var host : Character_base
var sight : PackedVector2Array
var local_visible_range : float

enum Type { PLAYER, ENEMY, NPC }

func ready(phost: Character_base) -> void:
    print("hello my name is:", self)
    print("hello ready for:", phost.name)
    host = phost
    local_visible_range = GameManager.tml.cell_size.x * (visible_range + 0.5)
    sight_init()
    sight_update(host.position)

func sight_init() -> void:
    sight = GameManager.tml.get_circletiles(visible_range).duplicate()

func sight_update(localpos : Vector2) -> void:
    GameManager.tml.circle_tile_move(localpos, sight)