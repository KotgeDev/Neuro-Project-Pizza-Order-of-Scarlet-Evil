class_name Player
extends CharacterBody2D

signal destroyed 

const DEFAULT_SPEED = 175 
const FOCUS_SPEED = 75
const DRONE_SPEED = 150

var health = 3
var speed = DEFAULT_SPEED
var carrot_scene = preload("res://scenes/projectiles/carrot.tscn")

# Checks 
var shooting = false
var drone_moving = false  

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
@onready var neuro_sprite = $NeuroSprite
@onready var nuke_timer = $NukeTimer
@onready var sm = $StateMachine as StateMachine 
@onready var player_idle_state = $StateMachine/PlayerIdleState as PlayerIdleState
@onready var player_nuke_state = $StateMachine/PlayerNukeState as PlayerNukeState


func _ready(): 
    drone1_animations.play("idle")
    drone2_animations.play("idle")
    
    player_idle_state.player_nuked.connect(sm.change_state.bind(player_nuke_state))
    player_nuke_state.nuke_finished.connect(sm.change_state.bind(player_idle_state))

func _physics_process(delta):
    get_input(delta)

func get_input(delta):     
    velocity = Vector2.ZERO 
        
    if Input.is_action_pressed("focus"):
        speed = FOCUS_SPEED 
    else: 
        speed = DEFAULT_SPEED 
        
    if drone_moving:
        drone1_sprite.position = drone1_sprite.position.move_toward(drone1_attack_position.position, delta * DRONE_SPEED)
        drone2_sprite.position = drone2_sprite.position.move_toward(drone2_attack_position.position, delta * DRONE_SPEED)
    else: 
        drone1_sprite.position = drone1_sprite.position.move_toward(drone1_idle_position.position, delta * DRONE_SPEED)
        drone2_sprite.position = drone2_sprite.position.move_toward(drone2_idle_position.position, delta * DRONE_SPEED)

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
    neuro_sprite.modulate = Color("bb0002")
    await get_tree().create_timer(0.05).timeout 
    neuro_sprite.modulate = Color("ffffff")

