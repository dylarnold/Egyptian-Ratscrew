/// @description 
var _hover = get_hover();
var _click = _hover and mouse_check_button_pressed(mb_left);

if percent < 100
{
	percent += (_hover / room_speed);
}

if !_hover percent = 0;

if percent < 100
{
	hover = easeOutQuint(percent);
}

// Button Clicked
if _click
{
	myScript();
}


