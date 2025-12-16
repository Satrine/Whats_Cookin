collision_radius = 40;
firing_speed = 120;
bullet_speed = 3;
bullet_damage = 1;
target_objects = [obj_npc];
target = "";
firing_timer = 0;

sm = new State_Machine();

idle_state = new State("idle")
	.set_update(function(){
		firing_timer++;
		if(firing_timer >= firing_speed){
			sm.change_state("detect_target");	
		}	
	});
detect_state = new State("detect_target")
	.set_update(function(){
		
		target = "";
		var collisions = ds_list_create();
		///Check for targets
		collision_circle_list(x,y,collision_radius,target_objects,false,true,collisions,true);
		if(not_null(collisions)){
			if(ds_list_size(collisions) > 0){
				target = ds_list_find_value(collisions,0);
			}
		}
		if(not_null(target) && instance_exists(target)){
			sm.change_state("fire");
		}
	});
fire_state = new State("fire")
	.set_update(function(){
		var dir = point_direction(x,y,target.x,target.y);
		instance_create_layer(x,y,"Bullets",obj_turret_bullet,{speed : bullet_speed,
																direction : dir,
																damage : bullet_damage});
		firing_timer = 0;
		sm.change_state("idle");
	});
	

sm.add_state(idle_state).add_state(detect_state).add_state(fire_state);