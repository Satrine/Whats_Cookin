if(show_character){
	scribble_object.wrap(300,100,false)
	scribble_object.starting_format("main",c_white)
	scribble_object.draw(x,y,typist);
	draw_sprite_ext(spr_mothie_idle_down,0,get_screen_center_x(),get_screen_center_y(),1,1,0,c_white,1);
}