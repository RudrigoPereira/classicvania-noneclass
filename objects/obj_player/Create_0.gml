#region CRIANDO OS ESTADOS DO PLAYER

idle_state   = new state();
crouch_state = new state();
walk_state   = new state();
jump_state   = new state();
stair_state  = new state();

#endregion

#region VARIÁVEIS

img_ind = 0;
xscale = image_xscale;

collider_layer = layer_tilemap_get_id("Level");
stair_layer    = layer_tilemap_get_id("Stairs");

colliders = [obj_collider, collider_layer];

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

my_whip = noone;
whip_x  = 0;
whip_y  = 0;

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

vertical_movement = function () {
    if (!ground) {
    	if (vspd < max_vspd) { vspd += grav; } 
        else { vspd = max_vspd; }
    } else {
    	vspd = 0;
    }
}

adjusts_xscale = function () {
    if (hspd != 0) { xscale = sign(hspd); }
}

update_pos_whip = function () {
    if (instance_exists(my_whip)) {
        whip_x    = x - 9 * xscale;
        whip_y    = y - sprite_yoffset + sprite_get_bbox_top(sprite_index) + 9;
        my_whip.x = whip_x;
        my_whip.y = whip_y;
    }
}

create_attack = function () {
    if (!attacking) {
        if (attack) {
            attacking   = true;
            image_index = 0;
            
            //criando o chicote
            whip_x = x - 9 * xscale;
            whip_y = y - sprite_yoffset + sprite_get_bbox_top(sprite_index) + 9;
            my_whip = instance_create_depth(whip_x, whip_y, depth + 1, obj_whip, { image_xscale : xscale });
        }
    } else {
        switch (current_state) {
        	case idle_state:   sprite_index = spr_player_attack; break;
        	case crouch_state: sprite_index = spr_player_crouch_attack ; break;
        	case walk_state:   sprite_index = spr_player_attack; break;
        	case jump_state:   sprite_index = (vspd < 0) ? spr_player_stairs_attack_up : spr_player_stairs_attack_down; break;
        }
        
        if (finished_animation()) {
        	attacking = false;
            
            switch (current_state) {
            	case idle_state:   sprite_index = spr_player_idle; break;
            	case crouch_state: sprite_index = spr_player_crouch; break;
            	case jump_state:   sprite_index = spr_player_jump; break;
            }
        }
    }
}

#endregion

#region ESTADOS

#region IDLE

//criando o create do estado idle
idle_state.start = function () {
    //definindo sprite
    if (!attacking) { sprite_index = spr_player_idle; } 
}

idle_state.run = function () {
    //atacando
    create_attack();
    
    //abaixando
    if (down) { state_change(crouch_state); }
    
    //andando
    if (right xor left && !attacking) { state_change(walk_state); }
    
    //pulando
    if (jump) {
        state_change(jump_state);
    	vspd = - max_vspd;
    }
    
    //caindo
    if (!ground) { state_change(jump_state); }
}

idle_state.finish = function () {}

#endregion

#region CROUCH

crouch_state.start = function () {
    //definindo sprite
    if (!attacking) { sprite_index = spr_player_crouch; } 
}

crouch_state.run = function () {
    //atacando
    create_attack();
    
    //levantando
    if(!down) { state_change(idle_state) }
}

crouch_state.finish = function () {}

#endregion

#region WALK

walk_state.start = function () {
    //definindo sprite e começando da primeira imagem
    sprite_index = spr_player_walk;
    image_index  = 0;
}

walk_state.run = function () {
    //olhando para o lado certo
    horizontal_movement();
    
    //atacando
    create_attack();
    
    //parando ao atacar
    if (attacking) { hspd = 0; }
    
    //parando
    if (hspd == 0) { state_change(idle_state); }
    
    //pulando
    if (jump) {
        state_change(jump_state);
    	vspd = - max_vspd;
    }
    
    //caindo
    if (!ground) { 
        state_change(jump_state);
        hspd = 0; 
    }
}

walk_state.finish = function () {}

#endregion

#region JUMP

jump_state.start = function () {
    //definindo a sprite
    sprite_index = spr_player_jump;
}

jump_state.run = function () {
    //definindo imagem no ar
    if (!attacking) { image_index = vspd < 0 ? 0 : 1; } 
    
    //pulando e caindo
    vertical_movement();
    
    //atacando
    create_attack();
    
    //parando
    if (ground) { state_change(idle_state); }
}

jump_state.finish = function () {
    //zerando velocidade horizontal
    hspd = 0; 
}

#endregion

#endregion

//definindo o estado inicial do player
start_state(idle_state);
