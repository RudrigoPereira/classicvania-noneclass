img_ind = 0;

switch (global.subweapon) {
	case SUBWEAPON.AXE: sprite_index = spr_axe_init; break;
	case SUBWEAPON.KNIFE: sprite_index = spr_knife_init; break;
	case SUBWEAPON.BOOMERANG: sprite_index = spr_boomerang_init; break;
	case SUBWEAPON.HOLYWATER: sprite_index = spr_holywater_init; break;
}

//criando os comportamentos
axe = function () {
    instance_destroy();
    var _x = x + (image_xscale * 30)
    instance_create_depth(_x, y, depth, obj_subweapon, { 
        sprite_index : spr_axe,
        image_xscale : image_xscale,
        vspeed : -4,
        gravity : 0.1
    });
}

knife = function () {
    instance_destroy();
    var _x = x + (image_xscale * 30)
    instance_create_depth(_x, y, depth, obj_subweapon, { 
        sprite_index : spr_knife,
        image_xscale : image_xscale,
    });
}

boomerang = function () {
    instance_destroy();
    var _x = x + (image_xscale * 30)
    instance_create_depth(_x, y, depth, obj_subweapon, { 
        sprite_index : spr_boomerang,
        image_xscale : image_xscale,
    });
}

holywater = function () {
    instance_destroy();
    var _x = x + (image_xscale * 30)
    instance_create_depth(_x, y, depth, obj_subweapon, { 
        sprite_index : spr_holywater,
        image_xscale : image_xscale,
        vspeed : 1 
    });
}
