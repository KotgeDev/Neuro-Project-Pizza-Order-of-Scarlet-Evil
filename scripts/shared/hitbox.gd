extends Area2D

signal destroyed 

@export var damage = 0

func _on_area_entered(area):
    emit_signal("destroyed")

