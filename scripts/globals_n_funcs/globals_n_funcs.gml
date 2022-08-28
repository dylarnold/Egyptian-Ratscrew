randomize();
global.playerCount = 2;
global.deckSize = 52;
global.cardBack = sCardBack;
global.burnAmmount = 1;

// https://easings.net/ (transcribed from TypeScript)
// bounds for x: 0 through 1
function easeOutElastic(x) 
{
	var c4 = (2 * pi) / 3;

	if x == 0 return 0
	if x == 1 return 1

	return power(2, (-10 * x)) * sin((x * 10 - 0.75) * c4) + 1;
}

function easeOutQuint(x){
	return 1 - power(1 - x, 5);
}


function detectSlappable(queue)
{
	// function returns true if a given queue is slappable according to the rules
	var array = [];
	var qSize = ds_queue_size(queue);
	var qCopy = ds_queue_create();
	ds_queue_copy(qCopy, queue);
	
	// 0 thru 12 is A,2,3,4,5,6,7,8,9,10,J,Q,K
	for (var i = 0; i < qSize; i++)
	{
		var cardVal = ds_queue_dequeue(qCopy) mod 13;
		array[i] = cardVal;
	}
	
	if qSize >= 2 
	{	
		// double (two cards of the same cardVal, consecutive, on top
		if array[qSize - 1] == array[qSize - 2] return true;
		
		// tens (top two cards sum to 10)
		if (array[qSize - 1] + 1) + (array[qSize - 2] + 1) == 10 return true;
		
		// marriage (K, Q or Q, K on top)
		if array[qSize - 1] + array[qSize - 2] == 11 + 12 return true;
		
		if qSize >= 3
		{
			// sandwich tens (two cards separated by another sum to ten)
			if (array[qSize - 1] + 1) + (array[qSize - 3] + 1) == 10 return true;
		
			// sandwich (double separated by a card)
			if array[qSize - 1] == array[qSize - 3] return true;
		
			// top bottom (big sandwich) (same card on bottom as on top)
			if array[qSize - 1] == array[0] return true;
	
			// four in a row (ex. K, A, 2, 3 or 10, J, Q, K)
			if qSize >= 4
			{
				// ascending from top of pile
				if  array[qSize - 4] == array[qSize - 3] + 1 
				and array[qSize - 3] == array[qSize - 2] + 1 
				and array[qSize - 2] == array[qSize - 1] + 1
				{
					return true;
				}
				// descending from top of pile
				if  array[qSize - 4] == array[qSize - 3] - 1
				and array[qSize - 3] == array[qSize - 2] - 1
				and array[qSize - 2] == array[qSize = 1] - 1 
				{
					return true;
				}
			}
		}
	}
	return false
}

/*
TO DO:
	

	learn text/fonts for Gamemaker
	get artwork for cards and have oDeck draw them
	J, Q, K, A rules
		make a state where next player owes x cards. it remains their turn until x cards have been played (overruled by slap)
		
	visual feedback
	audio feedback
	options menu
	win state
	dedicated slap-in button (have it set up new controls and communicate them to new player)
	gamepad support?
	mouse support?
	music?
	
	
Design:
	player turns (do i enforce player turns, or simply penalize an out-of-turn play with burning a card?)
	
	Dedicated slap-in button for non-players: it will add a new player to the game and assign them buttons
	
	Each player has their own "play card" button, and their own "slap" button
*/
