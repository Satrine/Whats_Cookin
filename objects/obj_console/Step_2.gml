list_size = ds_list_size(console_list);

for(var i = 0;i < list_size;i++){
	var event = ds_list_find_value(console_list,i);
	var is_event = is_instanceof(event,"_event_type");
	if(not_null(event)){
		scribble_object.starting_format("main",event.get_message_color());
		scribble_object = scribble(event.get_message() + "[/page]");
		
	}
}