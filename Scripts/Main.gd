extends Node

@export var mob_scene: PackedScene
var score


func _ready():
	pass


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	get_tree().call_group("mobs", "queue_free")
	
	

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


# Mob を生成してランダムな方向に移動するようにする.
func _on_mob_timer_timeout():
	# Mob インスタンスを新たに作成.
	var mob = mob_scene.instantiate()
	
	# Path2D からランダムな位置を取得.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Mob の Path に垂直な方向を取得.
	var direction = mob_spawn_location.rotation + PI /2
	
	# Mob にランダムな座標を設定.
	mob.position = mob_spawn_location.position
	
	# Mob にランダムな方向を与える.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Mob に 150 ~ 250 の間で移動力を設定.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Main シーンに Mob をスポーンさせる.
	add_child(mob)
	
	
	


