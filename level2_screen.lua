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
sceneName = "level2_screen"

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
local numLives = 2

local rArrow
local lArrow
local uArrow

local character
local zombie1
local zombie2
local zombie3
local zombie4
local zombie5
local theZombie

local motionx = 0
local SPEED = 7
local negativeSpeed = -9
local LINEAR_VELOCITY = -100
local GRAVITY = 7

local leftW
local topW
local rightW

local questionsAnswered = 0

local ground 
-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

local function Level3ScreenTransition( )       
    composer.gotoScene( "level3_screen", {effect = "zoomInOutFade", time = 500})
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
    character.x = display.contentWidth/7
    character.y = display.contentHeight/1.2
    character.width = 75
    character.height = 100
    character.myName = "Kill_me"
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

local function MakeObjectCharactersVisible()

end

local function onCollision(self, event)
    
    if ( event.phase == "began" ) then

        if (event.target.myName == "zombie1") or
           (event.target.myName == "zombie2") or 
           (event.target.myName == "zombie3") or 
           (event.target.myName == "zombie4") or 
           (event.target.myName == "zombie5") then


            -- get the zombie that the character hit
            theZombie = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- show overlay with health question
            composer.showOverlay( "level2_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1
        end
    end
end


local function AddCollisionListeners()
    -- if character collides with earth, onCollision will be called
    zombie1.collision = onCollision
    zombie1:addEventListener( "collision" )
    zombie2.collision = onCollision
    zombie2:addEventListener( "collision" )
    zombie3.collision = onCollision
    zombie3:addEventListener( "collision" )
    zombie4.collision = onCollision
    zombie4:addEventListener( "collision" )
    zombie5.collision = onCollision
    zombie5:addEventListener( "collision" )
    wall.collision = onCollision
    wall:addEventListener( "collision" )
    wall2.collision = onCollision
    wall2:addEventListener( "collision" )
end

local function RemoveCollisionListeners()
    zombie1:removeEventListener( "collision" )
    zombie2:removeEventListener( "collision" )
    zombie3:removeEventListener( "collision" )
    zombie4:removeEventListener( "collision" )
    zombie5:removeEventListener( "collision" )
    wall:removeEventListener( "collision" )
    wall2:removeEventListener( "collision" )
end

local function AddPhysicsBodies()
    -- add the physics
    physics.addBody(ground, "static", {density=1, friction=0.5, bounce=0 })
    physics.addBody(zombie1, "static", {density=1, friction=0.5, bounce=0 })
    physics.addBody(zombie2, "static", {density=1, friction=0.5, bounce=0 })
    physics.addBody(zombie3, "static", {density=1, friction=0.5, bounce=0 })
    physics.addBody(zombie4, "static", {density=1, friction=0.5, bounce=0 })
    physics.addBody(zombie5, "static", {density=1, friction=0.5, bounce=0 })
    physics.addBody(wall, "static", {density=1, friction=0.5, bounce=0 })
    physics.addBody(wall2, "static", {density=1, friction=0.5, bounce=0 })
end

local function RemovePhysicsBodies()
    physics.removeBody(zombie1)
    physics.removeBody(zombie2)
    physics.removeBody(zombie3)
    physics.removeBody(zombie4)
    physics.removeBody(zombie5)
    physics.removeBody(wall)
    physics.removeBody(wall2) 
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeLevel2()

    -- make character visible again
    character.isVisible = true

    if (questionsAnswered > 0) then
        if (theZombie~= nil) and (theZombie.isBodyActive == true) then
            physics.removeBody(theZombie)
            theZombie.isVisible = false
        end
    end 
    if (questionsAnswered == 5) then
        timer.performWithDelay(200, level3ScreenTransition)
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
    bkg_image = display.newImageRect("Images/Level2ScreenAndyDF.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image ) 

    wall = display.newImageRect("Images/wallAndyDF.png", display.contentWidth, 100)

    -- putting the wall on the left
    wall.x = -50
    wall.y = display.contentHeight/2
    wall:rotate(90)

    -- inserting the wall into the scene group
    sceneGroup:insert( wall )

    wall2 = display.newImageRect("Images/wallAndyDF.png", display.contentWidth, 100)

    -- putting the wall on the left
    wall2.x = 1060
    wall2.y = display.contentHeight/2
    wall2:rotate(90)

    -- inserting the second wall into the scene group
    sceneGroup:insert( wall2 )

    ground = display.newImageRect("Images/ground.png", display.contentWidth, 100)

    -- putting the ground on the ground
    ground.x = display.contentWidth/2
    ground.y = display.contentHeight/1  

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

    -- insert the ground image into the scene group
    sceneGroup:insert( ground )    

    zombie1 = display.newImage("Images/character2(resize)AndyDF.png")
    zombie1.x = display.contentWidth/1.5
    zombie1.y = display.contentHeight/1.5
    zombie1.myName = "zombie1"
    zombie1:scale (0.5, 0.5)
   
    -- insert the zombie into the scene group
    sceneGroup:insert( zombie1 )

    zombie2 = display.newImage("Images/character2(resize)AndyDF.png")
    zombie2.x = display.contentWidth/1.7
    zombie2.y = display.contentHeight/1.5
    zombie2.myName = "zombie2"
    zombie2:scale (0.5, 0.5)
    
    -- insert the zombie into the scene group
    sceneGroup:insert( zombie2 )

    zombie3 = display.newImage("Images/character2(resize)AndyDF.png")
    zombie3.x = display.contentWidth/1.9
    zombie3.y = display.contentHeight/1.5
    zombie3.myName = "zombie3"
    zombie3:scale (0.5, 0.5)
   
    -- insert the zombie into the scene group
    sceneGroup:insert( zombie3 )

    zombie4 = display.newImage("Images/character2(resize)AndyDF.png")
    zombie4.x = display.contentWidth/1.3
    zombie4.y = display.contentHeight/1.5
    zombie4.myName = "zombie4"
    zombie4:scale (0.5, 0.5)
    
    -- insert the zombie into the scene group
    sceneGroup:insert( zombie4 )

    zombie5 = display.newImage("Images/character2(resize)AndyDF.png")
    zombie5.x = display.contentWidth/1.1
    zombie5.y = display.contentHeight/1.5
    zombie5.myName = "zombie5"
    zombie5:scale (0.5, 0.5)
   
    -- insert the zombie into the scene group
    sceneGroup:insert( zombie5 )


   --Insert the right arrow
    rArrow = display.newImageRect("Images/arrow.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
   
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
        MakeObjectCharactersVisible()
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
