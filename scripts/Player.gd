extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const Bullet = preload("res://scenes/bullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
  if Input.is_action_just_pressed("fire"):
    fire()

func fire():
  var bullet = Bullet.instantiate()
  var aim_dir = self.global_position.direction_to(get_global_mouse_position()).normalized()
  bullet.global_position = self.global_position + aim_dir * 130
  bullet.global_rotation = aim_dir.angle()
  bullet.linear_velocity = bullet.linear_velocity.rotated(aim_dir.angle())
  
  var projectiles_container = get_tree().root.get_node("Level/Projectiles")
  if projectiles_container:
    projectiles_container.add_child(bullet)
  else:
    get_tree().root.add_child(bullet)
  
    
  

func _physics_process(delta):
  # Add the gravity.
  if not is_on_floor():
    velocity.y += gravity * delta

  # Handle Jump.
  if Input.is_action_just_pressed("ui_accept") and is_on_floor():
    velocity.y = JUMP_VELOCITY

  # Get the input direction and handle the movement/deceleration.
  # As good practice, you should replace UI actions with custom gameplay actions.
  var direction = Input.get_axis("ui_left", "ui_right")
  if direction:
    velocity.x = direction * SPEED
  else:
    velocity.x = move_toward(velocity.x, 0, SPEED)
    
  move_and_slide()
