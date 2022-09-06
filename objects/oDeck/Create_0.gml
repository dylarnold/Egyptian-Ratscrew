/// @description Object handles bookkeeping.
// State based player input handling. Keeps track of cards' locations.
/* decks and the pile are both queues.
FIFO
first in line is top of the player's deck (first to be played)
first in line is bottom of discard pile (first to be added to the bottom of a deck) */
pCount = global.playerCount;
deckSize = global.deckSize;
topCard = noone;
pileSize = 0;
showing = false;

// Discard pile (starts empty)
pile = ds_queue_create();


// Initial deck array (1 thru 52 ordered)
startDeck = array_create(deckSize);
for (var i = 0; i < deckSize; i++)
{
	startDeck[i] = i;
}


// Shuffle startDeck (Fisher–Yates shuffle Algorithm)
for (var i = deckSize - 1; i >= 0; i--)
{
	var j = irandom_range(0, i);
	// Swap
	var temp = startDeck[i];
	startDeck[i] = startDeck[j];
	startDeck[j] = temp;
}


// Initialize an empty queue(deck) for each player.
// deck[0] holds player 1's deck etc. An array of queues.
deck = array_create(pCount);
for (var i = 0; i < pCount; i++)
{
	deck[i] = ds_queue_create();
}


// Deal already randomized cards to each deck. (deals whole deck, regardless of pCount)
// sometimes will be an uneven distribution.
for (var i = 0; i < deckSize; i++)
{
	var j = i mod pCount;
	ds_queue_enqueue(deck[j], array_pop(startDeck));
}