extends Line2D
class_name Trail2D

@export var min_distance := 3 #px
@export var dissolve := true
@export_range(0.1, 1.0, 0.1) var dissolve_time := .5


@export var target: Node2D = null:
  set(_target):
    target = _target
    if _target:
      add_point(target.global_position)


func _ready():
  self.top_level = true

func _process(delta):
  if target == null:
    return
  var last_point = points[points.size() - 1] if points.size() > 0 else null
  if last_point == null:
    return
  if last_point.distance_to(target.global_position) > min_distance:
    add_point(target.global_position)
    if dissolve:
      await get_tree().create_timer(dissolve_time).timeout
      remove_point(0)
      

