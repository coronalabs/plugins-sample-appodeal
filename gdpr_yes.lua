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

local textOptions2 = 
{
    text = "Great. We hope you enjoy your personalized ad experience. ",   
    x = display.contentWidth / 2,
    y = (display.contentHeight - (display.contentHeight / 1.55)),
    width = display.contentWidth - 20,
    font = native.systemFont,   
    fontSize = 12,
    align = "left"
}
 
local text2 = display.newText(textOptions2)
text2:setFillColor( 0, 0, 0 )

local function handleButtonClose( event )
 
    if ( "ended" == event.phase ) then
        composer.gotoScene("mainOriginal")
    end
end

local buttonClose = widget.newButton(
    {
        width = 25,
        height = 25,
        x = display.contentWidth / 2,
        y = (display.contentHeight - (display.contentHeight / 6)),
        defaultFile = "close.png",
        labelColor = { default={ 1.0, 1.0, 1.0 }, over={ 1.0, 1.0, 1.0 } },
        onEvent = handleButtonClose
    }
)
 
local buttonClose = widget.newButton(
    {
        width = display.contentWidth - 20,
        height = 30,
        x = display.contentWidth / 2,
        y = (display.contentHeight - (display.contentHeight / 10)),
        label = "CLOSE",
        shape = "roundedRect",
        cornerRadius = 2,
        labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
        onEvent = handleButtonClose
    }
)

return scene