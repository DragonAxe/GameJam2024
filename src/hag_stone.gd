extends Node2D

@export var matched_obelisk: Obelisk

@export_category("Internal nodes")
@export var snap_area: Area2D

var captured: int = 0


func _physics_process(delta: float) -> void:
  for area: Area2D in snap_area.get_overlapping_areas():
    if area.get_parent() is Obelisk:
      var obelisk: Obelisk = area.get_parent()
      if area.get_parent() != self:
        if captured == 0:
          captured = 30
          capture_obelisk.call_deferred(obelisk)
  if len(snap_area.get_overlapping_areas()) == 0:
    if captured > 0:
      captured -= 1



func capture_obelisk(obelisk: Obelisk) -> void:
  obelisk.get_parent().remove_child(obelisk)
  add_child(obelisk)
  obelisk.global_position = global_position
