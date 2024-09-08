extends CanvasLayer


func _process(delta: float) -> void:
  var obelisks: Array[Node] = get_tree().get_nodes_in_group("hag_stone")
  var completed_count: int = 0
  for obelisk: Obelisk in obelisks:
    if obelisk.completed:
      completed_count += 1
  if completed_count == len(obelisks):
    visible = true
