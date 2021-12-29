tool
extends Node2D

export(Vector2) var pos = Vector2.ZERO
export(Vector2) var size = Vector2(100.0, 100.0)

func _process(delta):
    update()

func _draw():
    draw_rect(Rect2(pos, size), Color(1.0, 0.0, 0.0), false, 3.0)

