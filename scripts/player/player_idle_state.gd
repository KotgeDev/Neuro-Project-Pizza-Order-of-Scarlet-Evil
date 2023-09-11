class_name PlayerIdleState
extends State

func physics_process(delta: float) -> void:
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
        state_machine.transition_to("PlayerNukeState")
        
    actor.velocity = actor.velocity.normalized() * actor.speed
    actor.move_and_slide()
    
