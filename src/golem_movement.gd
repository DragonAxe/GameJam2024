extends Node

@export var movement_speed: float = 200.0

@export_category("Internal nodes")
@export var navigation_agent: NavigationAgent2D

@onready var parent: RigidBody2D = get_parent()


func _ready() -> void:
  var player: RigidBody2D = get_tree().get_first_node_in_group("player")
  set_movement_target.call_deferred(player.global_position)


func integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  var player: RigidBody2D = get_tree().get_first_node_in_group("player")
  set_movement_target(player.global_position)
  var current_agent_position: Vector2 = parent.global_position
  var next_path_position: Vector2 = navigation_agent.get_next_path_position()
  state.linear_velocity = (
    current_agent_position.direction_to(next_path_position)
    * (movement_speed)
  )
  state.transform = state.transform.looking_at(
    (next_path_position - parent.global_position).rotated(PI/2)
    + parent.global_position
  )


func set_movement_target(movement_target: Vector2) -> void:
  await get_tree().physics_frame
  navigation_agent.target_position = movement_target
