class_name ObeliskTimer extends Timer

var obelisks : Array[Obelisk]

func _ready() -> void:
  obelisks.assign(get_tree().get_nodes_in_group("obelisk"))
  _on_timeout()

func _process(delta: float) -> void:
  var time_elapsed : float = wait_time - time_left
  for i : int in range(len(obelisks)):
    if time_elapsed > i * len(obelisks) * wait_time:
      obelisks[i].pulse()

func _on_timeout() -> void:
  for obelisk : Obelisk in obelisks:
    obelisk.reset()
  start(wait_time)
