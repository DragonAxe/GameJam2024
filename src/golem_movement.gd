class_name GolemMovement extends Node

@export var movement_speed: float = 100.0

@export var discovery_distance: float = 1000

@export_category("Sibling nodes")
@export var discovery_sound: AudioStreamPlayer2D

@export_category("Internal nodes")
@export var navigation_agent: NavigationAgent2D

@onready var parent: RigidBody2D = get_parent()

enum AiState {
  REST,
  RANDOM_PATROL,
  RANDOM_PATROL_WAIT,
  FOLLOW_PLAYER,
}
var ai_state: AiState = AiState.REST

var linear_velocity: Vector2 = Vector2.ZERO
var safe_linear_velocity: Vector2 = Vector2.ZERO
var next_path_position: Vector2 = Vector2.ZERO

func _ready() -> void:
  var player: RigidBody2D = get_tree().get_first_node_in_group("player")
  set_movement_target.call_deferred(player.global_position)
  var _ignore: int = navigation_agent.velocity_computed.connect(on_agent_velocity_computed)


func _physics_process(_delta: float) -> void:
  # Decide where to walk
  match ai_state:
    AiState.REST:
      rest()
      
    AiState.RANDOM_PATROL:
      random_patrol()
      parent.modulate = Color.YELLOW
      
    AiState.RANDOM_PATROL_WAIT:
      random_patrol_wait()
      parent.modulate = Color.YELLOW
      
    AiState.FOLLOW_PLAYER:
      follow_player()
      parent.modulate = Color.RED


  # Walk there
  if not navigation_agent.is_navigation_finished():
    var current_agent_position: Vector2 = parent.global_position
    next_path_position = navigation_agent.get_next_path_position()
    linear_velocity = (
      current_agent_position.direction_to(next_path_position)
      * (movement_speed)
    )
  else:
    linear_velocity = Vector2.ZERO


func integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  state.linear_velocity = linear_velocity
  state.transform = state.transform.looking_at(
    (next_path_position - parent.global_position).rotated(PI/2)
    + parent.global_position
  )


var rest_cooldown: SceneTreeTimer
func rest() -> void:
  set_movement_target(parent.global_position)
  if !rest_cooldown:
    rest_cooldown = get_tree().create_timer(randf() * 4 + 0.5)
    var _ignore: int = rest_cooldown.timeout.connect(rest_timeout)
  var player: RigidBody2D = get_tree().get_first_node_in_group("player")
  var player_distance: float = player.global_position.distance_to(parent.global_position)
  if player_distance < 500:
    rest_cooldown.timeout.disconnect(rest_timeout)
    rest_cooldown = null
    ai_state = AiState.FOLLOW_PLAYER
    discovery_sound.play()
func rest_timeout() -> void:
  rest_cooldown = null
  ai_state = AiState.RANDOM_PATROL


func random_patrol() -> void:
  var random_point: Vector2 = NavigationServer2D.map_get_random_point(
    navigation_agent.get_navigation_map(), 1, false
  )
  set_movement_target(random_point)
  ai_state = AiState.RANDOM_PATROL_WAIT


func random_patrol_wait() -> void:
  if navigation_agent.is_navigation_finished():
    ai_state = AiState.REST
  var player: RigidBody2D = get_tree().get_first_node_in_group("player")
  var player_distance: float = player.global_position.distance_to(parent.global_position)
  if player_distance < discovery_distance:
      ai_state = AiState.FOLLOW_PLAYER
      discovery_sound.play()
  
  
func follow_player() -> void:
  var player: RigidBody2D = get_tree().get_first_node_in_group("player")
  set_movement_target(player.global_position)
  var player_distance: float = player.global_position.distance_to(parent.global_position)
  if player_distance > discovery_distance:
    ai_state = AiState.RANDOM_PATROL


func set_movement_target(movement_target: Vector2) -> void:
  await get_tree().physics_frame
  navigation_agent.target_position = movement_target
  navigation_agent.velocity = linear_velocity


func on_agent_velocity_computed(safe_velocity: Vector2) -> void:
  safe_linear_velocity = safe_velocity

func power_up(power_type: Obelisk.PowerType) -> void:
  if power_type == Obelisk.PowerType.FAST:
    print("power up (fast)")
  if power_type == Obelisk.PowerType.SENSORY:
    print("power up (sensory)")
  if power_type == Obelisk.PowerType.REPULSE:
    print("power up (repulse)")

func power_down(power_type: Obelisk.PowerType) -> void:
  if power_type == Obelisk.PowerType.FAST:
    print("power down... (fast)")
  if power_type == Obelisk.PowerType.SENSORY:
    print("power down... (sensory)")
  if power_type == Obelisk.PowerType.REPULSE:
    print("power down... (repulse)")
