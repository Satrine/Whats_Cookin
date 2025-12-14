event_list = ds_list_create();
list_size = ds_list_size(event_list);
scribble_object = scribble("");
scribble_object.wrap(sprite_width,sprite_height,false);
///scribble_object.align(fa_right,fa_bottom)
scribble_object.starting_format("main",c_white);
print_string = "";
text_scale = .5;
box_alpha = .7;
height_padding = .3;