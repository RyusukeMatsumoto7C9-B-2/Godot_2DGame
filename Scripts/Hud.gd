extends CanvasLayer

signal start_game

func _ready():
	pass


func _process(delta):
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
	
func update_score(score):
	$ScoreLabel.text = str(score)


func show_game_over():
	show_message("GameOver")
	
	# MessageTimer の timeout まで待機.
	await $MessageTimer.timeout
	
	$Message.text = "ねっ子をよけろ！"
	$Message.show()
	
	# 1秒待機する one-shot タイマーを作成し、待機、その後 StartButton を表示する.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	

func _on_message_timer_timeout():
	$Message.hide()

