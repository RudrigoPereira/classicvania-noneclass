max_distance = 150;
vmax_distance = 60;
subi = false;
voltei = false;
terminei = false;

alarm[0] = game_get_speed(gamespeed_fps) * 6;

axe = function () {
    hspeed = image_xscale;
}

knife = function () {
    hspeed = 3  * image_xscale;
}

boomerang = function () {
    var _distance = abs(x - xstart);
    var _vdistance = abs(y - ystart);
    
    if (!subi && !voltei) { hspeed = 2 * image_xscale; }
    
    if (_distance > max_distance) { subi = true; }
    
    if (subi && !voltei ) {
    	vspeed = -2;
        hspeed = image_xscale;
    }
    
    if (_vdistance > vmax_distance) { voltei = true; }
    
    if (voltei && !terminei) {
    	var _dir = point_direction(x, y, xstart, ystart);
        
        var _ang_dif = angle_difference(_dir, direction);
        
        var _ang = clamp(_ang_dif, -5, 5);
        
        if (abs(_ang) < 3) { terminei = true; }
        
        speed = 2;
        direction += _ang;
    }
}

holywater = function () {
    hspeed = 2 * image_xscale;
    vspeed = 2;
    
    var _col = [obj_collider, layer_tilemap_get_id("Level")];
    
    var _ground = place_meeting(x, y+1, _col);
    
    if (_ground) {
    	instance_destroy();
        instance_create_depth(x, y, depth, obj_holyfire, { image_xscale : image_xscale });
    }
}
