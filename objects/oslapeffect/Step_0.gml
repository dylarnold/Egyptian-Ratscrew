/// @description 
image_xscale += .3;
image_yscale += .3;
image_angle = irandom_range(0, 359);
image_alpha -= .1;
if image_alpha == 0
{
	instance_destroy();
}