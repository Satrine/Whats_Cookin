move_x = 0;
move_y = 0;
path = path_index
index = "";
sm = new State_Machine();

idle_state = new State("idle")
	.set_update(function(){
		sm.change_state("move");

	});
move_state = new State("move")
	.set_update(function(){
		if(path_index == -1){
			if(path_position >= .99 || path_position == 0){
				var target = instance_find(obj_player,0);
				var target_x = target.x;
				var target_y = target.y;
				if(point_distance(target_x,target_y,x,y) > 30){
					if(character_struct.grid.set_path(path,x,y,target_x,target_y)){
						path_start(path,character_struct.move_speed,path_action_stop,true);
						//var path_pos = path.path_position;
					}
				}
			}

		}else{
			
			///Check Target_distance
			var target_x = path_get_point_x(path_index,path_get_number(path_index) - 1);
			var target_y = path_get_point_y(path_index,path_get_number(path_index) - 1);
			var target = point_distance(target_x,target_y,obj_player.x,obj_player.y)
			///If too far away then recalculate the path.
			if(target > 150){
				show_debug_message("target too far from end of path. Recalculating...")
				if(character_struct.grid.set_path(path,x,y,obj_player.x,obj_player.y)){
					path_start(path,character_struct.move_speed,path_action_stop,true);
					//var path_pos = path.path_position;
				}
			}
			
		}
		
		
	});

sm.add_state(idle_state).add_state(move_state);