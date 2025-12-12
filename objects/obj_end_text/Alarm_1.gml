///check if player has new character already
var user = find_player_user(global.players[0]);
if(not_null(user)){
	var data = user.get_current_save_data();
	var characters = data.game_data.characters;
	if(not_null(characters)){
		if(array_length(characters) <= 1){
			show_character = true;
			scribble_object = scribble("New character unlocked!");
			data.game_data.fill_character_roster();
			alarm[2] = 360;
			return;
		}else{
			input_enable_all_input();
			room_goto(rm_Start);
		}
	}	
}