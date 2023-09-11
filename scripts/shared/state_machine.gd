class_name StateMachine
extends Node

@export var initial_state := NodePath()

@onready var state: State = get_node(initial_state)

func init(actor: Node2D) -> void:
    for child in get_children():
        child.state_machine = self 
        child.actor = actor 
    state.enter()

func input(event: InputEvent) -> void:
    state.input(event)

func process(delta: float) -> void: 
    state.process(delta)

func physics_process(delta: float) -> void:
    state.physics_process(delta)

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
    if not has_node(target_state_name):
        return

    state.exit()
    state = get_node(target_state_name)
    state.enter(msg)
