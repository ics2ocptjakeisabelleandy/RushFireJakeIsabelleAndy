
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
sceneName = "level3_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

numLivesLevel3 = 3
-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local health1
local health2
local health3


local rArrow
local lArrow
local uArrow

local character
local zombie    
local zombie2
local greg
local theEnemy

local collidedWithGreg = false
local collidedWithZombie = false
local collidedWithZombie2 = false


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
---local Moon
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
    composer.gotoScene( "you_win")
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
    character.y = 100
    character.width = 75
    character.height = 100
    character.myName = "Sam"
    print ("***Inside ReplaceCharacter")

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

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
local function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)


    print ("***x2+w2 = " .. (x2 + w2) .. " should be > x1 = " .. x1)
    print ("***x1+w1 = " .. (x1 + w1) .. " should be > x2 = " .. x2)
    print ("***y2+h2 = " .. (y2 + h2) .. " should be > y1 = " .. y1)
    print ("***y1+h1 = " .. (y1 + h1) .. " should be > y2 = " .. y2)
    

    return  x1 < x2+w2 and
            x2 < x1+w1 and
            y1 < y2+h2 and
            y2 > y1+h1
end

local function UpdateHealth()
    if (numLivesLevel3 == 2 ) then 
        health3.isVisible = false
        health2.isVisible = true
        health1.isVisible = true
        

    elseif (numLivesLevel3 == 1) then

        health1.isVisible = true
        health2.isVisible = false
        health3.isVisible = false
         

    elseif (numLivesLevel3 == 0 ) then
        timer.performWithDelay(200, YouLoseTransition)
    end
end

local function onCollision( self, event )
    
    if ( event.phase == "began" ) then

        print ("***Inside onCollision, collided with " .. event.target.myName)
        if  (event.target.myName == "Ground") then

            -- remove runtime listeners that move the character
            RemoveArrowEventListeners()
            RemoveRuntimeListeners()

            -- remove the character from the display
            display.remove(character)

            numLivesLevel3 = numLivesLevel3 - 1
            print ("***Collided with ground")
            UpdateHealth()
            timer.performWithDelay(1000, ReplaceCharacter)
            
        end

        if  (event.target.myName == "zombie2") or
            (event.target.myName == "zombie") or
            (event.target.myName == "greg") then

            -- check to see if the character collided with the greg
            collidedWithGreg = CheckCollision(character.x, character.y, character.width, character.height,
                greg.x, greg.y, greg.width, greg.height)
            



            -- check to see if the character collided with the zombie
            collidedWithZombie = CheckCollision(character.x, character.y, character.width, character.height,
                zombie.x, zombie.y, zombie.width, zombie.height)

            -- check to see if the character collided with the zombie2
            collidedWithZombie2 = CheckCollision(character.x, character.y, character.width, character.height,
                zombie2.x, zombie2.y, zombie2.width, zombie2.height)
            print ("***character.x = " .. character.x)
            print ("***character.y = " .. character.y)
            print ("***character.width = " .. character.width)
            print ("***character.height = " .. character.height)

            print ("***zombie2.x = " ..zombie2.x)
            print ("***zombie2.y = " .. zombie2.y)
            print ("***zombie2.width = " .. zombie2.width)
            print ("***zombie2.height = " .. zombie2.height)

            print ("***zombie.x = " ..zombie.x)
            print ("***zombie.y = " .. zombie.y)
            print ("***zombie.width = " .. zombie.width)
            print ("***zombie.height = " .. zombie.height)


            if (collidedWithGreg == true) then
                print ("***Collided with greg")
                -- get the enemy that the user hit
                theEnemy = event.target

                -- stop the character from moving
                motionx = 0

                -- make the character invisible
                character.isVisible = false
                composer.showOverlay( "level3_question", {isModal = true, effect = fade, time == 300})

                -- Increment questions answered
                questionsAnswered = questionsAnswered + 1 

            elseif (collidedWithZombie2 == true) then
                print ("***Collided with zombie2")
                -- get the enemy that the user hit
                theEnemy = event.target

                -- stop the character from moving
                motionx = 0

                -- make the character invisible
                character.isVisible = false
                composer.showOverlay( "level3_question", {isModal = true, effect = fade, time == 300})

                -- Increment questions answered
                questionsAnswered = questionsAnswered + 1 

            elseif (collidedWithZombie == true) then
                print ("***Collided with zombie")
                -- get the enemy that the user hit
                theEnemy = event.target

                -- stop the character from moving
                motionx = 0

                -- make the character invisible
                character.isVisible = false
                composer.showOverlay( "level3_question", {isModal = true, effect = fade, time == 300})

                -- Increment questions answered
                questionsAnswered = questionsAnswered + 1

            end         

        

        end
    end
end

local function MakeEnemiesVisible()
    zombie.isVisible = true
    greg.isVisible = true
    zombie2.isVisible = true
end

local function AddCollisionListeners()
    --if character collides with ground they lose a life
    Ground.collision = onCollision
    Ground:addEventListener( "collision")
    greg.collision = onCollision
    greg:addEventListener( "collision")
    zombie.collision = onCollision
    zombie:addEventListener("collision")
    zombie2.collision = onCollision
    zombie2:addEventListener("collision")

end

local function RemoveCollisionListeners()
    Ground:removeEventListener( "collision")
    zombie:removeEventListener( "collision")
    zombie2:removeEventListener( "collision")
    greg:removeEventListener( "collision")

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
    --physics.addBody(Moon, "static", {density=1, friction=0.3, bounce=0})
end

local function RemovePhysicsBodies()
    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)

    physics.removeBody(skyscraper1)
    physics.removeBody(skyscraper2)
    physics.removeBody(cloud)

    physics.removeBody(Ground)
    
    physics.removeBody(zombie)
    physics.removeBody(zombie2)
    physics.removeBody(greg)
    --physics.removeBody(Moon)
    
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeLevel3()

    -- make character visible again
    character.isVisible = true
    character.x = display.contentWidth*0.3/3
    character.y = 100
   

    UpdateHealth()

    if (questionsAnswered > 0) then
        if (theEnemy ~= nil) and (theEnemy.isBodyActive == true) then
            physics.removeBody(theEnemy)
            theEnemy.isVisible = false

            print ("***Made " .. theEnemy.myName .. " invisible")
        end
        if (questionsAnswered == 3) then
            composer.gotoScene "you_win"
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

    skyscraper1 = display.newImage("Images/skyscraper1JakeH.png", 200, 100)
    skyscraper1.x = display.contentWidth/11
    skyscraper1.y = display.contentHeight/1.35

    -- insert platform1 into sceneGroup
    sceneGroup:insert(skyscraper1)


    skyscraper2 = display.newImage("Images/skyscraper2JakeH.png", 300, 100)
    skyscraper2.x = display.contentWidth/2
    skyscraper2.y = display.contentHeight/1.35

    -- insert skyscraper2 into sceneGroup
    sceneGroup:insert(skyscraper2)

    --creating the cloud
    cloud = display.newImage("Images/SquareCloudJakeH.png", 200, 100)
    cloud.x = display.contentWidth/1.12
    cloud.y = display.contentHeight/1.4

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

   

    zombie = display.newImageRect("Images/character2.png", 125, 175)
    zombie.x = display.contentWidth/2
    zombie.y = display.contentHeight/4
    zombie.myName = "zombie"
    sceneGroup:insert(zombie)
    zombie:scale (-1,1)

    zombie2 = display.newImageRect("Images/character2.png", 125, 175)
    zombie2.x = display.contentWidth/6
    zombie2.y = display.contentHeight/1.4
   
    zombie2.y = 30
    zombie2.myName = "zombie2"
    zombie2:scale (-1,1)
    sceneGroup:insert(zombie2)
    
    greg = display.newImageRect("Images/JakeH(greg)@.png", 100, 100)
    greg.x = display.contentWidth*.85
    greg.y = 20
    greg.myName = "greg"
    sceneGroup:insert(greg)   

    --Moon = display.newImage("Images/MoonJakeH.png", 100, 100)
    --Moon.x = display.contentWidth*.85
    --Moon.y = 100
    --Moon.myName = "Moon"
    --sceneGroup:insert(Moon)
    --Moon:scale (-1,1)
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
        numLivesLevel3 = 3
        collidedWithGreg = false
        collidedWithZombie = false 
        collidedWithZombie2 = false

        ReplaceCharacter()

        MakeEnemiesVisible()

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
