img_ind = 0;

//criando os comportamentos
axe = function () {
    instance_destroy();
    var _x = x + (image_xscale * 30)
    instance_create_depth(_x, y, depth, obj_subweapon, { 
        image_xscale : image_xscale,
        vspeed : -4,
        gravity : 0.1
    });
}

knife = function () {
    
}
