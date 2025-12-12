function Player(new_index, new_player_number = 0, new_device = "", new_player_instance = 0) constructor{
	
	///USER GAME INFO
	index = new_index;
	player_number = new_player_number;
	device = new_device;
	player_instance = new_player_instance;
	is_active = false;
	in_game = false;
	///INPUT CONTROL
	input_allowed = true;
	input_ready = true;
	input_delay = 10;
	input_timer = 0;
	
	///INPUT VARIABLES
	up = false;
	down = false;
	left = false;
	right = false;
	wKey = ord("W");
	aKey = ord("A");
	sKey = ord("S");
	dKey = ord("D");
	enterKey = vk_enter;
	spaceKey = vk_space;
	horizontal_axis = 0;
	vertical_axis = 0;
	action_1 = false;
	action_2 = false;
	action_3 = false;
	action_1_released = false;
	action_2_released = false;
	action_3_released = false;
	start = false;
	
	///DEBUG INPUTS
	f1 = false;
	f2 = false;
	f3 = false;
	f4 = false;
	f5 = false;
	f6 = false;
	f7 = false;
	f8 = false;
	f9 = false;
	
	
	static set_palette_index = function(_index){
		palette_index = _index;
	}
	static get_next_palette = function(){
		palette_index = palette_index + 1;
		var colors = pal_swap_get_pal_count(character.palette) - 1;
		if(palette_index > colors){
			palette_index = 0;
		}	
	}
	static get_prev_palette = function(){
		palette_index = palette_index - 1;
		var colors = pal_swap_get_pal_count(character.palette) - 1;
		if(palette_index < 0){
			palette_index = colors;
		}
	}
	static set_character = function(){
		get_player_bug_characters(self);
	}
	character = "";
	palette_index = 0;
	switch(player_number){
		case 1:
			palette_index = 0;
		break;
		case 2:
			palette_index = 1;
		break;
		case 3:
			palette_index = 2;
		break;
		case 4:
			palette_index = 3;
		break;
	}
	
}

function Bug_Character(new_name,new_character_sprite,new_palette = wiz_palette) constructor{
	character_name = new_name;
	character_sprite = new_character_sprite;
	palette = new_palette;
}

function find_player_user(_player){
	for(var i = 0;i < array_length(global._users);i++){
		var current_user = global._users[i];
		if(current_user.user_index == _player.index){
			return current_user;
		}
	}
}

function get_player_bug_characters(player){
	var user = find_player_user(player);
	if(not_null(user.saves_data)){
		var saves = array_length(user.saves_data);
		if(saves > 0){
			for(var i = 0; i < saves; i++){
				if(user.saves_data[i].game == Buggin_Out){
					///Game found, get characters.
					var save_data = user.saves_data[i];
					if(not_null(save_data)){
						return save_data.game_data.characters;
					}else{
						///Save data Null. Will need initialization.
						show_debug_message("Save data Null. Will need initialization.");
						return;
					}
				}
			}
		}else{
			var new_save = new Save_Data(Buggin_Out,user)
			return new_save.game_data.characters;
		}
	}
}
	
function get_char_sprite(player){
	var user = find_player_user(player);
	var chars = get_player_bug_characters(player);
	player.character = chars[0];
}
