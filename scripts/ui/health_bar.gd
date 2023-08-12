extends TextureProgressBar

func _ready(): 
    GlobalVariables.health_bar = self 

func health_changed(health, max_health):
    value = float(health) / max_health * 100 


func reset():
    value = 100 

