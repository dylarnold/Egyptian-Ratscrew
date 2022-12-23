/// @description Insert description here




draw_set_color(c_navy);
draw_set_font(fnt_Comic);
draw_set_halign(fa_center);
draw_text_ext_color(room_width / 2, room_height / 2, displayString, 50 ,1000, c_navy, c_navy, c_navy, c_navy, 1);
draw_set_color(c_white);
draw_set_halign(fa_left);
if stop
{
	draw_self();
}
