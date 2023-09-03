class_name PlayerNukeState
extends State

@export var actor: Player 

var inuke6000_scene = preload("res://scenes/player/inuke6000.tscn")

signal nuke_finished

# Called when the node enters the scene tree for the first time.
func _ready():
    set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _enter_state() -> void:
    set_process(true)
    actor.shooting = false 
    actor.nuke_timer.start() 
    var inuke6000 = inuke6000_scene.instantiate()
    inuke6000.finished.connect(_on_nuke_finished) 
    actor.add_child(inuke6000)
    
func _exit_state() -> void: 
    set_process(false)

func _on_nuke_finished():
    nuke_finished.emit()
