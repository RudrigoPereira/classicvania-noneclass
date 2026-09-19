if (finished_animation()) { instance_destroy(); }

ground = place_meeting(x, y+1, collider);
 
if (image_index > 1.6 && son == noone && qtd > 0 && ground) {
    var _x = x + image_xscale * 4;
	son = instance_create_depth(_x, y, depth, obj_holyfire);
    son.qtd = qtd-1;
    son.image_xscale = image_xscale;
}

if (!ground) {
	vspeed += 0.1;
} else {
	vspeed = 0; 
}
