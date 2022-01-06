extends Node

signal state_updated(state)

var DATA_REGISTER = [0, 0, 0, 0]
var INSTRUCTION_REGISTER = [0, 0, 0, 0]

const NOTHING = 0
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

const TCK = 0
const TMS = 1
const TDI = 2
const TDO = 3

var pin_state = {
    TCK: false,
    TMS: false,
    TDI: false,
    TDO: false,
}

var state = TEST_LOGIC_RESET
var machine = {
    TEST_LOGIC_RESET: [TEST_LOGIC_RESET, RUN_TEST_IDLE],
    RUN_TEST_IDLE: [SELECT_DR_SCAN, RUN_TEST_IDLE],
    SELECT_DR_SCAN: [SELECT_IR_SCAN, CAPTURE_DR],
    CAPTURE_DR: [EXIT1_DR, SHIFT_DR],
    SHIFT_DR: [EXIT1_DR, SHIFT_DR],
    EXIT1_DR: [UPDATE_DR, PAUSE_DR],
    PAUSE_DR: [EXIT2_DR, PAUSE_DR],
    EXIT2_DR: [UPDATE_DR, SHIFT_DR],
    UPDATE_DR: [SELECT_DR_SCAN, RUN_TEST_IDLE],
    SELECT_IR_SCAN: [TEST_LOGIC_RESET, CAPTURE_IR],
    CAPTURE_IR: [EXIT1_IR, SHIFT_IR],
    SHIFT_IR: [EXIT1_IR, SHIFT_IR],
    EXIT1_IR: [UPDATE_IR, PAUSE_IR],
    PAUSE_IR: [EXIT2_IR, PAUSE_IR],
    EXIT2_IR: [UPDATE_IR, SHIFT_IR],
    UPDATE_IR: [SELECT_DR_SCAN, RUN_TEST_IDLE],
}


func tick():
    if pin_state[TMS]:
        state = machine[state][0]
    else:
        state = machine[state][1]
    
    # Assumption: Shifting on rising edge.
    if state == SHIFT_DR:
        DATA_REGISTER.push_front(pin_state[TDI])
        pin_state[TDO] = DATA_REGISTER.pop_back()
    
    if state == SHIFT_IR:
        INSTRUCTION_REGISTER.push_front(pin_state[TDI])
        pin_state[TDO] = INSTRUCTION_REGISTER.pop_back()
    
    emit_signal("state_updated", state)


func set(pin, v = true):
    pin_state[pin] = v

func clr(pin):
    pin_state[pin] = false

func get(pin):
    return pin_state[pin]

