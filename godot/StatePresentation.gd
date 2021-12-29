extends Node2D

var model

# Copied from jtag model.
const TEST_LOGIC_RESET = 1
const RUN_TEST_IDLE = 2
const SELECT_DR_SCAN = 3
const CAPTURE_DR = 4
const SHIFT_DR = 5
const EXIT1_DR = 6
const PAUSE_DR = 7
const EXIT2_DR = 8
const UPDATE_DR = 9
const SELECT_IR_SCAN = 10
const CAPTURE_IR = 11
const SHIFT_IR = 12
const EXIT1_IR = 13
const PAUSE_IR = 14
const EXIT2_IR = 15
const UPDATE_IR = 16

onready var positions = {
    TEST_LOGIC_RESET: find_node("TEST_LOGIC_RESET"),
    RUN_TEST_IDLE: find_node("RUN_TEST_IDLE"),
    SELECT_DR_SCAN: find_node("SELECT_DR_SCAN"),
    CAPTURE_DR: find_node("CAPTURE_DR"),
    SHIFT_DR: find_node("SHIFT_DR"),
    EXIT1_DR: find_node("EXIT1_DR"),
    PAUSE_DR: find_node("PAUSE_DR"),
    EXIT2_DR: find_node("EXIT2_DR"),
    UPDATE_DR: find_node("UPDATE_DR"),
    SELECT_IR_SCAN: find_node("SELECT_IR_SCAN"),
    CAPTURE_IR: find_node("CAPTURE_IR"),
    SHIFT_IR: find_node("SHIFT_IR"),
    EXIT1_IR: find_node("EXIT1_IR"),
    PAUSE_IR: find_node("PAUSE_IR"),
    EXIT2_IR: find_node("EXIT2_IR"),
    UPDATE_IR: find_node("UPDATE_IR"),
}

onready var box = find_node("highlighter")

func set_model(node):
    model = node
    model.connect("state_updated", self, "update_highlighter")

func update_highlighter(state):
    print("Yo")
    box.pos = positions[state].get_position()




