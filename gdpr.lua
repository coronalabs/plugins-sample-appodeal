local composer = require( "composer" )
local widget = require( "widget" )
 
local scene = composer.newScene()

local backGround = display.newRect(0, 0, display.contentWidth, display.contentHeight)
backGround.x = display.contentWidth / 2
backGround.y = display.contentHeight / 2
backGround:setFillColor(1.0, 1.0, 1.0)


local logoBackGround = display.newRect(0, 0, display.contentWidth, display.contentHeight / 7)
logoBackGround.x = display.contentWidth / 2
logoBackGround.y = logoBackGround.contentHeight / 2
logoBackGround:setFillColor(1.0, 0.2, 0.2)


-- Load the background
local appodealLogo = display.newImageRect("appodeal.png", 180, 38 )
appodealLogo.x = (logoBackGround.contentWidth - appodealLogo.contentWidth)
appodealLogo.y = logoBackGround.contentHeight / 2

print(appodealLogo.x)

local headTextOptions = 
{
    text = "Personalize Your Ad Experience",     
    x = display.contentWidth / 2,
    y = (display.contentHeight - (display.contentHeight / 1.25)),
    width = display.contentWidth / 2,
    font = native.systemFontBold,   
    fontSize = 18,
    align = "center"
}
 
local headText = display.newText(headTextOptions)
headText:setFillColor( 0, 0, 0 )

local textOptions = 
{
    text = system.getInfo("appName") .. " personalizes your advertising experience using Appodeal. Appodeal and its partners may collect and process personal data such as device identifiers, location data, and other demographic and interest data to provide advertising experience tailored to you. By consenting to this improved ad experience, you'll see ads that Appodeal and its partners believe are more relevant to you.",     
    x = display.contentWidth / 2,
    y = (display.contentHeight - (display.contentHeight / 1.6)),
    width = display.contentWidth - 20,
    font = native.systemFont,   
    fontSize = 12,
    align = "left"
}
 
local text = display.newText(textOptions)
text:setFillColor( 0, 0, 0 )

local function handleButtonLearnMore( event )
 
    if ( "ended" == event.phase ) then
        system.openURL( "https://www.appodeal.com/privacy-policy" )
    end
end

local buttonLearnMore = widget.newButton(
    {
        width = 80,
        height = 20,
        x = display.contentWidth / 2,
        y = (display.contentHeight - (display.contentHeight / 2)),
        label = "Learn more",
        fontSize = 12,
        shape = "rect",
        cornerRadius = 2,
        labelColor = { default={ 1.0, 0.2, 0.2 }, over={ 1.0, 0.2, 0.2 } },
        onEvent = handleButtonLearnMore
    }
)

local textOptions2 = 
{
    text = "By agreeing, you confirm that you are over the age of 16 and would like a personalized ad experience.",     
    x = display.contentWidth / 2,
    y = (display.contentHeight - (display.contentHeight / 2.3)),
    width = display.contentWidth - 20,
    font = native.systemFont,   
    fontSize = 12,
    align = "left"
}
 
local text2 = display.newText(textOptions2)
text2:setFillColor( 0, 0, 0 )

local function handleButtonEventYes( event )
    if ( "ended" == event.phase ) then
        local appPreferences = { result_gdpr = true }
        system.setPreferences("app", appPreferences)
        composer.gotoScene("gdpr_yes")
    end
end
 
local buttonYes = widget.newButton(
    {
        width = display.contentWidth - 20,
        height = 40,
        x = display.contentWidth / 2,
        y = (display.contentHeight - (display.contentHeight / 3.5)),
        label = "YES, I AGREE",
        shape = "roundedRect",
        cornerRadius = 2,
        fillColor = { default={ 1.0, 0.2, 0.2 }, over={ 1.0, 0.2, 0.2 } },
        labelColor = { default={ 1.0, 1.0, 1.0 }, over={ 1.0, 1.0, 1.0 } },
        onEvent = handleButtonEventYes
    }
)

local function handleButtonEventNo( event )
    if ( "ended" == event.phase ) then
        local appPreferences = { result_gdpr = false }
        system.setPreferences("app", appPreferences)
        composer.gotoScene("gdpr_no")
    end
end
 
local buttonNo = widget.newButton(
    {
        width = display.contentWidth - 20,
        height = 40,
        x = display.contentWidth / 2,
        y = (display.contentHeight - (display.contentHeight / 5)),
        label = "NO, THANKS",
        shape = "roundedRect",
        cornerRadius = 2,
        fillColor = { default={ 1.0, 1.0, 1.0 }, over={ 1.0, 1.0, 1.0 } },
        labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
        onEvent = handleButtonEventNo
    }
)

local textOptions3 = 
{
    text = "I understand that i will still see ads, but they may not be as relevant to my interests.",     
    x = display.contentWidth / 2,
    y = (display.contentHeight - (display.contentHeight / 8)),
    width = display.contentWidth - 20,
    font = native.systemFont,   
    fontSize = 12,
    align = "left"
}
 
local text3 = display.newText(textOptions3)
text3:setFillColor( 0, 0, 0 )

return scene