extends Popup

onready var _settingsButton : Button = get_node("MarginContainer/MarginContainer/Menu Options/SettingsButton")
onready var _exitToMenuButton : Button = get_node("MarginContainer/MarginContainer/Menu Options/ExitToMenu")
onready var _exitButton : Button = get_node("MarginContainer/MarginContainer/Menu Options/ExitButton")
onready var _closeButton : Button = get_node("MarginContainer/MarginContainer/Menu Options/CloseButton")

onready var _settingsMenu : Popup = get_node("SettingsMenu")
onready var _quitDialog : ConfirmationDialog = null

func _settingsButton_Pressed():
	_settingsMenu.show()

func _exitToMenuButton_Pressed():
	get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")

func _exitButton_Pressed():
	_quitGame()

func _closeButton_Pressed():
	self.hide()

func _ready():	
	_settingsButton.connect("pressed", self, "_settingsButton_Pressed")
	_exitToMenuButton.connect("pressed", self, "_exitToMenuButton_Pressed")
	_exitButton.connect("pressed", self, "_exitButton_Pressed")
	_closeButton.connect("pressed", self, "_closeButton_Pressed")

func _input(event):
	if Input.is_action_just_pressed("ingame_MenuButton"):
		if(self.visible and not _settingsMenu.visible): 
			self.hide()
		elif(_settingsMenu.visible):
			_settingsMenu.hide()
		elif(_quitDialog != null):
			_quitCancelled()
		else:
			self.show()

func _quitGame():
	_quitDialog = ConfirmationDialog.new()
	_quitDialog.set_name("confirmExitDialog")
	add_child(_quitDialog)
	_quitDialog.window_title = "Are you sure?"
	_quitDialog.popup_exclusive = true
	_quitDialog.get_ok().connect("pressed", self, "_quitPressed")
	_quitDialog.get_cancel().connect("pressed", self, "_quitCancelled")
	self.hide()
	_quitDialog.popup_centered()

func _quitPressed():
	get_tree().quit()

func _quitCancelled():
	remove_child(_quitDialog)
	_quitDialog = null
	self.show()
