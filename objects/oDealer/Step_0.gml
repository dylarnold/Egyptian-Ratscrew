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
	
			//myCard.startX = (player who played the card's deck.x)
			//myCard.startY = (player who played the card's deck.y)
			myCard.finalX = deckPositions[targetDeck][0]; // OR the discard pile
			myCard.finalY = deckPositions[targetDeck][1]; // OR the discard pile
	
			myCard.c = myCard.dealSpeed(2);
	
			targetDeck += 1;
			if targetDeck >= pCount
			{
				targetDeck = targetDeck mod pCount;
			}
		break;
		
		case "scooping":
			// code
			
		break;

		case "burning":
			// code
		break;
	}
}














// timer ticks down
dealTimer -= 1;
 
 // reset target to deal to
if !dealing {targetDeck = 0;}
 
