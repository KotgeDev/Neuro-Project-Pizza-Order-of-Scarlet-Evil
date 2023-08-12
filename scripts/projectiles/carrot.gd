extends Node2D

var velocity = Vector2(0, -1)
@export var speed = 1000

func _physics_process(delta):
    position += velocity * speed * delta 


func _self_destruct(): 
    queue_free() 
