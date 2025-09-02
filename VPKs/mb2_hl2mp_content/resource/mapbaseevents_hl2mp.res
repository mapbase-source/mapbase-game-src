//=========== (C) Copyright 1999 Valve, L.L.C. All rights reserved. ===========
//
// The copyright to the contents herein is the property of Valve, L.L.C.
// The contents may be used and/or copied only with the written permission of
// Valve, L.L.C., or in accordance with the terms and conditions stipulated in
// the agreement/contract under which the contents have been supplied.
//=============================================================================

// No spaces in event names, max length 32
// All strings are case sensitive
// total game event byte length must be < 1024
//
// valid data key types are:
//   none   : value is not networked
//   string : a zero terminated string
//   bool   : unsigned int, 1 bit
//   byte   : unsigned int, 8 bit
//   short  : signed int, 16 bit
//   long   : signed int, 32 bit
//   float  : float, 32 bit



"gameevents"
{
//////////////////////////////////////////////////////////////////////
// Mapbase events
//////////////////////////////////////////////////////////////////////

	// NPC version of player_death which mainly allows for NPC victim death notices.
	"npc_death"				// a game event, name may be 32 charaters long
	{
		"victim_name"	"string"   	// net name who died				
		"victim_entindex"	"short"   	// ent index who died				
		"attacker_entindex"	"short"	 	// ent index who killed
		"weapon"	"string" 	// weapon name killed used 
	}

	//"player_bot_replace"
	//{
	//	"userid"	"short"		// user ID of the player
	//	"botid"		"short"		// user ID of the bot
	//}
	//
	//"bot_player_replace"
	//{
	//	"botid"		"short"		// user ID of the bot
	//	"userid"	"short"		// user ID of the player
	//}
}