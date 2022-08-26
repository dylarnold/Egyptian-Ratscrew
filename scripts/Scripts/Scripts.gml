randomize();
global.playerCount = 2;
global.deckSize = 52
global.cardBack = sCardBack

function easeOutQuint(x){
	return 1 - power(1 - x, 5);
}


/*
TO DO:

	player turns
	player playing card
	slappable-combination detection
	options menu
	
	
Design:
	
	Universal slap button?
	
		Pros: feels more like real game. 
		Players don't need their own slap buttons
		Players can "slap in". (have to manually add player and set up their controls)
			
		Cons: Have to manually enter who won the slap. Broken keyboard. 
	
	
		Dedicated slap-in button for non-players: it will add a new player to the game and assign them buttons
	
*/
