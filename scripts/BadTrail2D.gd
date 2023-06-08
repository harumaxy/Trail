# refs
# - https://www.youtube.com/watch?v=PhS0cZY0UCE&t=39s
# - https://qiita.com/2dgames_jp/items/391f5d4e4b1a345b8029
# - https://ask.godotengine.org/71677/line2d-to-make-a-trail-goes-everywhere

extends Line2D
class_name BadTrail2D

@export var length := 50
@export var target: Node2D = null

func ready():
  self.top_level = true

func _physics_process(delta):
  if target == null:
    return
  var point = target.global_position
  add_point(point)
  if points.size() > length:
      remove_point(0)
