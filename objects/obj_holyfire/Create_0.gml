img_ind = 0;
qtd = 8;
son = noone;
ground = noone;

var _layer = layer_tilemap_get_id("Level");
var _stair = layer_tilemap_get_id("Stairs");

collider = [obj_collider, _layer, _stair];