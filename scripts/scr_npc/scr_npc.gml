enum npc_size{
	small,
	medium,
	large,
	biiiiiiiiig
}


////Struct inheritance explanation found here:
////https://stackoverflow.com/questions/72987394/when-using-struct-inheritance-in-gml-how-do-you-make-a-call-to-the-parents-ver
///
////@description Main NPC struct. Facilitates taking damage, as well as creating instances. Data handling.
////@function NPC
function NPC(new_obj_reference,_new_name,_new_base_hp,new_current_hp = "",new_move_speed = "",new_size = npc_size.medium,new_grid = "",new_damage = 1) : Character(_new_name,_new_base_hp,new_current_hp = "",new_move_speed = "",new_damage = 1) constructor{

	size = new_size;
	
	////npc_path represents the variable which holds the path asset created in code when finding a path.
	////This should only contain a path object when the npc is instanced in a room.
	grid = new_grid;
	npc_path = ""; 
	npc_instance = "";
	obj_reference = new_obj_reference;
	
	static spawn_npc = function(x_pos,y_pos,layer_to_spawn){
		npc_instance = instance_create_layer(x_pos,y_pos,layer_to_spawn,obj_reference);
		npc_instance.path = path_add();
		npc_instance.character_struct = self;
	}
	
	static detect_target = function(_target){
		
	}
	
	static kill_npc = function(){
		instance_destroy(npc_instance,true);
	}

}
