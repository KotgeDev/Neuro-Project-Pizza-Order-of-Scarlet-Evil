extends Node2D

var velocity = Vector2(1, 0)
@export var speed = 406.25

func _physics_process(delta):
    position += velocity * speed * delta 

func _self_destruct(): 
    queue_free() 
