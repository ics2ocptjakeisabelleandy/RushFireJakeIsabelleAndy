-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Isabelle LC
-- Date: May 2, 2019
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

soundOn = true

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local LevelSelectScreenButton
local LevelSelectScreenButton2
local LevelSelectScreenButton3

local muteButton
local unmuteButton

local backButton
-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------

local bkgMusic = audio.loadStream("Sounds/clear.mp3")
local bkgMusicChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function Mute(touch)
    if (touch.phase == "ended") then
        -- pause the sound
        audio.pause(bkgMusic)
        -- set the boolean variable to be false (sound is now muted)
        soundOn = false
        -- hide the mute button
        muteButton.isVisible = false
        -- make the unmute button visible
        unmuteButton.isVisible = true
    end
end

-----------------------------------------------------------------------------------------

local function Unmute(touch)
    if (touch.phase == "ended") then
        -- play the sound
        audio.play(bkgMusic)
        -- set the boolean variable to be false (sound is now muted)
        soundOn = true
        -- hide the mute button
        muteButton.isVisible = true
        -- make the unmute button visible
        unmuteButton.isVisible = false
    end
end

-----------------------------------------------------------------------------------------


-- Creating Transition Function to Credits Page
local function Level3ScreenTransition( )       
    composer.gotoScene( "level3_screen", {effect = "zoomInOutFade", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition()
    composer.gotoScene("Level1_screen", {effect = "zoomInOutFade", time = 500})
end    

-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO INSTRUCTIONS SCREEN 

-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function Level2ScreenTransition( )       
    composer.gotoScene( "level2_screen", {effect = "zoomInOutFade", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Create transition back to Main_Menu
local function BackTransition()
    composer.gotoScene( "main_menu", {effect = "fromRight", time = 500})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/LevelSelectScreenAndyDF.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*1/8,
        y = display.contentHeight*15/16,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressed.png",
        overFile = "Images/BackButtonPressed.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    backButton:scale(0.5, 0.5)

    ----------------------------------------------------------------------------------------   

    -- Creating Play Button
    LevelSelectScreenButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/8,
            y = display.contentHeight*6/8,

            -- Insert the images here
            defaultFile = "Images/LevelSelectScreenButtonAndyDF.png",
            overFile = "Images/LevelSelectScreenButtonPressedAndyDF.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    LevelSelectScreenButton:scale(0.5, 0.5)

    -----------------------------------------------------------------------------------------

    -- Creating Level 3 Button
    LevelSelectScreenButton3 = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/8,
            y = display.contentHeight*2/8,

            -- Insert the images here
            defaultFile = "Images/LevelSelectScreenButton3AndyDF.png",
            overFile = "Images/LevelSelectScreenButton3PressedAndyDF.png",

            -- When the button is released, call the Credits transition function
            onRelease = Level3ScreenTransition
        } ) 

    LevelSelectScreenButton3:scale(0.5, 0.5)
    
    -----------------------------------------------------------------------------------------

    -- Creating Instructions Button
    LevelSelectScreenButton2 = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/8,
            y = display.contentHeight*4/8,

            -- Insert the images here
            defaultFile = "Images/LevelSelectScreenButton2AndyDF.png",
            overFile = "Images/LevelSelectScreenButton2PressedAndyDF.png",

            -- When the button is released, call the Credits transition function
            onRelease = Level2ScreenTransition
        } ) 
    
    LevelSelectScreenButton2:scale(0.5, 0.5)
   
    -----------------------------------------------------------------------------------------

    -- creating mute button
    muteButton = display.newImageRect( "Images/MuteButton.png", 200, 200)
    muteButton.x = display.contentWidth*9/10
    muteButton.y = display.contentHeight*1.3/10
    muteButton.isVisible = true

    muteButton:scale(0.5, 0.5)

    -----------------------------------------------------------------------------------------

    -- creating mute button
    unmuteButton = display.newImageRect( "Images/UnmuteButton.png", 200, 200)
    unmuteButton.x = display.contentWidth*9/10
    unmuteButton.y = display.contentHeight*1.3/10
    unmuteButton.isVisible = true

    unmuteButton:scale(0.5, 0.5)
    -----------------------------------------------------------------------------------------
    -- Associating button widgets with this scene
    sceneGroup:insert( LevelSelectScreenButton )
    sceneGroup:insert( LevelSelectScreenButton2 )
    sceneGroup:insert( LevelSelectScreenButton3 )
    sceneGroup:insert( backButton )
    

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).   
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then       
        
        --play background music
        bkgMusicChannel = audio.play(bkgMusic, {loops= -1})
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", Unmute)
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        audio.stop(bkgMusicChannel)

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        muteButton:removeEventListener("touch", Mute)
        unmuteButton:removeEventListener("touch", Unmute)
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
