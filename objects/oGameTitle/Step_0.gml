/// @description 
image_alpha += .005;

if timer <= 0
{
	aa += .005
	
	// Fade in created menu buttons
	for (var i = 0; i < array_length(menuButtons); i++)
	{
		menuButtons[i].image_alpha += aa * .05;
	}
	
}
else
{
	timer -= 1
}



