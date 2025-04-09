extends Character_base

class_name Player_character

var pclight : Point_Light

func _ready() -> void:
    super._ready()
    GameManager.pc = self
    pclight = Point_Light.new()
    add_child(pclight)
    pclight.light_image_init(3)
    stats.type = Basic_stat.Type.PLAYER