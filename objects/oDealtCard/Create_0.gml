/// @description Instances of this object are initialized by oDealer for animation purposes.
scale = 1;
drawUnder = false;
// used to lerp position
startX = x;
startY = y;

// instance is fed finalX and finalY values upon initialization by oDealer.

easingFunc = easeOutQuint;

function dealSpeed(seconds)
{
	// Finds percentage to increment a value per frame to complete in "seconds" seconds. 
	return (1 / room_speed) / seconds;
}
percent = 0;
c = 0

audio_play_sound(sndCardThwick, 1, false);

