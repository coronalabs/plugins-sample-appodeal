
-- Abstract: Appodeal
-- Version: 1.0
-- Sample code is MIT licensed; see https://www.coronalabs.com/links/code/license
---------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

------------------------------
-- RENDER THE SAMPLE CODE UI
------------------------------
local sampleUI = require( "sampleUI.sampleUI" )
sampleUI:newUI( { theme="darkgrey", title="Appodeal", showBuildNum=true } )

------------------------------
-- CONFIGURE STAGE
------------------------------
display.getCurrentStage():insert( sampleUI.backGroup )
local mainGroup = display.newGroup()
display.getCurrentStage():insert( sampleUI.frontGroup )

----------------------
-- BEGIN SAMPLE CODE
----------------------

-- Require libraries/plugins
local appodeal = require( "plugin.appodeal" )
local widget = require( "widget" )

-- Set app font
local appFont = sampleUI.appFont

-- Preset Appodeal app keys (replace these with your own)
-- These must be gathered within the Appodeal developer portal: https://www.appodeal.com/apps
local appKey
if ( system.getInfo("platformName") == "Android" ) then  -- Android
	appKey = "[ANDROID-APP-KEY]"
elseif ( system.getInfo("platformName") == "iPhone OS" ) then  --iOS
	appKey = "[IOS-APP-KEY]"
end

-- Set local variables
local setupComplete = false
local availableAdTypes = {
	{ adUnitType="banner", label="Banner", xPos=103, yPos=110 },
	{ adUnitType="interstitial", label="Interstitial", xPos=103, yPos=150 },
	{ adUnitType="video", label="Video", xPos=250, yPos=110 },
	{ adUnitType="rewardedVideo", label="Rewarded Video", xPos=250, yPos=150 }
}
local currentAdType = 1
local showButton

-- Create asset image sheet
local assets = graphics.newImageSheet( "assets.png",
	{
		frames = {
			{ x=0, y=0, width=35, height=35 },
			{ x=0, y=35, width=35, height=35 },
		},
		sheetContentWidth=35, sheetContentHeight=70
	}
)


-- Function to prompt/alert user for setup
local function checkSetup()

	if ( system.getInfo( "environment" ) ~= "device" ) then return end

	if ( tostring(appKey) == "[ANDROID-APP-KEY]" or tostring(appKey) == "[IOS-APP-KEY]" ) then
		local alert = native.showAlert( "Important", 'Confirm that you have specified your unique Appodeal app keys within "main.lua" on lines 37 and 39. These must be gathered within the Appodeal developer portal.', { "OK", "appodeal.com" },
			function( event )
				if ( event.action == "clicked" and event.index == 2 ) then
					system.openURL( "https://www.appodeal.com/apps/" )
				end
			end )
	else
		setupComplete = true
	end
end


-- Ad listener function
local function adListener( event )

	-- Exit function if user hasn't set up testing parameters
	if ( setupComplete == false ) then return end
	
	-- Successful initialization of the Appodeal plugin
	if ( event.phase == "init" ) then
		print( "Appodeal event: initialization successful" )
		showButton:setEnabled( true )
		showButton.alpha = 1

	-- An ad loaded successfully
	elseif ( event.phase == "loaded" ) then
		print( "Appodeal event: " .. tostring(event.type) .. " ad loaded successfully" )

	-- The ad was displayed/played
	elseif ( event.phase == "displayed" or event.phase == "playbackBegan" ) then
		print( "Appodeal event: " .. tostring(event.type) .. " ad displayed" )

	-- The ad was closed/hidden/completed
	elseif ( event.phase == "hidden" or event.phase == "closed" or event.phase == "playbackEnded" ) then
		print( "Appodeal event: " .. tostring(event.type) .. " ad closed/hidden/completed" )

	-- The user clicked/tapped an ad
	elseif ( event.phase == "clicked" ) then
		print( "Appodeal event: " .. tostring(event.type) .. " ad clicked/tapped" )

	-- The ad failed to load
	elseif ( event.phase == "failed" ) then
		print( "Appodeal event: " .. tostring(event.type) .. " ad failed to load" )
	end
end


-- Button handler function
local function uiEvent( event )

	if ( event.target.id == "show" ) then
		print(availableAdTypes[currentAdType]["adUnitType"])
		appodeal.show( availableAdTypes[currentAdType]["adUnitType"] )

	elseif ( tonumber(event.target.id) ) then
		if ( event.target.isOn == true ) then
			currentAdType = event.target.id
		end
	end
	return true
end

-- Create radio buttons/labels
for i = 1,#availableAdTypes do
	local isOn = false ; if ( i == 1 ) then isOn = true end
	local radioButton = widget.newSwitch(
		{
			sheet = assets,
			width = 35,
			height = 35,
			frameOn = 1,
			frameOff = 2,
			x = availableAdTypes[i]["xPos"],
			y = availableAdTypes[i]["yPos"],
			style = "radio",
			id = i,
			initialSwitchState = isOn,
			onPress = uiEvent
		})
	mainGroup:insert( radioButton )
	local label = display.newText( mainGroup, availableAdTypes[i]["label"], radioButton.x+22, radioButton.y, appFont, 16 )
	label.anchorX = 0
end

-- Create button
showButton = widget.newButton(
	{
		label = "Show Appodeal Ad",
		id = "show",
		shape = "rectangle",
		x = display.contentCenterX,
		y = 220,
		width = 298,
		height = 32,
		font = appFont,
		fontSize = 16,
		fillColor = { default={ 0.12,0.32,0.52,1 }, over={ 0.132,0.352,0.572,1 } },
		labelColor = { default={ 1,1,1,1 }, over={ 1,1,1,1 } },
		onRelease = uiEvent
	})
showButton:setEnabled( false )
showButton.alpha = 0.3
mainGroup:insert( showButton )


-- Initially alert user to set up device for testing
checkSetup()

-- Init the Appodeal plugin
appodeal.init( adListener, { appKey=appKey, testMode=false } )
