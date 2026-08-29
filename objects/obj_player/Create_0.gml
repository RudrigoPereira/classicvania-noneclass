#region CRIANDO OS ESTADOS DO PLAYER

idle_state   = new state();
crouch_state = new state();
walk_state   = new state();

#endregion

#region VARIÁVEIS

img_ind = 0;
xscale = image_xscale;
colliders = [obj_collider];

//inputs
up        = noone;
down      = noone;
left      = noone;
right     = noone;
jump      = noone;
attack    = noone;
subweapon = noone;

//variável para saber se o player está atacando
attacking = false;

//movimentação
hspd     = 0;
max_hspd = 1;
vspd     = 0;
max_vspd = 5;
grav     = 0.2;

ground = false;

#endregion

#region MÉTODOS

inputs = function () {
    up        = keyboard_check(vk_up);
    down      = keyboard_check(vk_down);
    left      = keyboard_check(vk_left);
    right     = keyboard_check(vk_right);
    jump      = keyboard_check_pressed(ord("Z"));
    attack    = keyboard_check_pressed(ord("X"));
    subweapon = keyboard_check_pressed(ord("C"));
}

ground_check = function () {
    ground = place_meeting(x, y + 1, colliders);
}

horizontal_movement = function () {
    hspd = (right - left) * max_hspd;
}

adjusts_xscale = function () {
    if (hspd != 0) { xscale = sign(hspd); }
}

create_attack = function () {
    if (!attacking) {
        if (attack) {
            attacking   = true;
            image_index = 0;
        }
    } else {
    	switch (current_state) {
        	case idle_state:   sprite_index = spr_player_attack; break;
        	case crouch_state: sprite_index = spr_player_crouch_attack ; break;
        	case walk_state:   sprite_index = spr_player_attack; break;
        }
        
        if (finished_animation()) {
        	attacking = false;
            
            switch (current_state) {
            	case idle_state:   sprite_index = spr_player_idle; break;
            	case crouch_state: sprite_index = spr_player_crouch; break;
            }
        }
    }
}

#endregion

#region ESTADOS

#region IDLE

//criando o create do estado idle
idle_state.start = function () {
    if (!attacking) { sprite_index = spr_player_idle; } 
}

idle_state.run = function () {
    create_attack();
    
    if (down) { state_change(crouch_state); }
    
    if (right xor left && !attacking) { state_change(walk_state); }
}

idle_state.finish = function () {
    
}

#endregion

#region CROUCH

crouch_state.start = function () {
    if (!attacking) { sprite_index = spr_player_crouch; } 
}

crouch_state.run = function () {
    create_attack();
    
    if(!down) { state_change(idle_state) }
}

crouch_state.finish = function () {
    
}

#endregion

#region WALK

walk_state.start = function () {
    sprite_index = spr_player_walk;
    image_index  = 0;
}

walk_state.run = function () {
    horizontal_movement();
    
    if (hspd == 0) { state_change(idle_state); }
}

walk_state.finish = function () {}

#endregion

#endregion

//definindo o estado inicial do player
start_state(idle_state);
