extends Resource

class_name Basic_stat

@export var max_health : int
@export var max_action_point : int = 100        # 플레이어의 경우 언제든지 행동할 수 있어 0으로 설정해야 함
@export var visible_range : Tile_map_layer.Circle = Tile_map_layer.Circle.SMALL
@export var type : Basic_stat.Type = Basic_stat.Type.ENEMY
@export var character_speed : Action.Speed = Action.Speed.NORMAL

var cur_health : int
var cur_action_point : int = 0
var host : Character_base
var sight : PackedVector2Array
var local_visible_range : float

enum Type { PLAYER, ENEMY, NPC }

func ready(phost: Character_base) -> void:
    host = phost
    local_visible_range = GameManager.tml.cell_size.x * (visible_range + 0.5)
    sight_init()
    sight_update(host.position)

func sight_init() -> void:
    sight = GameManager.tml.get_circletiles(visible_range).duplicate()

func sight_update(localpos : Vector2) -> void:
    GameManager.tml.circle_tile_move(localpos, sight)