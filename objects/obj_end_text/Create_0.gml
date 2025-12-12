type_delay = 120;
item_index = 0;
boxes = ["With the defeat of the queen, there was a chance to finally breathe.[delay,2000]","Still, the question remained in the wizards mind,[delay,2000]","where had this affliction come from? And to what end?[delay,2500]"];
typist = scribble_typist();
scribble_object = scribble(boxes[item_index]);
show_character = false;
alarm[0] = type_delay;
typist.in(0,1);
typist.function_on_complete(function(_element, _position, _typist){
	if(item_index < array_length(boxes) - 1){
		item_index++;
		typist.reset();
		scribble_object = scribble(boxes[item_index]);
		alarm[0] = type_delay;
	}else{
		var fade = instance_create_layer(0,0,"System",obj_blackout);
		fade.fade_in();
		alarm[1] = 600;

	}
	


});




