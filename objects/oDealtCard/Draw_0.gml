/// @description Insert description here

if drawUnder
{
	depth = oDeck.depth + 1;
}


scale = lerp(scale, targetScale, .2);

draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, 0, c_white, 1);




