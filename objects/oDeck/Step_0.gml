
// Get input from players while oDealer state is noone
if oDealer.state == "wait"
{
	// true if we need to skip section of code
	var skip = false;
	
	// ap used for playing cards (must be active player's turn)
	// turns wrap
	if ap >= pCount
	{
		ap = 0;
	}
	var activePlayerDeckSize = ds_queue_size(deck[ap]);
	// find next active player without an empty deck
	var loopcheck = 0;
	while (activePlayerDeckSize <= 0 and loopcheck < 1)
	{
		ap += 1;
		if ap >= pCount
		{
			ap = 0;
			loopcheck += 1;
		}
		activePlayerDeckSize = ds_queue_size(deck[ap]);
	}
	
	// see if any player slapped (looping through all players, checking if their slap button was pressed
	for (var i = 0; i < pCount; i++) // i used for slapping (can do at any time)
	{
		var slappingPlayerDeckSize = ds_queue_size(deck[i]);
		
		// if player pressed slap button
		if keyboard_check_pressed(oSettings.playerControls[i][1])
		{
			// play sound and effect
			var myslap = instance_create_layer((x + sprite_width / 2 * 2.3), (y + sprite_height / 2 * 2.3), "Instances", oSlapEffect);
			audio_play_sound(sndSlap1, 1, false);
			
			// if pile is slappable
			if detectSlappable(pile)
			{
				showing = false;
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
				pileSize = 0;
				topCard = noone;
				
				// play audio
				var snd = audio_play_sound(sndSlapVoice1, 0, false);
				audio_sound_pitch(snd, 0.85);
				
				// successful slap means that player is next
				ap = i
				// skip check for player playing card
				skip = true;
			}
			else // not slappable
			{
				if slappingPlayerDeckSize > 0
				{
					// burn a card
					pileSize += 1;
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
					// GML queue datastructures don't support appending to left. 
					// need to copy, empty, append, append copied values.
					
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
					var snd = audio_play_sound(sndBurnVoice1, 0, false);
					audio_sound_pitch(snd, 0.85);
				}
			}
		}
	}
	// check if the active player pressed their play card button
	if keyboard_check_pressed(oSettings.playerControls[ap][0]) and !skip
	{
		if activePlayerDeckSize > 0 
		{
			pileSize += 1;
			with oDealer
			{
				state = "playing card";
				targetDeck = other.ap;
				startX = deckPositions[other.ap][0];
				startY = deckPositions[other.ap][1];
				cardsToDeal = 1;
				image = ds_queue_head(other.deck[other.ap]);
			}

			// put card into pile
			var card = ds_queue_dequeue(deck[ap]);
			ds_queue_enqueue(pile, card);
			
			// advance player turn to next player
			ap += 1;
		}
	}
	// pause button pressed
	if keyboard_check_pressed(oSettings.pauseKey)
	{
		// Code for pausing
	}	
}

