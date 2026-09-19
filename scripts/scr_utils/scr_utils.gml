enum SUBWEAPON {
    AXE,
    BOOMERANG,
    HOLYWATER,
    KNIFE
}

global.subweapon = SUBWEAPON.AXE;

function deals_damage(_damage = 1, _player = true) {
    var _other = instance_place(x, y, obj_entity);
    
    if (_other) {
        if (_player) {
        	if (_other.object_index == obj_player  ) { return; }
        } else {
        	if (_other.object_index != obj_player  ) { return; }
        }
        
        _other.takes_damage();
    }
}

function finished_animation(){
    if (img_ind > image_index) {
    	//terminou a animação
        img_ind = 0;
        return true;
    } else {
    	img_ind = image_index;
        return false;
    }
}
