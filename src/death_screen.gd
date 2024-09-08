extends CanvasLayer

@export_category("Scene Internal Nodes")
@export var dialog: Control

func _ready() -> void:
  visible = true
  dialog.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  if len(get_tree().get_nodes_in_group("player")) == 0:
    dialog.visible = true
    
