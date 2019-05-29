
-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Isabelle LC
-- Date: May 2, 2019
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local health1
local health2
local health3

local numLives = 3

local rArrow
local lArrow
local uArrow

local character
local zombie    
local zombie2
local greg

local motionx = 1
local SPEED = 12.5
local negativeSpeed = -8
local LINEAR_VELOCITY = -100
local GRAVITY = 10

local leftW
local topW
local rightW

local skyscraper1
local skyscraper2

local platform4
local Ground 
local Ground2
local cloud


local questionsAnswered = 0
-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

local function MakeHealthVisible()
    health1.isVisible = true
    health2.isVisible = true
    health3.isVisible = true
end
----------------------------------
local function YouLoseTransition()
    composer.gotoScene( "you_lose")
end

local function YouWinTransition()
    composer.gotoScene( "you_lose")
end


-- when right arrow is pressed
local function right(touch)
    motionx = SPEED
    character.xScale = 1
end

-- when left arrow is pressed
local function left(touch)
    motionx = negativeSpeed
    character.xScale = -1
end

-- when up arrow is pressed
local function up(touch)
    if (character ~= nil) then
        character:setLinearVelocity(0, LINEAR_VELOCITY)
    end
end

-- move character horizontally
local function movePlayer(event)
    character.x = character.x + motionx
end

-- stop character movement when no arrow is pushed
local function stop(event)
    if (event.phase == "ended") then
        motionx = 0
    end
end

-- add arrow event listeners
local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
end

-- remove event listeners
local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
end

-- add and remove runtime listeners
local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop)
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop)
end

-- replace character
local function ReplaceCharacter()
    character = display.newImageRect("Images/character.png", 100, 150)
    character.x = display.contentWidth*0.3/3
    character.y = display.contentHeight*1/4
    character.width = 75
    character.height = 100
    character.myName = "Sam"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", {density=0, friction=0.5, bounce=0, rotation=0} )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end



local function onCollision( self, event )
    
    if ( event.phase == "began" ) then

        if  (event.target.myName == "Ground") then

            -- remove runtime listeners that move the character
            RemoveArrowEventListeners()
            RemoveRuntimeListeners()

            -- remove the character from the display
            display.remove(character)

            numLives = numLives - 1
            print ("***Collided with ground")

            if (numLives == 2 ) then 
                health3.isVisible = false
                health2.isVisible = true
                health1.isVisible = true
                timer.performWithDelay(200, ReplaceCharacter) 

            elseif (numLives == 1) then

                health1.isVisible = true
                health2.isVisible = false
                health3.isVisible = false
                timer.performWithDelay(200, ReplaceCharacter) 

            elseif (numLives == 0 ) then
                timer.performWithDelay(200, YouLoseTransition)
            end
        end


            if  (event.target.myName == "zombie2") or
            (event.target.myName == "zombie") or
            (event.target.myName == "greg") then

            -- get the ball that the user hit
            zombie = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level3_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1

        end
    end
end


local function AddCollisionListeners()
    --if character collides with ground they lose a life
    Ground.collision = onCollision
    Ground:addEventListener( "collision")
end

local function RemoveCollisionListeners()
    Ground:removeEventListener( "collision")
end


local function AddPhysicsBodies()
    -- add to physics engine
    physics.addBody(leftW, "static", {friction=0.5, bounce=0.3})
    physics.addBody(rightW, "static", {friction=0.5, bounce=0.3})
    physics.addBody(topW, "static", {friction=0.5, bounce=0.3})

    physics.addBody(skyscraper1, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(skyscraper2, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(cloud, "static", {density=1, friction=0.3, bounce=0})

    physics.addBody(Ground, "static", {density=1, friction=0.3, bounce=0})
    
    physics.addBody(zombie, "static,", {density=1, friction=0.3, bounce=0})
    physics.addBody(zombie2, "static,", {density=1, friction=0.3, bounce=0})
    physics.addBody(greg, "static,", {density=1, friction=0.3, bounce=0})
end

local function RemovePhysicsBodies()
    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)

    physics.removeBody(skyscraper1)
    physics.removeBody(skyscraper2)
    physics.removeBody(cloud)
    
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeGame()

    -- make character visible again
    character.isVisible = true

    if (questionsAnswered > 0) then
        if (theplanet~= nil) and (theplanet.isBodyActive == true) then
            physics.removeBody(theplanet)
            theplanet.isVisible = false
        end
    end
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level3ScreenJakeH.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    

   --Insert the right arrow
    rArrow = display.newImageRect("Images/arrow.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
    rArrow:toFront()
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(rArrow)

    -- Insert the up arrow
    uArrow = display.newImageRect("Images/arrow.png", 100, 50)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8.5 / 10

    uArrow:rotate(-90)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(uArrow)

    -- Insert the left arrow
    lArrow = display.newImageRect("Images/arrow.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.y = display.contentHeight * 9.5 / 10

    lArrow:rotate(180)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(lArrow)

    -- walls
    topW = display.newLine (0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- insert the wall into scene group
    sceneGroup:insert(topW)

    leftW = display.newLine (0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- insert the wall into scene group
    sceneGroup:insert(leftW)

    rightW = display.newLine (0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- insert the wall into scene group
    sceneGroup:insert(rightW)

    skyscraper1 = display.newImage("Images/skyscraper1jakeH.png", 200, 100)
    skyscraper1.x = display.contentWidth/11
    skyscraper1.y = display.contentHeight/1.35

    -- insert platform1 into sceneGroup
    sceneGroup:insert(skyscraper1)


    skyscraper2 = display.newImage("Images/skyscraper2jakeH.png", 300, 100)
    skyscraper2.x = display.contentWidth/2
    skyscraper2.y = display.contentHeight/1.35

    -- insert skyscraper2 into sceneGroup
    sceneGroup:insert(skyscraper2)

    --creating the cloud
    cloud = display.newImage("Images/SquareCloudJakeH.png", 200, 100)
    cloud.x = display.contentWidth/1.12
    cloud.y = display.contentHeight/1.75

    sceneGroup:insert(cloud)

   
    --displaying the health bars
    health1 = display.newImage("Images/HealthBarJakeH.png", 200, 100)
    health1.x = display.contentWidth/18
    health1.y = display.contentHeight/7.5
    sceneGroup:insert(health1)

    health2 = display.newImage("Images/HealthBarJakeH.png", 200, 100)
    health2.x = display.contentWidth/8
    health2.y = display.contentHeight/7.5
    sceneGroup:insert(health2)

    health3 = display.newImage("Images/HealthBarJakeH.png", 200, 100)
    health3.x = display.contentWidth/5.10
    health3.y = display.contentHeight/7.5
    sceneGroup:insert(health3)

    --displaying the ground 
    Ground = display.newImage("Images/Ground_Level3JakeH.png", 100, 200)
    Ground.x = display.contentWidth/2
    Ground.y = display.contentHeight*1.1
    Ground.isVisible = true
    Ground.myName = "Ground"
    sceneGroup:insert(Ground)


    zombie = display.newImage("Images/character2(resize)AndyDF.png", 25, 50)
    zombie.x = display.contentWidth/2
    zombie.y = display.contentHeight/4
    zombie.isVisible = true
    zombie.myName = "zombie"
    sceneGroup:insert(zombie)
    


    zombie2 = display.newImage("Images/character2(resize)AndyDF.png", 25, 50)
    zombie2.x = display.contentWidth/1.15
    zombie2.y = display.contentHeight/2.25
    zombie2.isVisible = true
    zombie2.myName = "zombie2"
    sceneGroup:insert(zombie2)
    
    greg = display.newImageRect("Images/JakeH(greg)@.png", 100, 100)
    greg.x = display.contentWidth*.9
    greg.y = 20
    greg.myName = "greg"
    sceneGroup:insert(greg)    
end --function scene:create( event )


-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY)

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        --create the character, add physics bodies and runtime listeners
        ReplaceCharacter()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- make planes visible
        
    end
end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

        RemovePhysicsBodies()
        RemoveCollisionListeners()

        physics.stop()
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()
        display.remove(character)
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
----------------------------------------------------







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
