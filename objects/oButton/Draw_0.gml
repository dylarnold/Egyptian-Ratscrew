/// @description 

var _y = y + 20 * hover;
var _xscale = 1 + hover * 0.6;
var _yscale = 1 + hover * 0.6;
draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, image_alpha);
draw_sprite_ext(sprite_index, image_index, x, _y, _xscale, _yscale, 0, c_white, image_alpha);

//draw_text_ext_transformed_color(x+5, y+5, text, 15, sprite_width, 1, 1, 0, w, w, w, w, 1);
