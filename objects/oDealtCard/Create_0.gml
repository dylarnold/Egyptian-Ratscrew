/// @description 
sprite_index = global.cardBack;

// used to lerp position
startX = x
startY = y


// instance will be fed new values upon creation
finalX = 0
finalY = 0

// https://easings.net/#easeOutElastic (converted from TypeScript)
// bounds for x: 0 through 1
function easeOutElastic(x) 
{
	var c4 = (2 * pi) / 3;

	if x == 0 return 0
	if x == 1 return 1

	return power(2, (-10 * x)) * sin((x * 10 - 0.75) * c4) + 1;
}

easingFunc = easeOutElastic;



function dealSpeed(seconds)
{
	// Finds percentage to increment a value per frame to complete in "seconds" seconds. 
	return (1 / room_speed) / seconds;
}
percent = 0;
c = 0

audio_play_sound(sndCardThwick, 1, false);

