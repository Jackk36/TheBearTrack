extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	set_contact_monitor(true)
	is_contact_monitor_enabled()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
