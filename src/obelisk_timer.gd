class_name ObeliskTimer extends Timer

var obelisks : Array[Obelisk]

func _ready() -> void:
  obelisks.assign(get_tree().get_nodes_in_group("obelisk"))
  for obelisk : Obelisk in obelisks:
    obelisk.power_duration = wait_time
  _on_timeout()

func _process(delta: float) -> void:
  var time_elapsed : float = wait_time - time_left
  for i : int in range(len(obelisks)):
    obelisks[i].pulse()
    obelisks[i].update_pulse_wave(time_elapsed / wait_time)

func _on_timeout() -> void:
  for obelisk : Obelisk in obelisks:
    obelisk.reset()
  start(wait_time)
