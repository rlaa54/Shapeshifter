extends Character_base

class_name Player_character

var pclight : Point_Light

func _ready() -> void:
    GameManager.pc = self
    pclight = Point_Light.new()
    add_child(pclight)
    pclight.light_image_init(stats.visible_range)