"Resource/UI/Locator.res"
{
	"LocatorPanel"
	{
		"WrapStaticLocators"	"1"
	}

	"LocatorBG"
	{
		"ControlName"		"CTFImagePanel"
		"fieldName"		"LocatorBG"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"0"
		"wide"			"32"
		"tall"			"32"
		"visible"		"0"
		"enabled"		"1"
		"image"			"../hud/color_panel_brown"
		"teambg_2"		"../hud/color_panel_red"
		"teambg_3"		"../hud/color_panel_blu"
		"teambg_4"		"../hud/color_panel_grn"
		"teambg_5"		"../hud/color_panel_ylw"
		"scaleImage"		"1"
		"src_corner_height"		"23"				// pixels inside the image
		"src_corner_width"		"23"

		"draw_corner_width"		"5"					// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"5"
	}

	"CaptionLabel"
	{
		"ControlName"	"CExLabel"
		"fieldName"		"CaptionLabel"
		"font"			"HudFontSmall"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"2"
		"autoResize"	"1"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"	"center"
		"dulltext"		"0"
		"brighttext"	"0"
	}

	"CaptionLabelShadow"
	{
		"ControlName"	"CExLabel"
		"fieldName"		"CaptionLabelShadow"
		"font"			"HudFontSmall"
		"xpos"			"1"
		"ypos"			"1"
		"zpos"			"1"
		"autoResize"	"1"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"	"center"
		"dulltext"		"0"
		"brighttext"	"0"
		"fgcolor"		"Black"
	}
}
