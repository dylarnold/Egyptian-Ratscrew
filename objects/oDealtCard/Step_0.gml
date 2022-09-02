/// @description 

percent += c
elastic = easingFunc(percent)

x = lerp(startX, finalX, elastic);
y = lerp(startY, finalY, elastic);

if percent >= 1
{	
	if !drawUnder
	{
		oDeck.topCard = image_index;
	}
	instance_destroy()
}
