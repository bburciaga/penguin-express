extends Label

@onready var state_machine: StateMachine = get_tree().get_first_node_in_group("StateMachine")
var time: int = 30

func _init():
	self.set_text(str(time))

func _on_timer_timeout():
	if "Idle" == state_machine.current_state.name:
		return
	
	if 0 < time:
		time -= 1
		self.set_text(str(time))
	else:
		visible = not visible
