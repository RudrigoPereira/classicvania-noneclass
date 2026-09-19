max_hp = 1;
current_hp = 1;

free_list = [];

takes_damage = function (_damage = 1) {
    current_hp -= _damage;
    current_hp = clamp(current_hp, 0, max_hp);
    
    if (current_hp <= 0) {
    	instance_destroy(); 
    }
}
