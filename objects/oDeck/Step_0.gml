
// Get input from players while oDealer state is noone
if oDealer.state == "wait"
{
	var ap = activePlayer	// ap used for playing cards (must be active player's turn)
	var activePlayerDeckSize = ds_queue_size(deck[ap]);
	
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
		// if player uses "play card" button
		else if keyboard_check_pressed(oSettings.playerControls[ap][0])
		{
			if activePlayerDeckSize > 0 
			{
				pileSize += 1;
				with oDealer
				{
					state = "playing card";
					targetDeck = ap;
					startX = deckPositions[ap][0];
					startY = deckPositions[ap][1];
					cardsToDeal = 1;
					image = ds_queue_head(other.deck[ap]);
				}

				// put card into pile
				var card = ds_queue_dequeue(deck[ap]);
				ds_queue_enqueue(pile, card);
				
				// advance player turn to next player
				activePlayer += 1;
				if activePlayer >= pCount
				{
					activePlayer = 0;
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

