boolean in_lar()
{
	return my_path() == $path[Live. Ascend. Repeat.];
}

boolean lar_safeguard()
{
	if(in_lar())
	{
		string repeats = get_property("lastEncounter");
		if((repeats == "Skull, Skull, Skull") || (repeats == "Urning Your Keep") || (repeats == "Turn Your Head and Coffin") || (repeats == "Curtains") || (repeats == "There's No Ability Like Possibility") || (repeats == "Putting Off Is Off-Putting") || (repeats == "Huzzah!"))
		{
			if(get_property("_auto_groundhogSkip").to_int() == my_turncount())
			{
				set_property("_auto_groundhogSkipCounter", get_property("_auto_groundhogSkipCounter").to_int()+1);
			}
			if(get_property("_auto_groundhogSkipCounter").to_int() > 6)
			{
				abort("You have a non-combat that can infinitely loop and we are going to infintely loop on it like a groundhog. Maybe you should spend this adventure somewhere to ease the pain for all of us.");
			}
			set_property("_auto_groundhogSkip", my_turncount());
		}
		else
		{
			set_property("_auto_groundhogSkipCounter", 0);
			set_property("_auto_groundhogSkip", -1);
		}
	}
	return false;
}

boolean lar_repeat(location loc)
{
	if(in_lar())
	{
		if($locations[The Castle In The Clouds In The Sky (Ground Floor), The Defiled Alcove, The Defiled Niche, The Defiled Nook, The Haunted Ballroom] contains loc)
		{
			if(get_property("_auto_groundhogSkip").to_int() == my_turncount())
			{
				return false;
			}
		}
	}
	return true;
}



boolean lar_abort(location loc)
{
	if(in_lar())
	{
		generic_t itemNeed = zone_needItem(loc);
		if(!itemNeed._boolean)
		{
			return true;
		}

		//These should be places that we would not consider overriding with a YR.
		foreach place in $locations[The F\'C\'Le, The Hole In The Sky]
		{
			if((place == loc) && (item_drop_modifier() < itemNeed._float))
			{
				abort("Not enough +item drop (" + itemNeed._float + ") for " + loc + " only have: " + item_drop_modifier());
			}
		}
	}
	return true;
}


boolean LM_lar()
{
	//Not best way but just do it...
	if(in_lar())
	{
		if(get_property("_sourceTerminalDigitizeUses").to_int() < 3)
		{
			set_property("_sourceTerminalDigitizeUses", 3);
		}
	}
	return false;
}
