/// @description 
pCount = global.playerCount
dealSprite = global.cardBack;
sWidth = sprite_get_width(dealSprite);

deckPositions = []
cardDepth = depth - 53;
//default deck positions

var hh = (room_width / (pCount + 1)) // horizontal spacing between player decks
var vv = room_height

for (var i = 0; i < pCount; i++)
{
	deckPositions[i] = [(((i + 1) * hh) - sWidth * 0.5), (vv - 250)]
}

// Timer for pausing (not pause menu)
waitTimerMax = 1.1 * room_speed;
waitTimer = waitTimerMax;
pausing = false;


// Timer for dealing animation
dealTimerMax = 0.15 * room_speed;
dealTimer = dealTimerMax;
playerScooping = noone;
reasonForScoop = "";
flip = false; // bool used to only set playerScooping to targetDeck once in draw event ( not every frame);



// Timer for dealing with displaying the reason for a scoop/slap

displayReasonTimerMax = room_speed * 2;
displayReasonTimer = 0;


cardsToDeal = global.deckSize;

// Game states and associated variables
targetDeck = 0;
secondTargetDeck = noone;
state = "dealing";
image = noone;


// dealing		// beginning of round when deck is divided amongs players
// scooping		// after a slap when a player collects the pile 
// burning 		// after an illegal slap when a player must pay cards to the pile
// playing card // triggered when player has just played a card (animation).
// wait			// default state
