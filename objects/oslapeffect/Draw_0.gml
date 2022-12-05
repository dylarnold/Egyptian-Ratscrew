/// @description Insert description here

draw_self();

// draw concentric circles for slap effect
circleRadius += circleRadiusIncrease
draw_set_color(c_blue);
for (var i = 0; i < 10; i += 4)
{
	draw_circle(x, y, circleRadius + i, true);
}
draw_set_color(c_white);