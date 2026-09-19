if (finished_animation()) {
    instance_destroy();
    var _spr = spr_axe;
    
	switch (global.subweapon) {
    	case SUBWEAPON.AXE: _spr = spr_axe; break;
        case SUBWEAPON.KNIFE: _spr = spr_knife; break;
        case SUBWEAPON.BOOMERANG: _spr = spr_boomerang; break;
        case SUBWEAPON.HOLYWATER: _spr = spr_holywater; break;
    }
    
    var _x = x + (image_xscale * 30);
    
    var _weapon = instance_create_depth(_x, y, depth, obj_subweapon, {
        sprite_index : _spr,
        image_xscale : image_xscale,
    });
    
    if (global.subweapon == SUBWEAPON.AXE) {
    	_weapon.vspeed = -4;
        _weapon.gravity = 0.1;
    }
}
