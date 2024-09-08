extends Node

@onready var parent: RigidBody2D = get_parent()

var force_amount_slow: float = 300000
var force_amount_fast: float = 800000
var force_amount: float

func _ready() -> void:
  force_amount = force_amount_fast

func _physics_process(delta: float) -> void:
  var player_vector: Vector2 = Input.get_vector(
    "player_left", "player_right", "player_up", "player_down"
  )
  parent.apply_central_force(delta * player_vector * force_amount)


func integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  var player_vector: Vector2 = Input.get_vector(
    "player_left", "player_right", "player_up", "player_down"
  )
  #state.linear_velocity = player_vector * 210

  # Face player in the direction of where it's moving.
  var player_angle : float = player_vector.angle()
  if player_vector != Vector2.ZERO:
    var target_angle : float = lerp_angle(parent.rotation, player_angle + PI / 2, 0.25)
    parent.rotation = target_angle

func power_up(power_type: Obelisk.PowerType, vector_away: Vector2) -> void:
  if power_type == Obelisk.PowerType.SLOW:
    force_amount = force_amount_slow
  if power_type == Obelisk.PowerType.REPULSE:
    parent.apply_central_force(vector_away * 800000)

func power_down(power_type: Obelisk.PowerType) -> void:
  if power_type == Obelisk.PowerType.SLOW:
    force_amount = force_amount_fast
