/// @description Object draws card animations.
image_alpha = 0;
aa = 0;
timer = room_speed*1.5;


// Function for spawning a button

// Spawn button objects for menu
xx = room_width / 2
yy = room_height / 2
menuButtons = []
for (var i = 0; i < 5; i++)
{
	var _button = instance_create_layer(xx * 0.5 + (80 * i), yy * 1.5, "Instances", oButton);
	_button.sprite_index = sNumerals;
	_button.image_index = i;
	_button.image_alpha = 0;
	_button.text = "";
	_button.value = i + 1;
	
	with _button{
		myScript = function(){
		global.playerCount = value;
		room_goto_next();
		// SFX
		// ANIMATION TRIGGERS
		// TRANSITION EFFECTS
		}
	}
	menuButtons[i] = _button
}

