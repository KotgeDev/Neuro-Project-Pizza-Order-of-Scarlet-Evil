extends Node2D

signal complete 

# Variables important for balancing
const MAX_HEALTH = 200 
var health = MAX_HEALTH 
var speed
var wait_time

@onready var evil_neuro = GlobalVariables.evil_neuro

var pattern1_scene = preload("res://scenes/patterns/pattern1.tscn")
var rng = RandomNumberGenerator.new() 
var destination
var moving = false
var fired = false
var phase_over = false  

func _ready():
    set_difficulty() 
    evil_neuro.take_damage.connect(_take_damage)

func _process(delta):
    if moving: 
        move(delta)
    else: 
        destination = Vector2(rng.randi_range(60, 315), rng.randi_range(60, 225))
        moving = true 

func move(delta): 
    evil_neuro.position = evil_neuro.position.move_toward(destination, delta * speed)
    if evil_neuro.position == destination: 
        if not fired: 
            fired = true 
            
            var pattern1 = pattern1_scene.instantiate()
            add_child(pattern1)
            await get_tree().create_timer(wait_time).timeout 
            moving = false
            
            fired = false 

func _take_damage(damage): 
    health -= damage
    GlobalVariables.health_bar.health_changed(health, MAX_HEALTH)
    if health <= 0 and not phase_over: 
        phase_over = true 
        GlobalVariables.health_bar.reset() 
        complete.emit()
        queue_free() 

func set_difficulty():
    if GlobalVariables.difficulty_level == 0: 
        speed = 125 
        wait_time = 1.2
    if GlobalVariables.difficulty_level == 1: 
        speed = 150 
        wait_time = 1
    if GlobalVariables.difficulty_level == 2:
        speed = 170 
        wait_time = 1
    if GlobalVariables.difficulty_level == 3: 
        speed = 200 
        wait_time = 0.8
