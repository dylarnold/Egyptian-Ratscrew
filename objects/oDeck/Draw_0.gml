/// @description 



if pileSize > 0
{
	draw_sprite_ext(sCard, pileTail, x, y, 2.3, 2.3, 0, c_white, 1);
}

// show how many cards are in pile
draw_text(x, y - 80, "Cards in pile: " + string(pileSize));

// show the top card of the deck (temporary testing text only)
if pileSize > 0
{
	var text = string((pileTail mod 13) + 1);
	if text == "11" text = "J";
	if text == "12" text = "Q";
	if text == "13" text = "K";
	if text == "1" text = "A";
	draw_text(x - 80, y + 360,"Top Card: " + text);
}