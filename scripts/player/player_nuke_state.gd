class_name PlayerNukeState
extends State

var inuke6000_scene = preload("res://scenes/player/inuke6000.tscn")

func enter(_msg := {}) -> void:
    set_process(true)
    actor.shooting = false 
    actor.nuke_timer.start() 
    var inuke6000 = inuke6000_scene.instantiate()
    inuke6000.finished.connect(_on_nuke_finished) 
    actor.add_child(inuke6000)

func _on_nuke_finished():
    state_machine.transition_to("PlayerIdleState")
