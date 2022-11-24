/// @description 
image_xscale += image_yscale * choose(.2, 0);
image_yscale += image_yscale * choose(.2, 0);
image_angle = irandom_range(-5, 5);
image_alpha -= .08;
if image_alpha <= 0
{
	instance_destroy();
}