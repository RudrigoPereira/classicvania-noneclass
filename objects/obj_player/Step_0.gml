if(keyboard_check_pressed(vk_space)) { state_change(walk_state); }

ground_check();
inputs();
run_state();
adjusts_xscale();

//movimentação horizontal
move_and_collide(hspd, 0, colliders, 4);
//movimentação vertical
move_and_collide(0, vspd, colliders, 12);
