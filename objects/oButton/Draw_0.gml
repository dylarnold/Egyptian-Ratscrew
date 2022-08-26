/// @description 
var w = c_black;

draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, image_alpha);
draw_sprite_ext(sprite_index, image_index, x, y+20*hover, 1 + hover * 0.6, 1 + hover * 0.6, 0, c_white, image_alpha);

//draw_text_ext_transformed_color(x+5, y+5, text, 15, sprite_width, 1, 1, 0, w, w, w, w, 1);
