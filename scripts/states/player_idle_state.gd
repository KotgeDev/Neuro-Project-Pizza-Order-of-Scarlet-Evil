class_name PlayerIdleState
extends State

@export var actor: Player

signal player_nuked

func _ready():
    set_physics_process(false)
    
func _enter_state() -> void: 
    set_physics_process(true)

func _exit_state() -> void:
    set_physics_process(false)

func _physics_process(delta: float) -> void:
    if Input.is_action_pressed("right"):
        actor.velocity.x = 1
    if Input.is_action_pressed("left"):
        actor.velocity.x = -1
    if Input.is_action_pressed("down"):
        actor.velocity.y = 1
    if Input.is_action_pressed("up"):
        actor.velocity.y = -1
        
    if Input.is_action_pressed("shoot"):
        actor.drone_moving = true 
        actor.shooting = true
    else:
        actor.drone_moving = false 
        actor.shooting = false 
    
    if Input.is_action_just_pressed("nuke") and actor.nuke_timer.time_left == 0:
        player_nuked.emit()
        
    actor.velocity = actor.velocity.normalized() * actor.speed
    actor.move_and_slide()
    
