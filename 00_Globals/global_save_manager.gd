extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save: Dictionary = {
	world_id = "", ## id of the generated world that is saved seperate
	player = {
		hp = 1,
		max_hp = 1,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [],
	quests = [],
}

func save_game() -> void:
	update_player_data()
	update_item_data()
	var file := FileAccess.open(SAVE_PATH + "save_sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	pass

func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "save_sav", FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary
	current_save = save_dict
	
	## LevelManager.load_world()
	
	PlayerManager.set_player_position(Vector2(current_save.player.pos_x, current_save.player.pos_y))
	PlayerManager.set_health(current_save.player.hp, current_save.player.max_hp)
	PlayerManager.INVENTORY_DATA.parse_save_data(current_save.items)
	
	## await Level loaded
	
	game_loaded.emit()
	pass

func update_player_data() -> void:
	var p: Player = PlayerManager.player
	current_save.player.hp = p.hp
	current_save.player.max_hp = p.max_hp
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y

func update_item_data() -> void:
	current_save.items = PlayerManager.INVENTORY_DATA.get_save_data()