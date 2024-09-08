extends ProgressBar


func _process(delta: float) -> void:
  var player_health_nodes: Array[Node] = get_tree().get_nodes_in_group("player_health")
  if len(player_health_nodes) > 0:
    var player_health: PlayerHealth = get_tree().get_nodes_in_group("player_health")[0]
    value = player_health.health
  else:
    value = 0
