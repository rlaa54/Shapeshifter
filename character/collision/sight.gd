extends Area2D

@onready var character : Character_base = get_parent()
var enemys : Array[Character_base] = []

func _ready() -> void:
    # 시야의 크기를 타일 크기만큼 적용해서 설정함
    sight_update(character.stats.visible_range)

# 시야 콜리전을 업데이트 함
# 매개변수는 Circle을 넣어줘야 함
func sight_update(radius : Tile_map_layer.Circle) -> void:
    # 시야를 업데이트함
    get_child(0).shape.radius = (radius + 0.5) * GameManager.tml.cell_size.x

# area2d의 콜리전이 들어왔을 때
func _on_area_entered(area : Area2D) -> void:
    if area.is_in_group("hurtbox"):
        # 자신과 다른 타입의 캐릭터만 검사함
        if area.get_parent().stats.type != character.stats.type:
            print("자신:", get_parent().name)
            print("대상:",area.get_parent().name)
            enemys.append(area.get_parent())

func _on_area_exited(area:Area2D) -> void:
    if area.is_in_group("hurtbox"):
        # 자신과 다른 타입의 캐릭터만 검사함
        if area.get_parent().stats.type != character.stats.type:
            print("자신:", get_parent().name)
            print("대상:",area.get_parent().name)
            enemys.erase(area.get_parent())
