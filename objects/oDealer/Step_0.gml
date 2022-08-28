
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
			
			// Cycle through all decks
			targetDeck += 1;
			if targetDeck >= pCount {targetDeck = targetDeck mod pCount;}
			
			if cardsToDeal <= 0 {state = noone;}
			
		break;
		
		case "playing card":
			var myCard = instance_create_layer(deckPositions[targetDeck][0], deckPositions[targetDeck][1], "Instances", oDealtCard);
			
			myCard.finalX = oDeck.x;
			myCard.finalY = oDeck.y;
			
			myCard.easingFunc = easeOutQuint;
			myCard.c = myCard.dealSpeed(.25);
			state = noone;
			
		break
		
		case "scooping":
			// reset timer
			dealTimer = dealTimerMax / (cardsToDeal / 3);
	
			//decrement remaining cards
			cardsToDeal -= 1;
			
			var myCard = instance_create_layer(oDeck.x, oDeck.y, "Instances", oDealtCard);
			
			// animate from deck/pile position to particular deck
			myCard.finalX = deckPositions[targetDeck][0];
			myCard.finalY = deckPositions[targetDeck][1];
			myCard.c = myCard.dealSpeed(1);
			
			if cardsToDeal <= 0 {state = noone;}
			
			
		break;

		case "burning":
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
 
