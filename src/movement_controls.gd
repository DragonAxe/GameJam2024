extends Node

@onready var parent: RigidBody2D = get_parent()

func integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  var player_vector: Vector2 = Input.get_vector(
    "player_left", "player_right", "player_up", "player_down"
  )
  state.linear_velocity = player_vector * 210

  # Face player in the direction of where it's moving.
  var player_angle : float = player_vector.angle()
  if player_vector != Vector2.ZERO:
    var target_angle : float = lerp_angle(parent.rotation, player_angle + PI / 2, 0.25)
    parent.rotation = target_angle
