extends Label

var time_passed: float = 0.0
var running: bool = true

func _process(delta: float) -> void:
	if running:
		time_passed += delta
		text = format_time(time_passed)


func format_time(time: float) -> String:
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	var milliseconds = int((time - int(time)) * 100)

	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]


func stop_timer():
	running = false
