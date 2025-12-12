direction = InputDirection(direction,INPUT_CLUSTER.NAVIGATION);
face = direction / 45
motion_set(direction,InputDistance(INPUT_CLUSTER.NAVIGATION,0) * move_speed);
move_wrap(true,true,sprite_width);
if(speed == 0){image_index = 0;}else if(speed > 0 && speed < 1){image_index++}else{image_speed = speed;}


//Using the face we determine which sprite to use
	switch(face){
	    case 0:
			sprite_index = left_sprite;
			direction_facing = "right";
		break;
    
	    case 1:
			direction_facing = "right";
			sprite_index = up_angle_sprite;
		break;

	    case 2:
			direction_facing = "up";
			sprite_index = up_sprite;
		break;
		

    
	    case 3:
			direction_facing = "left";
			sprite_index = up_angle_sprite;
		break;

    
	    case 4:
			direction_facing = "left";
			sprite_index = left_sprite;
		break;
    
	    case 5:
			direction_facing = "left";
			sprite_index = down_angle_sprite;

		break;
    
	    case 6:
			direction_facing = "down";
			sprite_index = down_sprite;
		break;
    
	    case 7:
			direction_facing = "right";
			sprite_index = down_angle_sprite;
		break;
	}
