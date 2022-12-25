randomize();
global.playerCount = 2;
global.deckSize = 52;
global.cardBack = sCardBack;
global.burnAmmount = 1;

#macro MAX_STARTING_PLAYER_COUNT  5 // highest 

// https://easings.net/ (transcribed from TypeScript)
// bounds for x: 0 through 1
function easeOutElastic(x) 
{
	var c4 = (2 * pi) / 3;

	if x == 0 return 0;
	if x == 1 return 1;

	return power(2, (-10 * x)) * sin((x * 10 - 0.75) * c4) + 1;
}

function easeOutQuint(x)
{
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
		if ds_queue_size(qCopy) > 0
		{
			var cardVal = ds_queue_dequeue(qCopy) mod 13;
		}
		array[i] = cardVal;
	}
	// returned array
	var returnArray = ["Nothing!"];
	
	if qSize >= 2 
	{	
		// double (two cards of the same cardVal, consecutive, on top
		if array[qSize - 1] == array[qSize - 2]
		{
			returnArray = ["Pair", array[qSize - 1], array[qSize - 2]];
		}
		
		// tens (top two cards sum to 10)
		if (array[qSize - 1] + 1) + (array[qSize - 2] + 1) == 10 
		{
			returnArray = ["Ten", array[qSize - 1], array[qSize - 2]];
		}
		
		// marriage (K, Q or Q, K on top)
		if array[qSize - 1] + array[qSize - 2] == 11 + 12 
		{
			returnArray = ["Marriage", array[qSize - 1], array[qSize - 2]];
		}
		
		if qSize >= 3
		{
			// sandwich tens (two cards separated by another sum to ten)
			if (array[qSize - 1] + 1) + (array[qSize - 3] + 1) == 10 
			{
				returnArray = ["Sandwich Ten", array[qSize - 1], array[qSize -3]];
			}
		
			// sandwich (double separated by a card)
			if array[qSize - 1] == array[qSize - 3] 
			{
				returnArray = ["Sandwich", array[qSize - 1], array[qSize - 3]];
			}
		
			// top bottom (big sandwich) (same card on bottom as on top)
			if array[qSize - 1] == array[0] 
			{
				returnArray = ["Big Sandwich", array[qSize - 1], array[0]];
			}
	
			// four in a row (ex. K, A, 2, 3 or 10, J, Q, K)
			if qSize >= 4
			{
				// ascending from top of pile
				if  (array[qSize - 4] == array[qSize - 3] + 1 
				 and array[qSize - 3] == array[qSize - 2] + 1 
				 and array[qSize - 2] == array[qSize - 1] + 1)
					or
					// descending from top of pile
					(array[qSize - 4] == array[qSize - 3] - 1
				 and array[qSize - 3] == array[qSize - 2] - 1
				 and array[qSize - 2] == array[qSize - 1] - 1)
					or
					// wrapping 
					((array[qSize - 4] == 12
					and array[qSize - 3] == 0
					and array[qSize - 2] == 1
					and array[qSize - 1] == 2)
				or
				       (array[qSize - 4] == 11
					and array[qSize - 3] == 12
					and array[qSize - 2] == 0
					and array[qSize - 1] == 1)
				or
					   (array[qSize - 4] == 10
					and array[qSize - 3] == 11
					and array[qSize - 2] == 12
					and array[qSize - 1] == 0))
				{
					returnArray = ["Four In A Row", array[qSize - 1], array[qSize - 2], array[qSize - 3], array[qSize - 4]];
				}
			}
		}
	}
	
	// avoid memory leak
	ds_queue_destroy(qCopy);
	for (var i = 1; i < array_length(returnArray); i++)
	{
		returnArray[i] = returnArray[i] + 1;
		var _out = returnArray[i];
		switch (returnArray[i])
		{
			case 1:
				_out = "A"
			break;
			
			case 11:
				_out = "J";
			break;
				
			case 12:
				_out = "Q";
			break;
			
			case 13:
				_out = "K";
			break;
		}
		returnArray[i] = _out;
	}
	return returnArray;
}

/*
TO DO:

BUG

	adjusting the global burn amount doesn't work. cards disappear.
	
	burning a card while deck is empty, doesn't trigger oDeck to show topCard SOMETIMES
	
	_______
	
	*done change detect_slappable to return the slapped cards. maybe as an array? DONE
	
	*done remember to adjust code calling detect_slappable accordingly. DONE
	
			
	
	visual feedback
		*done show why a slap was correct! 
		show fail slap animation
		show burning card animation
		
		
	audio feedback
		*done successful slap sound
		*done illegal slap sound
		out of turn attempt at playing card sound
		
	
	win state
		play again button
	
	
	dedicated slap-in button (have it set up new controls and communicate them to new player)
	
	
	
Design:

	Enforce player turns.
	
	Dedicated slap-in button for non-players: it will add a new player to the game and assign them buttons
		
	Each player has their own "play card" button, and their own "slap" button
	
	
	random notes
	eventually: make it so cards only count as being on the pile when physically on the pile (not instantly like it is now).
	better gui that shows "active" face-card and cards owed.
	
*/
