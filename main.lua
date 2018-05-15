-- Appodeal Plugin sample project

local composer = require( "composer" )

--------------------------------------------------------------------------
-- set up UI
--------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )

local compliant = system.getPreference( "app", "gdpr_result", "boolean")

if compliant then
	composer.gotoScene( "mainOriginal" )
else
	composer.gotoScene ( "gdpr" )
end