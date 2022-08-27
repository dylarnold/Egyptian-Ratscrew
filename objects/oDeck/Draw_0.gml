/// @description 

var pileSize = ds_queue_size(pile);

if pileSize > 0 {draw_self();}

// show how many cards are in pile
draw_text(x, y - 30, string(pileSize));