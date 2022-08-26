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
		draw_text_ext(xx - 50, yy, string(dSize), 3, 300);
		
	}
}
