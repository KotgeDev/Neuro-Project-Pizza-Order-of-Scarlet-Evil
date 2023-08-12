extends CharacterBody2D

signal destroyed 

const DEFAULT_SPEED = 175 
const FOCUS_SPEED = 75
const DRONE_SPEED = 150

var health = 3
var speed = DEFAULT_SPEED
var shooting = false
var drone_moving = false  
var carrot_scene = preload("res://scenes/projectiles/carrot.tscn")
var inuke6000_scene = preload("res://scenes/player/inuke6000.tscn")

@onready var drone1_animations = $Drone1Animations
@onready var drone2_animations = $Drone2Animations
@onready var drone1_sprite = $Drone1Sprite
@onready var drone2_sprite = $Drone2Sprite
@onready var drone1_idle_position = $Drone1IdlePosition
@onready var drone1_attack_position = $Drone1AttackPosition
@onready var drone2_idle_position = $Drone2IdlePosition
@onready var drone2_attack_position = $Drone2AttackPosition
@onready var carrot1_position = $Carrot1Position
@onready var carrot2_position = $Carrot2Position
@onready var carrot3_position = $Carrot3Position
@onready var carrot4_position = $Carrot4Position

func _ready(): 
    drone1_animations.play("idle")
    drone2_animations.play("idle")

func _physics_process(delta):
    get_input(delta)
    velocity = velocity.normalized() * speed
    move_and_slide()

func get_input(delta):     
    velocity = Vector2.ZERO 
    
    if Input.is_action_pressed("right"):
        velocity.x = 1
    if Input.is_action_pressed("left"):
        velocity.x = -1
    if Input.is_action_pressed("down"):
        velocity.y = 1
    if Input.is_action_pressed("up"):
        velocity.y = -1
        
    if Input.is_action_just_pressed("focus"):
        enable_focus() 
    if Input.is_action_just_released("focus"): 
        disable_focus() 
    
    if Input.is_action_just_pressed("shoot"):
        drone_moving = true 
        shooting = true
    if Input.is_action_just_released("shoot"):
        drone_moving = false 
        shooting = false 
        
    if Input.is_action_just_pressed("nuke"):
        nuke() 
        
    if drone_moving:
        drone1_sprite.position = drone1_sprite.position.move_toward(drone1_attack_position.position, delta * DRONE_SPEED)
        drone2_sprite.position = drone2_sprite.position.move_toward(drone2_attack_position.position, delta * DRONE_SPEED)
    else: 
        drone1_sprite.position = drone1_sprite.position.move_toward(drone1_idle_position.position, delta * DRONE_SPEED)
        drone2_sprite.position = drone2_sprite.position.move_toward(drone2_idle_position.position, delta * DRONE_SPEED)
                
func enable_focus():
    speed = FOCUS_SPEED 

func disable_focus():
    speed = DEFAULT_SPEED 
    
func nuke(): 
    add_child(inuke6000_scene.instantiate())

func shoot(): 
    var carrot1 = carrot_scene.instantiate()
    var carrot2 = carrot_scene.instantiate() 
    var carrot3 = carrot_scene.instantiate()
    var carrot4 = carrot_scene.instantiate()
    get_parent().add_child(carrot1)
    get_parent().add_child(carrot2)
    get_parent().add_child(carrot3)
    get_parent().add_child(carrot4)
    carrot1.position = carrot1_position.global_position 
    carrot2.position = carrot2_position.global_position
    carrot3.position = carrot3_position.global_position 
    carrot4.position = carrot4_position.global_position 

func _on_shoot_timer_timeout():
    if shooting: 
        shoot() 

func _on_hurtbox_take_damage(damage):
    health -= 1 
    if health == 0: 
        destroyed.emit()
