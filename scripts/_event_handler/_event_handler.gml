enum ev_type{
	debug,
	combat,
	craft,
	gather,
	dropbox
}
enum ev_priority{
	low,
	standard,
	high,
	critical
}
////@function Event Handler
////@description Event Handler, add event structs to the queue for them to be processed and printed out in a debug console.
function Event_Handler() constructor{
	event_queue = ds_queue_create();
	current_event = "";
	console = new Console();
	
	////@function create_event
	////@description creates a new event which is put onto the queue to be added to the console for printing.
	static create_event = function(type,description,priority){
		current_event = new Event(type,description,priority);
		ds_queue_enqueue(event_queue,current_event);
		console.submit_event(current_event);
	}
}

////@function Event takes message vars and creates 
////@description Event Event structs are created and added to the handler queue to be printed.
function Event(new_event_type,new_description,new_priority) constructor{
	_event_type = new_event_type;
	time_stamp = current_time;
	description = new_description;
	priority = new_priority;
	
	////@function build_message
	////@description takes event vars and creates a message to print.
	static build_message = function(){
		var _message = "";
		var type_prefix = "";
		switch(_event_type){
			case ev_type.debug: 
				type_prefix = "debug";	
			break;
			case ev_type.combat: 
				type_prefix = "combat";
			break;
			case ev_type.craft: 
				type_prefix = "craft";
			break;
			case ev_type.gather:
				type_prefix = "gather";
			break;
			case ev_type.dropbox: 
				type_prefix = "dropbox";
			break;
			default:
				type_prefix = "Unknown";
		}
		_message = string_concat(time_stamp," ","[",_event_type,"]"," ",description);
		
		return _message;
	
	}
	
	////@function get_message_color
	////@description returns a color based on event priority
	static get_message_color = function(){
		var return_color;
		switch(priority){
			case ev_priority.low:
				return_color = c_white;
			break;
			case ev_priority.standard:
				return_color = c_green;		
			break;
			case ev_priority.high:
				return_color = c_orange;	
			break;
			case ev_priority.critical:
				return_color = c_red;	
			break;
		}
		if(is_null(return_color)){ return_color = c_white;}
		return return_color;
	}
}

////@function Console
////@description Console chronicles events as they are bubbled up and displays them when requested.
function Console() constructor{
	event_list = ds_list_create();
	
	console_instance = instance_create_layer(get_screen_center_x(),get_screen_center_y(),"System",obj_console);
	
	////@function submit_event
	////@description Adds event to list to be copied to instance console.
	static submit_event = function(new_event){
		ds_list_add(event_list,new_event);
	}
	
	////@function print_console
	////@description copies current event list onto the console instance event_list to be printed.
	static print_console = function(){
		ds_list_copy(event_list,console_instance.event_list);
	}
	
}