
// Get input from players while oDealer state is noone
if oDealer.state == "wait"
{
	// true if we need to skip section of code
	var skip = false;
	
	// ap used for playing cards (must be active player's turn)
	// turns wrap
	ap = ap mod pCount;
	
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
			var _x = x + sprite_width / 2 * 2.3;
			var _y = y + sprite_height / 2 * 2.3;
			instance_create_layer(_x, _y, "Instances", oSlapEffect);
			audio_play_sound(sndSlap1, 1, false);
			
			// if pile is slappable
			latestSlappedCards = detectSlappable(pile);
			if latestSlappedCards[0] != "Nothing!"
			{
				// feed oDealer info and set state
				with oDealer
				{
					state = "scooping";
					targetDeck = i;
					//finalX = deckPositions[i][0];
					//finalY = deckPositions[i][1];
					cardsToDeal = other.pileSize;
					pausing = false;
					reasonForScoop = "Slapped!";
					flip = false;
				}
				
				
				// move all cards from pile to slapping player's deck
				for (var j = 0; j < pileSize; j++)
				{
					var card = ds_queue_dequeue(pile);
					ds_queue_enqueue(deck[i], card);
				}
				// delete array used for testing
				pileArray = [];
				
				// empty pile, clear owed cards
				pileSize = 0;
				topCard = noone;
				showing = false;
				cardsOwed = 0;
				endebtedP = noone;
				ap = i;			// successful slap means that player is next
				skip = true;	// skip check for player playing card
				
				// play audio
				var snd = audio_play_sound(sndCork1, 0, false);
				audio_sound_pitch(snd, 0.85);
				
				
			}
			else // not slappable
			{
				if slappingPlayerDeckSize > 0
				{
					// burn a card
					pileSize += 1;
					
					// skip makes it impossible to slap and then play card in same turn
					skip = true;
					with oDealer
					{
						// animate
						state = "burning";
						targetDeck = i;
						//startX = deckPositions[i][0];
						//startY = deckPositions[i][1];
						cardsToDeal = global.burnAmmount;
						image = ds_queue_head(other.deck[i]);
					}
					
					// move burnt cards to bottom of pile (head of queue)
					// GML queue datastructures don't support appending to left. 
					// need to copy, empty, append, append copied values.
					
					
					var qTemp = ds_queue_create();		 
					ds_queue_copy(qTemp, pile);			 // copy pile
					
					ds_queue_clear(pile);				 // empty pile
					
					// add burned cards to pile
					for (var j = 0; j < global.burnAmmount; j++)
					{
						var card = ds_queue_dequeue(deck[i]);
						ds_queue_enqueue(pile, card);
					}
					// append copied values
					var qTempSize = ds_queue_size(qTemp);
					for (var j = 0; j < qTempSize; j++)
					{
						var card = ds_queue_dequeue(qTemp);
						ds_queue_enqueue(pile, card);
					}
					
					// play audio
					var snd = audio_play_sound(sndFailHorn1, 0, false, .2);
					
				}
			}
		}
	}
	// check if the active player pressed their play card button
	if keyboard_check_pressed(oSettings.playerControls[ap][0]) and !skip
	{
		if activePlayerDeckSize > 0 and !oDealer.pausing and oDealer.state != "scooping"
		{
			pileSize += 1;
			with oDealer
			{
				state = "playing card";
				targetDeck = other.ap;
				//startX = deckPositions[other.ap][0];
				//startY = deckPositions[other.ap][1];
				cardsToDeal = 1;
				image = ds_queue_head(other.deck[other.ap]);
			}

			// put card into pile
			
			var card = ds_queue_dequeue(deck[ap]);
			ds_queue_enqueue(pile, card);
			
			// decrement owed cards
			cardsOwed -= 1;
			
			
			// if any of (J, Q, K, A) was just played, advance turn and set cards owed for next player.
			if card != undefined
			{
				var val = card mod 13;
			}
			
			// push to array used for testing
			if val < 10
			{
				array_push(pileArray, val);
			}
			
			if val == 0 or val == 10 or val == 11 or val == 12
			{
				// test array 
				var txt = "";
				switch (val)
				{
					case 0:
						txt = "A";
					break;
					
					case 10:
						txt = "J";
					break;
					
					case 11:
						txt = "Q";
					break;
					
					case 12:
						txt = "K";
					break;
				}
				array_push(pileArray, txt);
				
				// save endebted player
				endebtedP = ap;
				ap += 1;
				
				if val == 0 
				{
					cardsOwed = 4; // 4 for A.
				}
				else
				{
					cardsOwed = val - 9; // 1 for J, 2 for Q, 3 for K.
				}
			}
			else if cardsOwed <= 0
			{
				
				if endebtedP != noone // player of the card WAS endebted after reaching 0 cards owed
				{
					// endebted player is scooping so they're the next active player.
					ap = endebtedP;
					endebtedP = noone;
					
					// below code copied and pasted from above (make function?)
					with oDealer
					{
						// animate cards
						pausing = true;
						secondTargetDeck = other.ap;
						//finalX = deckPositions[other.ap][0];
						//finalY = deckPositions[other.ap][1];
						cardsToDeal = other.pileSize;
						reasonForScoop = "Scooped!";
						flip = false;
						
						// play sound
						audio_play_sound(sndBowShot1, 1, false);
					}
				}
				else
				{
					// we weren't endebted, so turn simply advances.
					ap += 1;
				}	
			}	
		}
	}
	// pause button pressed
	if keyboard_check_pressed(oSettings.pauseKey)
	{
		// Code for pausing
		room_goto(rMenu);
	}	
}

// see if a player has won the game
var emptyDeckCount = 0;
var winner = noone;
for (var i = 0; i < pCount; i++)
{
	if array_length(deck[i]) == 0
	{
		emptyDeckCount += 1;
	}
	else
	{
		winner = i;
	}
	
}
if emptyDeckCount >= pCount - 1
{
	var myVictoryObject = instance_create_layer(500, 500, "Instances", oVictory)
	myVictoryObject.winningPlayer = winner
}


