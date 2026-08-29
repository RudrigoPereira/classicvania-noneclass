function finished_animation(){
    if (img_ind > image_index) {
    	//terminou a animação
        img_ind = 0;
        return true;
    } else {
    	img_ind = image_index;
        return false;
    }
}
