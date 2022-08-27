/// @description

// _______ cards in pile upon successful slap. 
//OR... 1 when a player plays a card to the pile
// targetDeck = _________ deck belonging to the player who successfully slapped


if dealTimer <= 0 and cardsToDeal > 0
{
	switch (state)
	{
		case "dealing":
			// reset timer
			dealTimer = dealTimerMax / (cardsToDeal / 3);
	
			//decrement remaining cards
			cardsToDeal -= 1;
	
			// instantiate card
			var myCard = instance_create_layer(oDeck.x, oDeck.y, "Instances", oDealtCard);
	
			// animate from deck position (default) to player decks
			myCard.finalX = deckPositions[targetDeck][0]; 
			myCard.finalY = deckPositions[targetDeck][1]; 
	
			myCard.c = myCard.dealSpeed(2);
	
			targetDeck += 1;
			if targetDeck >= pCount
			{
				targetDeck = targetDeck mod pCount;
			}
			if cardsToDeal <= 0
			{
				state = noone;
			}
			
		break;
		
		case "playing card":
			// code
			var myCard = instance_create_layer(deckPositions[targetDeck][0], deckPositions[targetDeck][1], "Instances", oDealtCard);
			
			myCard.finalX = oDeck.x;
			myCard.finalY = oDeck.y;
			
			myCard.easingFunc = easeOutQuint;
			myCard.c = myCard.dealSpeed(.25);
			state = noone;
			
		break
		
		case "scooping":
			// code
			var myCard = instance_create_layer(oDeck.x, oDeck.y, "Instances", oDealtCard);
			
			// reset timer
			dealTimer = dealTimerMax / (cardsToDeal / 3);
	
			//decrement remaining cards
			cardsToDeal -= 1;
			
			// animate from deck/pile position to particular deck
			myCard.finalX = deckPositions[targetDeck][0];
			myCard.finalY = deckPositions[targetDeck][1];
			
			myCard.c = myCard.dealSpeed(1);
			
			if cardsToDeal <= 0
			{
				state = noone;
			}
			
		break;

		case "burning":
			// code
			var myCard = instance_create_layer(deckPositions[targetDeck][0], deckPositions[targetDeck][1], "Instances", oDealtCard);
			
			myCard.finalX = oDeck.x;
			myCard.finalY = oDeck.y;
			
			myCard.easingFunc = easeOutQuint;
			myCard.c = myCard.dealSpeed(.5);
			
			state = noone;
		break;
	}
}



// timer ticks down
dealTimer -= 1;
 
