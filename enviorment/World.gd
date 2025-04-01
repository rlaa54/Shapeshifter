extends Node2D

class_name World

# 전장의 안개의 인스턴스를 생성
@onready var blackfog = preload("res://enviorment/fog.tscn").instantiate()
@onready var grayfog = blackfog.duplicate()

var display_width = ProjectSettings.get("display/window/size/viewport_width")
var display_height = ProjectSettings.get("display/window/size/viewport_height")

var tml : TileMapLayer

var plight : Point_Light

func _ready() -> void:
	tml = GameManager.tml
	plight = GameManager.pc.pclight
	blackfog.create_fogImage(Color.BLACK)
	grayfog.create_fogImage(Color.GRAY)
	add_child(blackfog)
	add_child(grayfog)

func _process(_delta: float) -> void:
	# 캐릭터의 위치를 중심으로 전장의 안개를 업데이트해 시야를 밝힌다
	# 프레임마다 호출된다.
	blackfog.fog_blend_light(plight.global_position, plight.lightImage, plight.light_offset, false)
	grayfog.fog_blend_light(plight.global_position, plight.lightImage, plight.light_offset, true)