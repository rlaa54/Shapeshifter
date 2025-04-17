extends Area2D

@onready var character : Character_base = get_parent()

func _ready() -> void:
    collision_init()

# 콜리전을 초기화함
func collision_init() -> void:
	# 콜리전의 크기를 타일 크기만큼 설정함
    get_child(0).shape.size = Vector2(GameManager.tml.cell_size.x, GameManager.tml.cell_size.y)