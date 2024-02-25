extends Node2D

@onready var state_machine: StateMachine = $StateMachine
@onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	state_machine.current_state.emit_signal("Transitioned", state_machine.current_state, "Run")
	player_vars.score = 0
