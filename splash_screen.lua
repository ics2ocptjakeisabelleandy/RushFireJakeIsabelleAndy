-----------------------------------------------------------------------------------------
-- splash_screen.lua
-- Date: May 2, 2019
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

--------------------------------------------------------------------------------------------------
--GLOBAL VARIABLES
-------------------------------------------------------------------------------------------
-- scroll speed
scrollSpeed = 6

---------------------------------------------------------------------------------------
-- SOUNDS
--------------------------------------------------------------------------------------
-- Background Sound
local backgroundSound = audio.loadSound("Sounds/sound.mp3")
local backgroundSoundChannel

--------------------------------------------------------------------------------------------------
-- LOCAL VARIABLES 
-------------------------------------------------------------------------------------------


display.setStatusBar(display.HiddenStatusBar)

-------------------------------------------------------------------
--Global Variables
-------------------------------------------------------------------



-------------------------------------------------------------------
--local Variables
-------------------------------------------------------------------
local scrollspeed = 3
local CompanyLogo

-------------------------------------------------------------------
--Sounds
-------------------------------------------------------------------



-------------------------------------------------------------------
--Object creation
-------------------------------------------------------------------
CompanyLogo = display.newImageRect("Images/CompanyLogoJakeH@2x.png", 500, 500 )

--creating the company logo
CompanyLogo.x = 0 
CompanyLogo.y = display.contentHeight

--rotating the logo (and transitioning the logo)
transition.to( CompanyLogo, { rotation = CompanyLogo.rotation-360, time=2000})
transition.to(CompanyLogo, {x= 512, y=384, time=2000})






-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end
--------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    ------------------------------------------------------------------------------------------------------------
    -- OBJECT CREATION & TEXT
    ------------------------------------------------------------------------------------------------------------
    --creating the company logo
    CompanyLogo.x = 0 
    CompanyLogo.y = display.contentHeight

    

  
    

  
    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    
    sceneGroup:insert(CompanyLogo)

end -- function scene:create( event )   

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

    elseif ( phase == "did" ) then
        -- start the splash screen music
        backgroundSoundChannel = audio.play(backgroundSound)

        

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 2500, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(backgroundSoundChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


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
