class_name WinTracker extends CanvasLayer

@export_category("Scene Internal Nodes")
@export var dialog: Control

var completed_obelisk_count: int = 0
var obelisk_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  dialog.visible = false

  for obelisk : Obelisk in get_tree().get_nodes_in_group("obelisk"):
    obelisk.set_win_tracker(self)
    obelisk_count = obelisk_count + 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass

func increment() -> void:
  completed_obelisk_count = completed_obelisk_count + 1
  if completed_obelisk_count == obelisk_count:
    dialog.visible = true
