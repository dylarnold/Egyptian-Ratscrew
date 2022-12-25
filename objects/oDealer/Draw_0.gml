/// @description 

for (var i = 0; i < pCount; i++)
{
	// draw deck spots at locations of player decks
	var xx = deckPositions[i][0];
	var yy = deckPositions[i][1];
	var dSize = ds_queue_size(oDeck.deck[i])
	
	if dSize > 0
	{
		// draw deck
		draw_sprite_ext(sCardBack, 0, xx, yy, 1, 1, 0, c_white, 1);
		// draw player indicator
		if i == oDeck.ap
		{
			draw_sprite(sCardIndicator, 0, xx, yy);
		}
		draw_set_font(fnt_Gabriola);
		draw_set_color(c_navy);
		draw_text(xx - 60 , yy - 80, "Player " + string(i + 1) + "'s Cards: " + string(dSize));
		draw_set_color(c_white);
	}
	else
	{
		draw_sprite(sOut, 0, xx, yy);
	}
}

if state == "scooping"
{
	displayReasonTimer = displayReasonTimerMax;
	
	if !flip
	{

		flip = true;
	}
}

// display who got the scoop/slap near their deck
if displayReasonTimer >= 0 and flip and playerWhoGetsTheScoop != noone
{
	draw_set_color(c_navy);
	draw_set_halign(fa_center);
	var _x = deckPositions[playerWhoGetsTheScoop][0] + 35;
	var _y = deckPositions[playerWhoGetsTheScoop][1] - 220;
	draw_text(_x, _y, reasonForScoop + "\n by player: " + string(playerWhoGetsTheScoop + 1));
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	displayReasonTimer -= 1;
}
else
{
	flip = false;
}