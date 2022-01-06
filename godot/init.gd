extends Node

@onready var model = get_node("Model")
@onready var pin_control = get_node("PinControl")
@onready var state_pres = get_node("StatePresentation")

func _ready():
    pin_control.set_model(model)
    state_pres.set_model(model)
    

