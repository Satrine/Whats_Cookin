////@description Main Character struct. Facilitates taking damage, as well as creating instances. Data handling.
////@function Character
////@param {string} Name Character Name
////@param {real} base_hp base npc health
////@param {real} current_hp current hp if relevant. Otherwise gets set to base_hp.
function Character(_new_name,_new_base_hp,new_current_hp = "",new_move_speed = "",new_damage = 1) constructor{
	character_name = _new_name;
	character_base_hp = _new_base_hp;
	if(is_null(new_current_hp)){
		character_base_hp = _new_base_hp;
	}else{
		character_current_hp = new_current_hp;
	}
	if(is_null(new_move_speed)){
		move_speed = 1;
	}else{
		move_speed = new_move_speed;
	}
	////INSTANCE CONTEXT VARS
	damage = new_damage;
	iframes = false;
	stun_amount = 0;
	knockback_amount = 0;
	
	
	static take_damage = function(damage,attack_type = "",new_stun_amount = 0,source = ""){
		if(!iframes){
			character_current_hp -= damage;

			if(check_death()){
				kill_npc();
				return;}
			if(new_stun_amount > 0){
				if(stun_amount <= 0){
					stun_amount += new_stun_amount;
				}
			}
		}
		
	}
	static check_death = function(){
		return character_current_hp <= 0;
	}

}