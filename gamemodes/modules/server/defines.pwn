//==============================================================================
//          -- > Error Message Defines
//==============================================================================
#define ERROR_LOGGEDIN															"{FFFFFF}You are not logged in, mate."
#define ERROR_ADMIN 															"{FFFFFF}You don't have access to this command."
#define ERROR_SPAM_TIME															"{FFFFFF}This command cannot be performed at this point in time."
#define ERROR_LOCATION															"{FFFFFF}This command cannot be performed at this location."
#define ERROR_MONEY																"{FFFFFF}Insufficient funds."
#define ERROR_ADMINLEVEL														"{FFFFFF}This cannot be performed on a higher level administrator."
#define ERROR_INVALIDPLAYER														"{FFFFFF}Invalid player specified."
#define ERROR_VEHICLE															"{FFFFFF}You must be in a vehicle to perform this command."
#define ERROR_FACTION 															"{FFFFFF}You don't have access to this command."
#define ERROR_VALUE																"{FFFFFF}You cannot use that value at this point in time."
#define ERROR_OPTION															"{FFFFFF}Not a valid option."
#define ERROR_DIALOG															"{FFFFFF}The dialog has been closed."
#define ERROR_RANK																"{FFFFFF}Not a high enough rank."
#define ERROR_MUTED																"{FFFFFF}You are muted, you cannot talk."
#define ERROR_OWNED																"{FFFFFF}You already own an item of this type."
#define ERROR_OWNER																"{FFFFFF}This item is already owned."
#define ERROR_NOTOWNED															"{FFFFFF}You do not own this item."
#define ERROR_JOB																"{FFFFFF}You don't have the job required to do this."
#define ERROR_CONNECTED															"{FFFFFF}The player that you are requesting isn't connected."

//==============================================================================
//          -- > Server Limits
//==============================================================================
#undef MAX_PLAYERS
#undef MAX_VEHICLES
#define MAX_PLAYERS 															128
#define MAX_VEHICLES                                                      		200
#define MAX_CUSTOM_SKINS														131
#define MAX_ARENAS																13
#define MAX_ZONE_NAME           				                                28

#define SPLITLENGTH 118

#define LOG_PATH "/Server Logs/%s.txt"

#define SECONDS(%0)             (%0*1000)
#define MINUTES(%0)             (%0*SECONDS(60))
#define HOURS(%0)               (%0*MINUTES(60))

#define KeyPressed(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define KeyRelease(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define KeyHeld(%0) ((newkeys & (%0)) == (%0))


//==============================================================================
//          -- > Worlds & other
//==============================================================================

#define IsOdd(%0) %0 % 2

#define MAXLEN 80

#define MODEL_SELECTION_VTUNE 0
#define MODEL_SELECTION_DONORSKIN 1
#define MODEL_SELECTION_SKINLIST 2
#define MODEL_SELECTION_CUSTOMSKIN 3

#define HOST_TEAM 1


#define WORLD_GANGWARS 1005
//#define WORLD_COPCHASE 1006
//==============================================================================
//          -- > Admin Flags for CMDS
//==============================================================================
#define AD1 1
#define AD2 2
#define AD3 3
#define AD4 4
#define AD5 5
#define AD6 6
#define FRM 7
#define TDM 8
#define CLN 9
#define CM 10
#define FRMTDM 11
#define CLNTDM 12
//==============================================================================
//          -- > ZMSG
//==============================================================================
#define ZMSG_HYPHEN_END ""
#define ZMSG_HYPHEN_START ""
//==============================================================================
//          -- > Colors
//==============================================================================
#define COLOR_GROUPTALK 0x87CEEBAA  // SKYBLUE
#define COLOR_MENU 0xFFFFFFAA		// WHITE (FFFFFF) menu's (/help)
#define COLOR_SYSTEM_PM 0x66CC00AA	// LIGHT GREEN
#define COLOR_SYSTEM_PW 0xFFFF33AA	// YELLOW

//==============================================================================
//          -- > bcrypt workfactor
//==============================================================================
#define BCRYPT_COST 13

//==============================================================================
//          -- > skinroll month string
//==============================================================================
#define SKINROLL_MONTHS "December 2017\nJanuary 2018\nFebruary 2018\nMarch 2018\nApril 2018\nMay 2018\nJune 2018\nJuly 2018\nFebruary 2019\nMarch 2019"

#define EMBED_WHITE			"{FFFFFF}"
#define EMBED_GREEN			"{33AA33}"
#define EMBED_RED			"{FF0000}"
#define EMBED_BLUE 			"{0000FF}"
#define EMBED_PINK			"{FF69B4}"
#define EMBED_PURPLE 		"{9900FF}"
#define EMBED_YELLOW		"{FFFF00}"
#define EMBED_BROWN 		"{A52A2A}"
#define EMBED_GREY			"{AFAFAF}"
#define EMBED_BLACK			"{000000}"
#define EMBED_LPINK			"{F64BC2}"
#define EMBED_ORANGE		"{FF8000}"
#define EMBED_PINKRED       "{FF0040}"
#define EMBED_DARKRED		"{DC143C}"	// crimson
#define EMBED_DARKERRED		"{660000}"
#define EMBED_ORANGERED 	"{FF4500}"
#define EMBED_TOMATO 		"{FF6347}"
#define EMBED_LIGHTBLUE		"{33CCFF}"
#define EMBED_LIGHTNAVY		"{8FFDFF}"
#define	EMBED_NAVYBLUE		"{3366FF}"
#define EMBED_LBLUE			"{00FFFF}"
#define EMBED_LLBLUE		"{0080FF}"
#define EMBED_FLBLUE		"{6495ED}"
#define EMBED_BLUEVIOLET 	"{8A2BE2}"	// dark purple
#define EMBED_BISQUE		"{FFE4C4}"
#define EMBED_LIME			"{10F441}"
#define EMBED_LAWNGREEN 	"{7CFC00}"
#define EMBED_SEAGREEN 		"{20B2AA}"
#define EMBED_LIMEGREEN 	"{32CD32}"	//<--- Dark lime
#define EMBED_SPRINGGREEN 	"{00FF7F}"
#define EMBED_YELLOWGREEN 	"{9ACD32}"	//- like military green
#define EMBED_GREENYELLOW 	"{ADFF2F}"
#define EMBED_OLIVE 		"{808000}"
#define EMBED_AQUA			"{F0F8FF}"
#define EMBED_MEDIUMAQUA 	"{83BFBF}"
#define EMBED_MAGENTA		"{FF00FF}"
#define EMBED_MEDIUMMAGENTA	"{8B008B}"	// dark magenta
#define EMBED_CHARTREUSE	"{7FFF00}"
#define EMBED_CORAL 		"{FF7F50}"
#define EMBED_GOLD 			"{B8860B}"
#define EMBED_INDIGO 		"{4B00B0}"
#define EMBED_IVORY 		"{FFFF82}"

#define INVISIBLE_BLACK    (0)
#define pCOLOR_INVISIBLE    	0xFFFFFF00
#define pCOLOR_WHITE			0xFFFFFFAA
#define pCOLOR_GREEN			0x33AA33AA
#define pCOLOR_RED				0xFF0000FF
#define pCOLOR_BLUE 			0x0000FFFF
#define pCOLOR_PINK				0xFF69B4FF
#define pCOLOR_PURPLE 			0x9900FFAA
#define pCOLOR_YELLOW			0xFFFF00AA
#define pCOLOR_BROWN 			0xA52A2AAA
#define pCOLOR_GREY				0xAFAFAFAA
#define pCOLOR_BLACK			0x000000AA
#define pCOLOR_LPINK			0xF64BC2AA
#define pCOLOR_ORANGE			0xFF8000FF
#define pCOLOR_PINKRED       	0xFF0040AA
#define pCOLOR_DARKRED			0xDC143CAA	// crimson
#define pCOLOR_DARKERRED		0x660000AA
#define pCOLOR_ORANGERED 		0xFF4500AA
#define pCOLOR_TOMATO 			0xFF6347AA
#define pCOLOR_LIGHTBLUE		0x33CCFFAA
#define pCOLOR_LIGHTNAVY		0x8FFDFFAA
#define	pCOLOR_NAVYBLUE			0x3366FFAA
#define pCOLOR_LBLUE			0x00FFFFAA
#define pCOLOR_LLBLUE			0x0080FFFF
#define pCOLOR_FLBLUE			0x6495EDAA
#define pCOLOR_BLUEVIOLET 		0x8A2BE2FF	// dark purple
#define pCOLOR_BISQUE			0xFFE4C4AA
#define pCOLOR_LIME				0x10F441AA
#define pCOLOR_LAWNGREEN 		0x7CFC00AA
#define pCOLOR_SEAGREEN 		0x20B2AAAA
#define pCOLOR_LIMEGREEN 		0x32CD32AA	//<--- Dark lime
#define pCOLOR_SPRINGGREEN 		0x00FF7FAA
#define pCOLOR_YELLOWGREEN 		0x9ACD32AA	//- like military green
#define pCOLOR_GREENYELLOW 		0xADFF2FAA
#define pCOLOR_OLIVE 			0x808000AA
#define pCOLOR_AQUA				0xF0F8FFAA
#define pCOLOR_MEDIUMAQUA 		0x83BFBFAA
#define pCOLOR_MAGENTA			0xFF00FFFF
#define pCOLOR_MEDIUMMAGENTA	0x8B008BAA	// dark magenta
#define pCOLOR_CHARTREUSE		0x7FFF00AA
#define pCOLOR_CORAL 			0xFF7F50AA
#define pCOLOR_GOLD 			0xB8860BAA
#define pCOLOR_INDIGO 			0x4B00B0AA
#define pCOLOR_IVORY 			0xFFFF82AA

#define COL_WHITE                                                               "{FFFFFF}"
#define COL_RED                                                                 "{F81414}"
#define COL_GREEN                                                               "{00FF22}"
#define COL_BLUE                                                                "{00C0FF}"
#define COL_LBLUE                                                               "{D3DCE3}"
#define COL_ORANGE                                                              "{FFAF00}"
#define COL_CYAN                                                                "{00FFEE}"
#define COL_BLACK                                                               "{0E0101}"
#define COL_GRAY                                                                "{C3C3C3}"
#define COL_DGREEN                                                              "{336633}"


#define COLOR_BLUE                                                              0x0000FFFF
#define COLOR_LGREEN                                                            0x00FF00FF
#define COLOR_YELLOW                                                            0xFFFF00FF
#define COLOR_BLACK                                                             0x000000FF
#define COLOR_GRAY                                                              0xC0C0C0FF
#define COLOR_WHITE                                                             0xFFFFFFFF
#define COLOR_GREY                                                              0xAFAFAFAA
#define COLOR_LBLUE                                                             0x3C3176AA
#define COLOR_MBLUE                                                             0x2E37FEAA
#define COLOR_DGREEN                                                            0x007200AA
#define COLOR_RP                                                                0xC2A2DAAA


#define COLOR_AQUA                                                               0x00FFFFFF
#define COLOR_AQUAMARINE                                                         0x7FFFD4FF
#define COLOR_AZURE                                                              0xF0FFFFFF
#define COLOR_BEIGE                                                              0xF5F5DCFF
#define COLOR_BISQUE                                                             0xFFE4C4FF
#define COLOR_BLACK                                                              0x000000FF
#define COLOR_BLANCHEDALMOND                                                     0xFFEBCDFF
#define COLOR_BLUE                                                               0x0000FFFF
#define COLOR_BLUEVIOLET                                                         0x8A2BE2FF
#define COLOR_BROWN                                                              0xA52A2AFF
#define COLOR_BURLYWOOD                                                          0xDEB887FF
#define COLOR_BUTTONFACE                                                         0xF0F0F0FF
#define COLOR_BUTTONHIGHLIGHT                                                    0xFFFFFFFF
#define COLOR_BUTTONSHADOW                                                       0xA0A0A0FF
#define COLOR_CADETBLUE                                                          0x5F9EA0FF
#define COLOR_CHARTREUSE                                                         0x7FFF00FF
#define COLOR_CHOCOLATE                                                          0xD2691EFF
#define COLOR_CORAL                                                              0xFF7F50FF
#define COLOR_CORNFLOWERBLUE                                                     0x6495EDFF
#define COLOR_CORNSILK                                                           0xFFF8DCFF
#define COLOR_CRIMSON                                                            0xDC143CFF
#define COLOR_CYAN                                                               0x00FFFFFF
#define COLOR_DARKBLUE                                                           0x00008BFF
#define COLOR_DARKCYAN                                                           0x008B8BFF
#define COLOR_DARKGOLDENROD                                                      0xB8860BFF
#define COLOR_DARKGRAY                                                           0xA9A9A9FF
#define COLOR_DARKGREEN                                                          0x006400FF
#define COLOR_DARKKHAKI                                                          0xBDB76BFF
#define COLOR_DARKMAGENTA                                                        0x8B008BFF
#define COLOR_DARKOLIVEGREEN                                                     0x556B2FFF
#define COLOR_DARKORANGE                                                         0xFF8C00FF
#define COLOR_DARKORCHID                                                         0x9932CCFF
#define COLOR_DARKRED                                                            0x8B0000FF
#define COLOR_DARKSALMON                                                         0xE9967AFF
#define COLOR_DARKSEAGREEN                                                       0x8FBC8BFF
#define COLOR_DARKSLATEBLUE                                                      0x483D8BFF
#define COLOR_DARKSLATEGRAY                                                      0x2F4F4FFF
#define COLOR_DARKTURQUOISE                                                      0x00CED1FF
#define COLOR_DARKVIOLET                                                         0x9400D3FF
#define COLOR_DEEPPINK                                                           0xFF1493FF
#define COLOR_DEEPSKYBLUE                                                        0x00BFFFFF
#define COLOR_DESKTOP                                                            0x000000FF
#define COLOR_DIMGRAY                                                            0x696969FF
#define COLOR_DODGERBLUE                                                         0x1E90FFFF
#define COLOR_FIREBRICK                                                          0xB22222FF
#define COLOR_FLORALWHITE                                                        0xFFFAF0FF
#define COLOR_FORESTGREEN                                                        0x228B22FF
#define COLOR_FUCHSIA                                                            0xFF00FFFF
#define COLOR_GAINSBORO                                                          0xDCDCDCFF
#define COLOR_GHOSTWHITE                                                         0xF8F8FFFF
#define COLOR_GOLD                                                               0xFFD700FF
#define COLOR_GOLDENROD                                                          0xDAA520FF
#define COLOR_GRAYTEXT                                                           0x808080FF
#define COLOR_GREEN                                                              0x008000FF
#define COLOR_GREENYELLOW                                                        0xADFF2FFF
#define COLOR_HIGHLIGHT                                                          0x3399FFFF
#define COLOR_HIGHLIGHTTEXT                                                      0xFFFFFFFF
#define COLOR_HONEYDEW                                                           0xF0FFF0FF
#define COLOR_HOTPINK                                                            0xFF69B4FF
#define COLOR_HOTTRACK                                                           0x0066CCFF
#define COLOR_INDIANRED                                                          0xCD5C5CFF
#define COLOR_INDIGO                                                             0x4B0082FF
#define COLOR_INFO                                                               0xFFFFE1FF
#define COLOR_INFOTEXT                                                           0x000000FF
#define COLOR_IVORY                                                              0xFFFFF0FF
#define COLOR_KHAKI                                                              0xF0E68CFF
#define COLOR_LAVENDER                                                           0xE6E6FAFF
#define COLOR_LAVENDERBLUSH                                                      0xFFF0F5FF
#define COLOR_LAWNGREEN                                                          0x7CFC00FF
#define COLOR_LEMONCHIFFON                                                       0xFFFACDFF
#define COLOR_LIGHTBLUE                                                          0xADD8E6FF
#define COLOR_LIGHTCORAL                                                         0xF08080FF
#define COLOR_LIGHTCYAN                                                          0xE0FFFFFF
#define COLOR_LIGHTGOLDENRODYELLOW                                               0xFAFAD2FF
#define COLOR_LIGHTGRAY                                                          0xD3D3D3FF
#define COLOR_LIGHTGREEN                                                         0x90EE90FF
#define COLOR_LIGHTPINK                                                          0xFFB6C1FF
#define COLOR_LIGHTSALMON                                                        0xFFA07AFF
#define COLOR_LIGHTSEAGREEN                                                      0x20B2AAFF
#define COLOR_LIGHTSKYBLUE                                                       0x87CEFAFF
#define COLOR_LIGHTSLATEGRAY                                                     0x778899FF
#define COLOR_LIGHTSTEELBLUE                                                     0xB0C4DEFF
#define COLOR_LIGHTYELLOW                                                        0xFFFFE0FF
#define COLOR_LIME                                                               0x00FF00FF
#define COLOR_LIMEGREEN                                                          0x32CD32FF
#define COLOR_LINEN                                                              0xFAF0E6FF
#define COLOR_MAGENTA                                                            0xFF00FFFF
#define COLOR_MAROON                                                             0x800000FF
#define COLOR_MEDIUMAQUAMARINE                                                   0x66CDAAFF
#define COLOR_MEDIUMBLUE                                                         0x0000CDFF
#define COLOR_MEDIUMORCHID                                                       0xBA55D3FF
#define COLOR_MEDIUMPURPLE                                                       0x9370DBFF
#define COLOR_MEDIUMSEAGREEN                                                     0x3CB371FF
#define COLOR_MEDIUMSLATEBLUE                                                    0x7B68EEFF
#define COLOR_MEDIUMSPRINGGREEN                                                  0x00FA9AFF
#define COLOR_MEDIUMTURQUOISE                                                    0x48D1CCFF
#define COLOR_MEDIUMVIOLETRED                                                    0xC71585FF
#define COLOR_MIDNIGHTBLUE                                                       0x191970FF
#define COLOR_MINTCREAM                                                          0xF5FFFAFF
#define COLOR_MISTYROSE                                                          0xFFE4E1FF
#define COLOR_MOCCASIN                                                           0xFFE4B5FF
#define COLOR_NAVAJOWHITE                                                        0xFFDEADFF
#define COLOR_NAVY                                                               0x000080FF
#define COLOR_OLDLACE                                                            0xFDF5E6FF
#define COLOR_OLIVE                                                              0x808000FF
#define COLOR_OLIVEDRAB                                                          0x6B8E23FF
#define COLOR_ORANGE                                                             0xFFA500FF
#define COLOR_ORANGERED                                                          0xFF4500FF
#define COLOR_ORCHID                                                             0xDA70D6FF
#define COLOR_PALEGOLDENROD                                                      0xEEE8AAFF
#define COLOR_PALEGREEN                                                          0x98FB98FF
#define COLOR_PALETURQUOISE                                                      0xAFEEEEFF
#define COLOR_PALEVIOLETRED                                                      0xDB7093FF
#define COLOR_PAPAYAWHIP                                                         0xFFEFD5FF
#define COLOR_PEACHPUFF                                                          0xFFDAB9FF
#define COLOR_PERU                                                               0xCD853FFF
#define COLOR_PINK                                                               0xFFC0CBFF
#define COLOR_PLUM                                                               0xDDA0DDFF
#define COLOR_POWDERBLUE                                                         0xB0E0E6FF
#define COLOR_PURPLE                                                             0x800080FF
#define COLOR_RED                                                                0xFF0000FF
#define COLOR_ROSYBROWN                                                          0xBC8F8FFF
#define COLOR_ROYALBLUE                                                          0x4169E1FF
#define COLOR_SADDLEBROWN                                                        0x8B4513FF
#define COLOR_SALMON                                                             0xFA8072FF
#define COLOR_SANDYBROWN                                                         0xF4A460FF
#define COLOR_SEAGREEN                                                           0x2E8B57FF
#define COLOR_SEASHELL                                                           0xFFF5EEFF
#define COLOR_SIENNA                                                             0xA0522DFF
#define COLOR_SILVER                                                             0xC0C0C0FF
#define COLOR_SKYBLUE                                                            0x87CEEBFF
#define COLOR_SLATEBLUE                                                          0x6A5ACDFF
#define COLOR_SLATEGRAY                                                          0x708090FF
#define COLOR_SNOW                                                               0xFFFAFAFF
#define COLOR_SPRINGGREEN                                                        0x00FF7FFF
#define COLOR_STEELBLUE                                                          0x4682B4FF
#define COLOR_TAN                                                                0xD2B48CFF
#define COLOR_TEAL                                                               0x008080FF
#define COLOR_THISTLE                                                            0xD8BFD8FF
#define COLOR_TOMATO                                                             0xFF6347FF
#define COLOR_TRANSPARENT                                                        0xFFFFFF00
#define COLOR_TURQUOISE                                                          0x40E0D0FF
#define COLOR_VIOLET                                                             0xEE82EEFF
#define COLOR_WHEAT                                                              0xF5DEB3FF
#define COLOR_WHITE                                                              0xFFFFFFFF
#define COLOR_WINDOWTEXT                                                         0x000000FF
#define COLOR_YELLOW                                                             0xFFFF00FF
#define COLOR_YELLOWGREEN                                                        0x9ACD32FF
#define STEALTH_ORANGE                                                           0xFF880000
#define STEALTH_OLIVE                                                            0x66660000
#define STEALTH_GREEN                                                            0x33DD1100
#define STEALTH_PINK                                                             0xFF22EE00
#define STEALTH_BLUE                                                             0x0077BB00
// DAMAGES //
#define BODY_CHEST 1337
#define BODY_CROTCH 1338
#define BODY_LEFT_ARM 1339
#define BODY_RIGHT_ARM 1340
#define BODY_LEFT_LEG 1341
#define BODY_RIGHT_LEG 1342
#define BODY_HEAD 1343
/*
#define WEAPON_BODY_PART_CHEST 3
#define WEAPON_BODY_PART_CROTCH 4
#define WEAPON_BODY_PART_LEFT_ARM 5
#define WEAPON_BODY_PART_RIGHT_ARM 6
#define WEAPON_BODY_PART_LEFT_LEG 7
#define WEAPON_BODY_PART_RIGHT_LEG 8
#define WEAPON_BODY_PART_HEAD 9
*/
