extends Node

@onready var parent: RigidBody2D = get_parent()

func integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  var player_vector: Vector2 = Input.get_vector(
    "player_left", "player_right", "player_up", "player_down"
  )
  state.linear_velocity = player_vector * 210

  # Face player in the direction of where it's moving.
  var angle_to_target : float = player_vector.angle_to(Vector2.UP.rotated(parent.rotation))
  parent.rotate(angle_to_target * 0.1)
  # parent.look_at(parent.global_position + player_vector.rotated(PI / 2))
