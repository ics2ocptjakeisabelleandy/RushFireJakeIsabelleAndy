-----------------------------------------------------------------------------------------
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
-- SOUNDS
-----------------------------------------------------------------------------------------

local bkgMusic = audio.loadStream("Sounds/clear.mp3")
local bkgMusicChannel = audio.play( bkgMusic, { channel=4, loops=-1 })

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local character

local heart1
local heart2
local numLives = 2

local rArrow
local lArrow
local uArrow


local motionx = 0
local SPEED = 10
local negativeSpeed = -10
local LINEAR_VELOCITY = -200
local GRAVITY = 20

local leftW
local topW
local rightW
local floor
local portal

local platform1
local platform2
local platform3
local platform4
local platform5
local platform6
local platform7
local platform8

local earth
local saturn
local pluto
local theplanet

local numberCorrect = 0

local rect
local instructions
local instructions2
local instructions3
local instructions4
local instructions5
local instructions6

-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
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

local function Unmute(touch)
    if (touch.phase == "ended") then
        -- play the sound
        audio.resume(bkgMusic)
        -- set the boolean variable to be false (sound is now muted)
        soundOn = true
        -- hide the mute button
        muteButton.isVisible = true
        -- make the unmute button visible
        unmuteButton.isVisible = false
    end
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
    character.x = display.contentWidth*1/2
    character.y = display.contentHeight*0.1/3
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

local function MakeObjectCharactersVisible()
    earth.isVisible = true
    pluto.isVisible = true
    saturn.isVisible = true
end

local function MakeHeartsVisible()
    heart1.isVisible = true
    heart2.isVisible = true
end

local function YouLoseTansition()
    composer.gotoScene( "you_lose" )
end

local function YouWinTransition()
    composer.gotoScene( "you_win" )
end

local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    if ( event.phase == "began" ) then

        if (event.target.myName == "floor") then

            -- remove runtime listeners that move the character
            RemoveArrowEventListeners()
            RemoveRuntimeListeners()

            -- remove the character from the display
            display.remove(character)

            -- decrease number of lives
            numLives = numLives - 1

            if (numLives == 1) then
                -- update hearts
                heart1.isVisible = true
                heart2.isVisible = false
                timer.performWithDelay(200, ReplaceCharacter)

            elseif (numLives == 0) then
                -- update hearts
                heart1.isVisible = false
                heart2.isVisible = false
                timer.performWithDelay(200, YouLoseTansition)
            end
        end

        if  (event.target.myName == "earth") or
            (event.target.myName == "pluto") or
            (event.target.myName == "saturn") then

            -- get the ball that the user hit
            theplanet = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            numberCorrect = numberCorrect + 1
        end

        if (event.target.myName == "portal") then
            -- check to see if user has answered 3 questions
            if (numberCorrect == 3) then
                timer.performWithDelay(300, YouWinTransition)
            end
        end
    end
end


local function AddCollisionListeners()
    -- if character collides with earth, onCollision will be called
    earth.collision = onCollision
    earth:addEventListener("collision")
    saturn.collision = onCollision
    saturn:addEventListener("collision")
    pluto.collision = onCollision
    pluto:addEventListener("collision")

    -- if character collides with floor, onCollision will be called
    floor.collision = onCollision
    floor:addEventListener( "collision" )

    portal.collision = onCollision
    portal:addEventListener( "collision" )
end

local function RemoveCollisionListeners()
    earth:removeEventListener("collision")
    saturn:removeEventListener("collision")
    pluto:removeEventListener("collision")

    floor:removeEventListener("collision")

    portal:removeEventListener("collision")
end

local function AddPhysicsBodies()
    -- add to physics engine
    physics.addBody(leftW, "static", {friction=0.5, bounce=0.3})
    physics.addBody(rightW, "static", {friction=0.5, bounce=0.3})
    physics.addBody(topW, "static", {friction=0.5, bounce=0.3})
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2})

    physics.addBody(platform1, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform2, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform3, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform4, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform5, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform6, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform7, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(platform8, "static", {density=1, friction=0.3, bounce=0.2})

    physics.addBody(earth, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(saturn, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(pluto, "static", {density=1, friction=0.3, bounce=0.2})

    physics.addBody(portal, "static", {density=1, friction=0.3, bounce=0.2})
end

local function RemovePhysicsBodies()
    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)
    physics.removeBody(floor)

    physics.removeBody(platform1)
    physics.removeBody(platform2)
    physics.removeBody(platform3)
    physics.removeBody(platform4)
    physics.removeBody(platform5)
    physics.removeBody(platform6)
    physics.removeBody(platform7)
    physics.removeBody(platform8)
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeGame()

    -- make character visible again
    character.isVisible = true

    if (numberCorrect > 0) then
        if (theplanet ~= nil) and (theplanet.isBodyActive == true) then
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
    bkg_image = display.newImageRect("Images/level1backgroundIsabelleLC.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )

    -- make a cover rectangle to have rhe background fully blocked where the question is
    cover = display.newRoundedRect(150, 650, display.contentWidth/2.3, display.contentHeight/2.2, 50)
    -- set the cover color
    cover:setFillColor(96/255, 96/255, 96/255)

    sceneGroup:insert(cover)

    instructions = display.newText("The evil Greg and Betmorax", display.contentWidth/6, display.contentHeight/1.5, nil, 27)
    instructions2 = display.newText("scattered our planets!", display.contentWidth/6.4, display.contentHeight/1.425, nil, 27)
    instructions3 = display.newText("Can you collect them?", display.contentWidth/6.3, display.contentHeight/1.35, nil, 27)
    instructions4 = display.newText("For this level ONLY", display.contentWidth/6.3, display.contentHeight/1.175, nil, 27)
    instructions5 = display.newText("you only lose a life", display.contentWidth/6.3, display.contentHeight/1.125, nil, 27)
    instructions6 = display.newText("if you fall off the screen!", display.contentWidth/6.3, display.contentHeight/1.05, nil, 27)

    sceneGroup:insert(instructions)
    sceneGroup:insert(instructions2)
    sceneGroup:insert(instructions3)
    sceneGroup:insert(instructions4)
    sceneGroup:insert(instructions5)
    sceneGroup:insert(instructions6)

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

    floor = display.newLine (0, 0, display.contentWidth, 0)
    floor.y = display.contentCenterY * 2
    floor.isVisible = true
    floor.myName = "floor"

    -- insert the wall into scene group
    sceneGroup:insert(floor)

    leftW = display.newLine (0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- insert the wall into scene group
    sceneGroup:insert(leftW)

    rightW = display.newLine (0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- insert the wall into scene group
    sceneGroup:insert(rightW)

    platform1 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform1.x = display.contentWidth/8
    platform1.y = display.contentHeight/3
    platform1.myName = "platform1"

    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform1)

    platform2 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform2.x = display.contentWidth/1.25
    platform2.y = display.contentHeight/5
    platform2.myName = "platform2"

    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform2)

    platform3 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform3.x = display.contentWidth/2
    platform3.y = display.contentHeight/3
    platform3.myName = "platform3"

    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform3)

    platform4 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform4.x = display.contentWidth/2
    platform4.y = display.contentHeight/1.75
    platform4.myName = "platform4"

    sceneGroup:insert(platform4)

    platform5 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform5.x = display.contentWidth/1.2
    platform5.y = display.contentHeight/2
    platform5.myName = "platform5"

    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform5)

    platform6 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform6.x = display.contentWidth/2
    platform6.y = display.contentHeight/1.1
    platform6.myName = "platform6"

    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform6)

    platform7 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform7.x = display.contentWidth/7
    platform7.y = display.contentHeight/2
    platform7.myName = "platform7"

    sceneGroup:insert(platform7)

    platform8 = display.newImage("Images/PlatformIsabelleLC.png", 200, 100)
    platform8.x = display.contentWidth/1.2
    platform8.y = display.contentHeight/1.4
    platform8.myName = "platform8"

    sceneGroup:insert(platform8)

    -- Insert the hearts
    heart1 = display.newImageRect("Images/Lives.png", 80, 80)
    heart1.x = 50
    heart1.y = 50
    heart1.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart1 )

    heart2 = display.newImageRect("Images/Lives.png", 80, 80)
    heart2.x = 140
    heart2.y = 50
    heart2.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart2 )


    -- insert platform1 into sceneGroup
    sceneGroup:insert(platform4)

    earth = display.newImage("Images/EarthIsabelleLC.png", 100, 100)
    earth.x = display.contentWidth/1.2
    earth.y = display.contentHeight/1.6
    earth.width = 100
    earth.height = 100
    earth.myName = "earth"

    -- insert earth into sceneGroup
    sceneGroup:insert(earth)

    saturn = display.newImage("Images/SaturnIsabelleLC.png", 100, 100)
    saturn.x = display.contentWidth/1.25
    saturn.y = display.contentHeight/8.5
    saturn.width = 100
    saturn.height = 100
    saturn.myName = "saturn"

    -- insert earth into sceneGroup
    sceneGroup:insert(saturn)

    pluto = display.newImage("Images/PlutoIsabelleLC.png", 100, 100)
    pluto.x = display.contentWidth/6.8
    pluto.y = display.contentHeight/2.4
    pluto.width = 100
    pluto.height = 100
    pluto.myName = "pluto"

    -- insert earth into sceneGroup
    sceneGroup:insert(pluto)

    -- insert the portal
    portal = display.newImage("Images/Portal.png", 100, 100)
    portal.x = display.contentWidth/2
    portal.y = display.contentHeight/1.3
    portal.width = 150
    portal.height = 150
    portal.myName = "portal"

    sceneGroup:insert(portal)
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

        if (soundOn == true) then
            bkgMusicChannel = audio.play(bkgMusic)
        end

        numLives = 2
        numberCorrect = 0

        --create the character, add physics bodies and runtime listeners
        ReplaceCharacter()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- make planets visible
        MakeObjectCharactersVisible()

        -- make lives visible
        MakeHeartsVisible()
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

        bkgMusic = audio.stop()
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
