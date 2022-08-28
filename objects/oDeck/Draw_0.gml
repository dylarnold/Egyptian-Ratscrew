/// @description 

var pileSize = ds_queue_size(pile);

if pileSize > 0 {draw_self();}

// show how many cards are in pile
draw_text(x, y - 30, string(pileSize));

// show the top card of the deck (temporary testing text only)
if pileSize > 0
{
	var text = string((ds_queue_tail(pile) mod 13) + 1);
	if text == "11" text = "J";
	if text == "12" text = "Q";
	if text == "13" text = "K";
	if text == "1" text = "A";
	draw_text(x - 30, y + 30, text);
}