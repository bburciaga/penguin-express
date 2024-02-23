extends Node2D

@onready var state_machine: StateMachine = $StateMachine

func _ready():
	state_machine.current_state.emit_signal("Transitioned", state_machine.current_state, "Run")
