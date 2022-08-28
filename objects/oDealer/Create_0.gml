/// @description 
pCount = global.playerCount
dealSprite = global.cardBack;
sWidth = sprite_get_width(dealSprite);

deckPositions = []

//default deck positions

var hh = (room_width / (pCount + 1)) // horizontal spacing between player decks
var vv = room_height

for (var i = 0; i < pCount; i++)
{
	deckPositions[i] = [(((i + 1) * hh) - sWidth * 0.5), (vv - 100)]
}


// Timer for dealing animation
dealTimerMax = 0.25 * room_speed;
dealTimer = dealTimerMax;
cardsToDeal = 52;

// Game states and associated variables
targetDeck = 0;
state = "dealing";
// dealing	// beginning of round when deck is divided amongs players
// scooping // after a slap when a player collects the pile 
// burning 	// after an illegal slap when a player must pay cards to the pile
// playing card 	// triggered when player has just played a card (animation).
// noone			// default state
