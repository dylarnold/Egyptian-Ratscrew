/// @description 


// Get input from players while oDealer state is noone

if oDealer.state == noone
{
	for (var i = 0; i < pCount; i++)
	{
		// if player pressed slap button
		if keyboard_check_pressed(oSettings.playerControls[i][1])
		{
			with oDealer
			{
				state = "scooping";
				targetDeck = i;
				finalX = deckPositions[i][0];
				finalY = deckPositions[i][1];
				cardsToDeal = ds_queue_size(oDeck.pile);
			}
			with oDeck
			{	
				// move all cards from pile to slapping player's deck
				for (var j = 0; j < ds_queue_size(pile); j++)
				{
					var card = ds_queue_dequeue(pile);
					ds_queue_enqueue(deck[i], card);
				}
			}
		}
		// if player uses "play card" button
		else if keyboard_check_pressed(oSettings.playerControls[i][0])
		{
			if ds_queue_size(deck[i]) > 0 
			{
				with oDealer
				{
					state = "playing card";
					targetDeck = i;
					startX = oDealer.deckPositions[i][0];
					startY = oDealer.deckPositions[i][1];
					cardsToDeal = 1;
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