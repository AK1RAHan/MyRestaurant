extends Node3D

@onready var Player = $"../../Player"
@onready var komporText = $Kompor/Text

func _process(delta: float) -> void:
	var tampilanIcon = Player.tampilkanIcon
	if tampilanIcon:
		komporText.show()
	else:
		komporText.hide()
	pass
