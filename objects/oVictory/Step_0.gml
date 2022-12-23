/// @description 

for (var i = 0; i < global.playerCount; i++)
{
	if !stop
	{
		if ds_queue_size(oDeck.deck[i]) == 52
		{
			displayString = "Player " + string(i + 1) + " is the winner! \n Press Q to quit \n Press R to play again!";
			instance_deactivate_all(true);
			stop = true;
			sprite_index = sCongratulations;
		
		}
	}
}
