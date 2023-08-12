extends Area2D

signal take_damage(damage)

func _on_area_entered(area):
    if area.is_in_group("hitbox"):
        emit_signal("take_damage", area.damage)
                

