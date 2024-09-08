extends Button



func restart_game() -> void:
  get_tree().paused = false
  var _ignore: int = get_tree().reload_current_scene()
