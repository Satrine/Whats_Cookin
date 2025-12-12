move_x = 0;
move_y = 0;

sm = new State_Machine();

idle_state = new State("idle")
	.set_update(function(){
		sm.change_state("move");

	});
move_state = new State("move")
	.set_update(function(){
		// Random direction
		var random_angle = irandom(359);
		move_x = lengthdir_x(character_struct.move_speed, random_angle);
		move_y = lengthdir_y(character_struct.move_speed, random_angle);
		
		x+= move_x;
		y+= move_y;
	
	});

sm.add_state(idle_state).add_state(move_state);