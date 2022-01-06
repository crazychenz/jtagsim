extends Control

# Copied from model
const TCK = 0
const TMS = 1
const TDI = 2
const TDO = 3

# This is set with set_model by Root's _ready
var model

@onready var ir = find_node("IRValue")
@onready var dr = find_node("DRValue")

@onready var pin_node = {
    TCK: find_node("TCK"),
    TMS: find_node("TMS"),
    TDI: find_node("TDI"),
    TDO: find_node("TDO"),
}


func set_model(node):
    model = node

func _flip(pin):
    model.set(pin, !model.get(pin))
    
    var v = 0
    if model.get(pin):
        v = 1
    
    pin_node[pin].get_node("state").set_text("%d" % [v])
    
func flip(pin):
    _flip(pin)
    
    if pin == TCK and model.get(TCK) == true:
        _flip(pin)
        model.tick()

func _ready():
    print(pin_node[TCK].find_node("button"))
    pin_node[TCK].find_node("button").connect("pressed", self.flip, [TCK])
    pin_node[TMS].find_node("button").connect("pressed", self.flip, [TMS])
    pin_node[TDI].find_node("button").connect("pressed", self.flip, [TDI])
    pin_node[TDO].find_node("button").connect("pressed", self.flip, [TDO])

func _process(delta):
    ir = model.DATA_REGISTER


