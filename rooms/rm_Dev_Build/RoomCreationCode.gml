var npc = new NPC(obj_npc,"Test_Guy",1,,5,npc_size.medium);

npc.spawn_npc(get_screen_center_x(),get_screen_center_y(),"Instances");

var char = instance_create_layer(get_screen_center_x(),get_screen_center_y(),"Instances",obj_player);
