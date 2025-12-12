global._users = array_create(0);


function User(_user_index,_user_name,new_is_guest, new_player_data = "",new_saves_data = "") constructor{
//this will be used later to load settings for player profiles and such.
	user_index = _user_index;
	player_data = new_player_data;
	user_name = _user_name;
	is_guest = new_is_guest;
	input_config = {};
	gp_input_config = {};
	kb_input_config = {};
	saves_data = new_saves_data;
	if(is_null(saves_data)){saves_data = array_create(0);}

	
	static set_player_data = function(){
		if(is_null(player_data)){
			for(var i = 0; i < INPUT_MAX_PLAYERS;i++){
				if(is_null(global.players[i])){
					player_data = new Player(user_index,i,InputDeviceGetNewActivity());
					global.players[i] = player_data;
				}
			}
		}else{
			var player_found = false;
			for(var i = 0; i < INPUT_MAX_PLAYERS;i++){
				var current_player = global.players[i];
				if(current_player == player_data){
					player_found = true;
				}
			}
			if(player_found == false){
				for(var i = 0; i < INPUT_MAX_PLAYERS;i++){
					var current_player = global.players[i];
					if(is_null(current_player)){
						global.players[i] = player_data;
						return;
					}
				}
			}
		}
	}
	
	static set_user_data = function(){
		var user_found = false;
		for(var i = 0;i < array_length(global._users);i++){
			var current_user = global._users[i];
			if(not_null(current_user)){
				if(current_user.user_index == user_index){
					user_found = true;
				}
			}
		}
		if(!user_found){
			if(array_length(global._users) > 0){
				for(var i = 0; i < array_length(global._users);i++){
					var current_user = global._users[i];
					if(is_null(current_user)){
						global._users[i] = self;
					}
				}
			}else{
				global._users[0] = self;
			}
		}
	}
	
	static set_gamepad = function(_index){
		if(not_null(player_data)){
			player_data.device = _index;
		}
	}
		
	static set_gamepad_next_available = function(){
		var devices = InputDeviceEnumerate(false);
		for(var i = 0;i < array_length(devices);i++){
			if(InputDeviceIsAvailable(devices[i])){
				player_data.device = devices[i];
			}
		}
	}
		
	static set_user_name = function(_name){
		user_name = _name;
		save_users();
	}
		
	static get_user_name = function(){
		return user_name;
	}
		
	static save_user_binding = function(){
		var device_check = InputPlayerGetDevice(player_data.index)
		var for_gamepad = false;
		gp_input_config = InputBindingsExport(true,player_data.player_number);
		kb_input_config = InputBindingsExport(false,player_data.player_number);
		if(InputDeviceIsGamepad(device_check)){
			for_gamepad = true;
			input_config = gp_input_config;
		}else{
			input_config = kb_input_config;
		}

		var file_name = "user_profiles.json";
		var _file = file_text_open_read(file_name);
		if(_file == -1){
			_file = file_text_open_write(file_name);
			file_text_close(_file);
		}
		_file = file_text_open_read(file_name);
		var file_string = file_text_read_string(_file);
		var user_json = json_parse(file_string);
		file_text_close(_file);
	
		for(var i = 0;i < array_length(user_json);i++){
			var current_active_user = user_json[i];
			if(not_null(current_active_user)){
				if(current_active_user.user_index == user_index){
					current_active_user.input_config = input_config;
				}
			}
		}
		var return_data = json_stringify(user_json);
		_file = file_text_open_write(file_name);
		file_text_write_string(_file,return_data);
		file_text_close(_file);
	}
		
	static load_user_binding = function(){
		var file_name = "user_profiles.json"
		var _file = file_text_open_read(file_name);

		if(_file == -1){
			return;
		}
		var file_string = file_text_read_string(_file);
		var user_json = json_parse(file_string);
	
		for(var i = 0;i < array_length(user_json);i++){
			var current_active_user = user_json[i];
			if(not_null(current_active_user)){
				if(current_active_user.user_index == user_index){
					kb_input_config = current_active_user.kb_input_config;
					gp_input_config = current_active_user.gp_input_config;
				}
			}
		}
		file_text_close(_file);
		
		var device_check = InputPlayerGetDevice(player_data.player_number)
		var for_gamepad = false;

		if(struct_exists(kb_input_config,"debug")){
			
		}else{
			InputBindingsReset(false,player_data.player_number);
			kb_input_config = InputBindingsExport(false,player_data.player_number);
		}
		if(struct_exists(gp_input_config,"debug")){
			
		}else{
			InputBindingsReset(true,player_data.player_number);
			gp_input_config = InputBindingsExport(true,player_data.player_number);
		}
		
		if(InputDeviceIsGamepad(device_check)){
			input_config = gp_input_config;
		}else{
			input_config = kb_input_config;
		}
	}
		
	static get_current_save_data = function(){
		for(var i = 0; i < array_length(saves_data);i++){
			var data = saves_data[i];
			if(global.current_game == data.game){
				return data;
			}
		}
	}
	
	set_player_data();
	set_user_data();
	load_user_binding();
}
	

	
function load_users(_number_to_load){
	var file_string = "user_profiles.json";
	var _file = file_text_open_read(file_string);

	if(_file == -1){
		insert_first_user();
	}
	_file = file_text_open_read(file_string);
	var _data = file_text_read_string(_file);
	var _json_data = json_parse(_data);
	
	for(var i = 0;i < _number_to_load;i++){
		if(i >= array_length(_json_data)){
			global._users[i] = new User(i * 10,string_concat("Guest ",string(i)),true, new Player(i * 10,i,InputPlayerGetDevice(i)));
		}else{
			var current_user = _json_data[i];
			if(not_null(current_user)){
				var current_active_user = 0;
				if(array_length(global._users) > 0){
					current_active_user = global._users[i];
				}
				
				if(is_null(current_active_user) || current_active_user.user_index == current_user.user_index){
					var new_user_obj = new User(current_user.user_index,current_user.user_name,false, new Player(current_user.player_data.index,i,InputPlayerGetDevice(i)));
					new_user_obj.saves_data = current_user.saves_data;
					new_user_obj.input_config = current_user.input_config;
					InputBindingsImport(InputDeviceIsGamepad(new_user_obj.player_data.device),new_user_obj.input_config,new_user_obj.player_data.player_number);
					global._users[i] = new_user_obj;
					new_user_obj.player_data.set_character();
				}
			}else{
				global._users[i] = new User(i * 10,string_concat("Guest ",string(i)),true, new Player(i * 10,i,InputPlayerGetDevice(i)));
			}
		}
	}
	file_text_close(_file);
}

function save_users(){
	var file_string = "user_profiles.json"
	var _file = file_text_open_write(file_string);
	
	var array_json = array_create(0);
	for(var i = 0;i < array_length(global._users);i++){
		var current_active_user = global._users[i];
		if(not_null(current_active_user)){
			if(!current_active_user.is_guest){
				array_push(array_json,current_active_user);
			}
		}
	}
	var return_data = json_stringify(array_json,false);
	file_text_write_string(_file,return_data);
	file_text_close(_file);
}

function insert_first_user(){
	InputPlayerSetDevice(INPUT_KBM,0);
	var user = new User(0,"Default",false,new Player(0,0,InputPlayerGetDevice(0)));
	////This line is incorrect but came from buggin repo, commenting out for now.
	////array_push(user.saves_data);
	user.set_user_data();
	var file_string = string_concat(working_directory,"user_profiles.json");
	var _file = file_text_open_write(file_string);
	var user_json = json_stringify(global._users,false);
	file_text_write_string(_file,user_json);
	file_text_close(_file);
	user.save_user_binding();
}