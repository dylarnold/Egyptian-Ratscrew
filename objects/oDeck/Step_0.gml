// Determine if pile is slappable.
slappable = detectSlappable(pile);
pileSize = ds_queue_size(pile);
pileTail = ds_queue_tail(pile);



// Get input from players while oDealer state is noone
if oDealer.state == noone
{
	for (var i = 0; i < pCount; i++)
	{
		var playerDeckSize = ds_queue_size(deck[i])
		// if player pressed slap button
		if keyboard_check_pressed(oSettings.playerControls[i][1])
		{
			if slappable
			{
				with oDealer
				{
					// animate cards
					state = "scooping";
					targetDeck = i;
					finalX = deckPositions[i][0];
					finalY = deckPositions[i][1];
					cardsToDeal = other.pileSize;
				}
				
				// move all cards from pile to slapping player's deck
				for (var j = 0; j < pileSize; j++)
				{
					var card = ds_queue_dequeue(pile);
					ds_queue_enqueue(deck[i], card);
				}
				
				// play audio
				audio_play_sound(sndSlapVoice1, 0, false);
			}
			else // not slappable
			{
				if playerDeckSize > 0
				{
					// burn a card
					with oDealer
					{
						// animate
						state = "burning";
						targetDeck = i;
						startX = deckPositions[i][0];
						startY = deckPositions[i][1];
						cardsToDeal = global.burnAmmount;
						image = ds_queue_head(other.deck[i]);
					}
					// move burnt cards to bottom of pile (head of queue)
					// GML queue datastructures don't support appending to left. need to copy, empty, append, append copied values.
					// copy
					var qTemp = ds_queue_create();
					ds_queue_copy(qTemp, pile);
					// empty
					ds_queue_clear(pile);
					// append
					var qTempSize = ds_queue_size(qTemp);
					for (var j = 0; j < global.burnAmmount; j++)
					{
						var card = ds_queue_dequeue(deck[i]);
						ds_queue_enqueue(pile, card);
					}
					// append copied values
					for (var j = 0; j < qTempSize; j++)
					{
						var card = ds_queue_dequeue(qTemp);
						ds_queue_enqueue(pile, card);
					}
					
					// play audio
					audio_play_sound(sndBurnVoice1, 0, false);
				}
			}
		}
		// if player uses "play card" button
		else if keyboard_check_pressed(oSettings.playerControls[i][0])
		{
			if playerDeckSize > 0 
			{
				with oDealer
				{
					state = "playing card";
					targetDeck = i;
					startX = oDealer.deckPositions[i][0];
					startY = oDealer.deckPositions[i][1];
					cardsToDeal = 1;
					image = ds_queue_head(other.deck[i]);
				}
				with oDeck
				{
					// put card into pile
					var card = ds_queue_dequeue(deck[i]);
					ds_queue_enqueue(pile, card);
				
				}
			}
		}
	}
	// pause button pressed
	if keyboard_check_pressed(oSettings.pauseKey)
	{
		// Code for pausing
	}	
	
}

