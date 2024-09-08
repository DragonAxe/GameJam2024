extends Node

@export var grab_area : Area2D
@export var map : Sprite2D

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("player_grab_release"):
    # Check whether the player is already holding an obelisk.
    var obelisk_held : Obelisk = null
    for child : Node in grab_area.get_children():
      if child is Obelisk:
        obelisk_held = child as Obelisk
        break
    
    if obelisk_held:
      var obelisk_position : Vector2 = obelisk_held.global_position
      grab_area.remove_child(obelisk_held)
      get_parent().get_parent().add_child(obelisk_held)
      obelisk_held.position = obelisk_position
    else:
      # Check that the obelisk is very close to the player in the direction that they're facing.
      var obelisk_areas : Array[Area2D] = grab_area.get_overlapping_areas()
      if len(obelisk_areas) > 0:
        var obelisk : Obelisk = obelisk_areas[0].get_parent()
        obelisk.get_parent().remove_child(obelisk)
        grab_area.add_child(obelisk)
        obelisk.position = Vector2.ZERO
