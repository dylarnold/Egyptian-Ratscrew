
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
			myCard.c = myCard.dealSpeed(1);
			myCard.sprite_index = sCardBack;
			myCard.targetScale = 1;
			myCard.easingFunc = easeOutElastic;
			myCard.scale = 2.3; // magic number
			
			
			// Cycle through all decks
			targetDeck += 1;
			if targetDeck >= pCount {targetDeck = targetDeck mod pCount;}
			
			if cardsToDeal <= 0 {state = "wait";}
			
		break;
		
		case "playing card":
			var myCard = instance_create_layer(deckPositions[targetDeck][0], deckPositions[targetDeck][1], "Instances", oDealtCard);
			
			myCard.finalX = oDeck.x;
			myCard.finalY = oDeck.y;
			
			myCard.easingFunc = easeOutQuint;
			myCard.c = myCard.dealSpeed(.25);
			myCard.sprite_index = sCard;
			myCard.image_index = image;
			myCard.targetScale = 2.3 // magic number
			myCard.isplayed = true; // being played to the deck ( as opposed to dealt or something else)
			
			// draw depth related
			cardDepth -= 1;
			myCard.depth = cardDepth;
			
			state = "wait";
			
		break;
		
		case "scooping":
			// reset timer
			dealTimer = dealTimerMax / (cardsToDeal / 3);
	
			//decrement remaining cards
			cardsToDeal -= 1;
			
			var myCard = instance_create_layer(oDeck.x, oDeck.y, "Instances", oDealtCard);
			
			//change top deck card as cards are removed TODO
			// code
			
			// reset oDeck's showing value to false
			oDeck.showing = false;
			
			// animate from deck/pile position to particular deck
			myCard.finalX = deckPositions[targetDeck][0];
			myCard.finalY = deckPositions[targetDeck][1];
			myCard.c = myCard.dealSpeed(1.5);
			myCard.sprite_index = sCardBack;
			myCard.targetScale = 1;
			myCard.scale = 2.3; // magic number
			
			// depth related
			cardDepth = depth - 53;
			
			if cardsToDeal <= 0 {state = "wait";}
			
			
		break;

		case "burning":
			var _x = deckPositions[targetDeck][0];
			var _y = deckPositions[targetDeck][1];
			var myCard = instance_create_layer(_x, _y, "Instances", oDealtCard);
			
			myCard.finalX = oDeck.x;
			myCard.finalY = oDeck.y;
			myCard.easingFunc = easeOutQuint;
			myCard.c = myCard.dealSpeed(1);
			myCard.sprite_index = sCard;
			myCard.image_index = image;			
			myCard.targetScale = 2.3; // magic number
			myCard.drawUnder = true;
			state = "wait";
		break;
	}
}

// timer ticks down
dealTimer -= 1;
 
