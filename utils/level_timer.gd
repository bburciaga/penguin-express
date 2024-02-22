extends Label

var timer

func _init():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true

func _on_timer_timeout():
	print('timed out')
	visible = not visible
