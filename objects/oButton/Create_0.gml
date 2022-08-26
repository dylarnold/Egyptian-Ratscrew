

function get_hover()
{
	var _mouseX = mouse_x;
	var _mouseY = mouse_y;
	
	return point_in_rectangle(_mouseX, _mouseY, x, y, x + sprite_width, y + sprite_height);
	
}



// Animation ease
percent = 0;
// Variables
hover = 0;

