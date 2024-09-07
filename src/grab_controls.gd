extends Node

@export var grab_area : Area2D

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("player_grab_release"):
    # Check whether the player is already holding an obelisk.
    var already_holding : bool = false
    for child : Node in grab_area.get_children():
      if child is Obelisk:
        already_holding = true
        break
    
    if already_holding:
      # Check that the obelisk is not overlapping a wall or enemy and that it's inside the map.
      
      pass
    else:
      # Check that the obelisk is very close to the player in the direction that they're facing.
      var obelisk_areas : Array[Area2D] = grab_area.get_overlapping_areas()
      if len(obelisk_areas) > 0:
        var obelisk : Obelisk = obelisk_areas[0].get_parent()
        obelisk.get_parent().remove_child(obelisk)
        grab_area.add_child(obelisk)
        obelisk.position = Vector2.ZERO
