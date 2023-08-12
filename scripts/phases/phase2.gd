extends Node2D

signal complete 

# Variables important for balancing
const MAX_HEALTH = 400 
var health = MAX_HEALTH
var initial_speed = 150
var loop_speed

@onready var evil_neuro = GlobalVariables.evil_neuro
@onready var left_position = $LeftPosition.global_position 
@onready var right_position = $RightPosition.global_position
@onready var timer = $Timer
@onready var timer2 = $Timer2

var pattern2_scene = preload("res://scenes/patterns/pattern2.tscn")
var pattern3_scene = preload("res://scenes/patterns/pattern3.tscn")
var initialized_position = false
var moving_to_right_position = false 
var phase_over = false 

func _ready():
    set_difficulty()
    
    evil_neuro.take_damage.connect(_take_damage)

func _process(delta):
    if not initialized_position: 
        initialize_position(delta)
    else: 
        move_back_and_forth(delta)

func initialize_position(delta): 
    evil_neuro.position = evil_neuro.position.move_toward(left_position, delta * initial_speed)
    if evil_neuro.position == left_position: 
        initialized_position = true 
        moving_to_right_position = true
        if timer.time_left == 0 and timer2.time_left == 0:
            timer.start() 
            timer2.start()
            
func move_back_and_forth(delta):
    if moving_to_right_position: 
        evil_neuro.position = evil_neuro.position.move_toward(right_position, delta * loop_speed)
        if evil_neuro.position == right_position: 
            moving_to_right_position = false  
    else: 
        evil_neuro.position = evil_neuro.position.move_toward(left_position, delta * loop_speed)
        if evil_neuro.position == left_position: 
            moving_to_right_position = true 
 

func _take_damage(damage): 
    health -= damage
    GlobalVariables.health_bar.health_changed(health, MAX_HEALTH)
    if health <= 0 and not phase_over: 
        phase_over = true 
        GlobalVariables.health_bar.reset() 
        complete.emit()
        queue_free() 
        
func _on_timer_timeout():
    var pattern2 = pattern2_scene.instantiate()
    add_child(pattern2)

func _on_timer2_timeout():
    var pattern3 = pattern3_scene.instantiate()
    add_child(pattern3)

func set_difficulty():
    if GlobalVariables.difficulty_level == 0: 
        loop_speed = 5 
        $Timer.wait_time = 1.5
        $Timer2.wait_time = 10
    if GlobalVariables.difficulty_level == 1: 
        loop_speed = 10
        $Timer.wait_time = 1.3
        $Timer2.wait_time = 7
    if GlobalVariables.difficulty_level == 2:
        loop_speed = 20
        $Timer.wait_time = 1
        $Timer2.wait_time = 5 
    if GlobalVariables.difficulty_level == 3: 
        loop_speed = 30
        $Timer.wait_time = 0.8
        $Timer2.wait_time = 3
