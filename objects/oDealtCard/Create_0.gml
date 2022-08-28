/// @description Instances of this object are initialized by oDealer for animation purposes.
sprite_index = global.cardBack;

// used to lerp position
startX = x
startY = y


// instance will be fed new values upon creation
finalX = 0
finalY = 0

easingFunc = easeOutElastic;

function dealSpeed(seconds)
{
	// Finds percentage to increment a value per frame to complete in "seconds" seconds. 
	return (1 / room_speed) / seconds;
}
percent = 0;
c = 0

audio_play_sound(sndCardThwick, 1, false);

