if(keyboard_check_pressed(vk_space)) { state_change(walk_state); }

if (keyboard_check_pressed(vk_escape)) { game_restart() }

ground_check();
inputs();
run_state();
adjusts_xscale();

//movimentação horizontal
move_and_collide(hspd, 0, colliders, 4);
//movimentação vertical
move_and_collide(0, vspd, colliders, 12);

update_pos_whip();


var _stair = collision_rectangle(x - (xscale * 4), y - 4, x + (xscale * 10), y + 4, stair_layer, false, true);
if (_stair) {
	show_debug_message("estou nas escadas");
} else {
	show_debug_message("não estou nas escadas");
}
