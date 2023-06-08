extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 0

func _physics_process(delta):
  var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
  self.velocity = dir * SPEED

  move_and_slide()
