extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass


func integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  var player_vector: Vector2 = Input.get_vector(
    "player_left", "player_right", "player_up", "player_down"
  )
  state.linear_velocity = player_vector * 210
