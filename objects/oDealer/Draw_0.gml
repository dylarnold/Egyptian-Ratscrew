/// @description 

for (var i = 0; i < pCount; i++)
{
	// draw deck spots at locations of player decks
	var xx = deckPositions[i][0];
	var yy = deckPositions[i][1];
	var dSize = ds_queue_size(oDeck.deck[i])
	draw_sprite(sOut, 0, xx, yy);
	if dSize > 0
	{
		draw_sprite(sCardBack, 0, xx, yy);
		draw_set_font(fnt_Gabriola);
		draw_set_color(c_navy);
		draw_text(xx - 60 , yy - 80, "Cards in Deck: " + string(dSize))
		
	}
}

if state == "scooping"
{
	draw_set_halign(fa_center);
	draw_text(room_width*.5, 50, "SLAPPED! \n by player: " + string(targetDeck + 1));
	draw_set_halign(fa_left);
}