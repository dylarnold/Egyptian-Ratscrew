/// @description Insert description here

if (!drawUnder and isplayed) or (drawUnder and !isplayed and oDeck.pileSize == 1)
{
	oDeck.topCard = image_index;
	oDeck.showing = true;
}