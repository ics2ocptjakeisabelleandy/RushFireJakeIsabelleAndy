-----------------------------------------------------------------------------------------
--
-- level2_question.lua
-- Date: May 23, 2019
-- Description: Asks a question in level 2. If user gets the question right, then the user
-- continues the level and his 'questionsAnswered' goes up by one. if the user gets the
-- answer wrong, they lose a life.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- the local variables for this scene
local questionText
local correctAnswerText
local wrongAnswerText1
local wrongAnswerText2
local wrongAnswerText3


local answerPosition = 1
local bkg
local cover

local userAnswer
local textTouched = false

local X1 = display.contentWidth*1/7
local X2 = display.contentWidth*4.5/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7

local randomOperator


-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene

local function Back2Level2() 
    composer.hideOverlay("crossFade", 400 )
    ResumeLevel2()
end 

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerAnswer(touch)

    if (touch.phase == "ended") then
    print ("***Inside TouchListenerAnswer")

        questionsAnsweredRight = questionsAnsweredRight + 1

        rightAnswer = true

        timer.performWithDelay(100, Back2Level2)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer1(touch)
 
    if (touch.phase == "ended") then
        numLivesLevel2 = numLivesLevel2 - 1
        timer.performWithDelay(100, Back2Level2)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)

    if (touch.phase == "ended") then
        numLivesLevel2 = numLivesLevel2 - 1
        timer.performWithDelay(100, Back2Level2)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer3(touch)

    
    if (touch.phase == "ended") then
        numLivesLevel2 = numLivesLevel2 - 1
        timer.performWithDelay(100, Back2Level2)
    end 
end


-- add the event listeners
local function AddTouchListeners()
    correctAnswerText:addEventListener("touch", TouchListenerAnswer)
    wrongAnswerText1:addEventListener("touch", TouchListenerWrongAnswer1)
    wrongAnswerText2:addEventListener("touch", TouchListenerWrongAnswer2)
    wrongAnswerText3:addEventListener("touch", TouchListenerWrongAnswer3)
end

-- remove event listeners
local function RemoveTouchListeners()
    correctAnswerText:removeEventListener("touch", TouchListenerAnswer)
    wrongAnswerText1:removeEventListener("touch", TouchListenerWrongAnswer1)
    wrongAnswerText2:removeEventListener("touch", TouchListenerWrongAnswer2)
    wrongAnswerText3:removeEventListener("touch", TouchListenerWrongAnswer3)
end

local function AskQuestion()
    -- generate a random number between 1 and 2
    -- *** declare this variable above
    randomOperator = math.random(1,20)

    if (randomOperator == 1) then

        -- correct answer
        correctAnswerText.text = "Baseball"

        -- wrong answers
        wrongAnswerText1.text = "Basketball"
        wrongAnswerText2.text = "Wrestling"
        wrongAnswerText3.text = "Soccer"

        questionText.text = "What sport uses a bat?"

    
    elseif (randomOperator == 2) then

        -- correct answer
        correctAnswerText.text = "Running long"

        -- wrong answers
        wrongAnswerText1.text = "Jumping high"
        wrongAnswerText2.text = "Running fast"
        wrongAnswerText3.text = "Throwing far"

        questionText.text = "What is cardio?"


    elseif (randomOperator == 3) then

        -- correct answer
        correctAnswerText.text = "Caffeine"

        -- wrong answers
        wrongAnswerText1.text = "Juice"
        wrongAnswerText2.text = "Smoothie"
        wrongAnswerText3.text = "Eater"

        questionText.text = " What drink is bad for your health? "

    elseif (randomOperator == 4) then

        -- correct answer
        correctAnswerText.text = "Cooking"

        -- wrong answers
        wrongAnswerText1.text = "Fortnite skills"
        wrongAnswerText2.text = "Shoveling"
        wrongAnswerText3.text = "Sports"

        questionText.text = "What is a living skill?"


        elseif (randomOperator == 5) then

        -- correct answer
        correctAnswerText.text = "Swallow mouthwash"

        -- wrong answers
        wrongAnswerText1.text = "Brush your teeth"
        wrongAnswerText2.text = "Brush your gums"
        wrongAnswerText3.text = "Floss"

        questionText.text = "What shouldn't you do while cleaning your teeth?"

        elseif (randomOperator == 6) then

        -- correct answer
        correctAnswerText.text = "18"

        -- wrong answers
        wrongAnswerText1.text = "16"
        wrongAnswerText2.text = "12"
        wrongAnswerText3.text = "14"

        questionText.text = "At what age can you buy alcohol?"

        elseif (randomOperator == 7) then

        -- correct answer
        correctAnswerText.text = "Extreme mood swings"

        -- wrong answers
        wrongAnswerText1.text = "Nothing happens"
        wrongAnswerText2.text = "Faster reactions"
        wrongAnswerText3.text = "Hanging out with friends"

        questionText.text = "What are signs of addiction?"


        elseif (randomOperator == 8) then

        -- correct answer
        correctAnswerText.text = "Ice hockey"

        -- wrong answers
        wrongAnswerText1.text = "Volleyball"
        wrongAnswerText2.text = "Basketball"
        wrongAnswerText3.text = "Tag"

        questionText.text = "What sport do you HAVE to wear a helmet?"


        elseif (randomOperator == 9) then

        -- correct answer
        correctAnswerText.text = "Fencing"

        -- wrong answers
        wrongAnswerText1.text = "Ice Hockey"
        wrongAnswerText2.text = "Tennis"
        wrongAnswerText3.text = "Surfing"

        questionText.text = " Which sport is a olympic sport? "


        elseif (randomOperator == 10) then

        -- correct answer
        correctAnswerText.text = "Sailing"

        -- wrong answers
        wrongAnswerText1.text =  "Tag"
        wrongAnswerText2.text = "Basketball"
        wrongAnswerText3.text = "Soccer"

        questionText.text = "What activity can you only allowed do outside?"


        elseif (randomOperator == 11) then

        -- correct answer
        correctAnswerText.text = "Badminton"

        -- wrong answers
        wrongAnswerText1.text = "Rugby"
        wrongAnswerText2.text = "Football"
        wrongAnswerText3.text = "Dodgeball"

        questionText.text = "What sport uses a raquet?"


        elseif (randomOperator == 12) then

        -- correct answer
        correctAnswerText.text = "Above"

        -- wrong answers
        wrongAnswerText1.text = "Around"
        wrongAnswerText2.text = "Under"
        wrongAnswerText3.text = "Through"

        questionText.text = "What is another word for moving forward?"


        elseif (randomOperator == 13) then

        -- correct answer
        correctAnswerText.text = "Wrestling"

        -- wrong answers
        wrongAnswerText1.text = "Volleyball"
        wrongAnswerText2.text = "Basketball"
        wrongAnswerText3.text = "Soccer"

        questionText.text = "Which sport is not a team sport?"


        elseif (randomOperator == 14) then

        -- correct answer
        correctAnswerText.text = "Kicking"

        -- wrong answers
        wrongAnswerText1.text = "Punching"
        wrongAnswerText2.text = "Climbing"
        wrongAnswerText3.text = "Throwing"

        questionText.text = "What action do you do in soccer?"


        elseif (randomOperator == 15) then

        -- correct answer
        correctAnswerText.text = "8 hours "

        -- wrong answers
        wrongAnswerText1.text = "4 hours"
        wrongAnswerText2.text = "10 hours"
        wrongAnswerText3.text = "5 hours"

        questionText.text = "How long should you sleep every night?"

        elseif (randomOperator == 16) then

        -- correct answer
        correctAnswerText.text = "Protein"

        -- wrong answers
        wrongAnswerText1.text = "Vegetables"
        wrongAnswerText2.text = "Grain"
        wrongAnswerText3.text = "Dairy"

        questionText.text = "What food group does beef go into?"



        elseif (randomOperator == 17) then

        -- correct answer
        correctAnswerText.text = "Dark chocolate "

        -- wrong answers
        wrongAnswerText1.text = "Chocolate banana"
        wrongAnswerText2.text = "White chocolate"
        wrongAnswerText3.text = "Milk chocolate"

        questionText.text = "What is the healthiest Item here?"


        elseif (randomOperator == 18) then

        -- correct answer
        correctAnswerText.text = "2 liters "

        -- wrong answers
        wrongAnswerText1.text = "10 Oz"
        wrongAnswerText2.text = "10 liters"
        wrongAnswerText3.text = "400 milliliters"

        questionText.text = "How much water should you drink a day?"



        elseif (randomOperator == 19) then

        -- correct answer
        correctAnswerText.text = "Orange"

        -- wrong answers
        wrongAnswerText1.text = "Carrots"
        wrongAnswerText2.text = "Celary"
        wrongAnswerText3.text = "Beef"

        questionText.text = "Which item go is in the same food\ngroup as apples?"


        elseif (randomOperator == 20) then

        -- correct answer
        correctAnswerText.text = "Dairy"

        -- wrong answers
        wrongAnswerText1.text = "Fruits"
        wrongAnswerText2.text = "Protein"
        wrongAnswerText3.text = "Grain"

        questionText.text = "What food group is milk a part of?"

    end
end

local function PositionAnswers()

    --creating random start position in a cretain area
    answerPosition = math.random(1,4)

    if (answerPosition == 1) then

        correctAnswerText.x = X1
        correctAnswerText.y = Y1
        
        wrongAnswerText1.x = X2
        wrongAnswerText1.y = Y1
        
        wrongAnswerText2.x = X1
        wrongAnswerText2.y = Y2

        wrongAnswerText3.x = X2
        wrongAnswerText3.y = Y2

        
    elseif (answerPosition == 2) then

        correctAnswerText.x = X2
        correctAnswerText.y = Y1
            
        wrongAnswerText1.x = X1
        wrongAnswerText1.y = Y2
            
        wrongAnswerText2.x = X2
        wrongAnswerText2.y = Y2

        wrongAnswerText3.x = X1
        wrongAnswerText3.y = Y1


    elseif (answerPosition == 3) then

        correctAnswerText.x = X1
        correctAnswerText.y = Y2
            
        wrongAnswerText1.x = X2
        wrongAnswerText1.y = Y2
            
        wrongAnswerText2.x = X1
        wrongAnswerText2.y = Y1

        wrongAnswerText3.x = X2
        wrongAnswerText3.y = Y1

    elseif ( answerPosition == 4) then

        correctAnswerText.x = X2
        correctAnswerText.y = Y2

        wrongAnswerText1.x = X1
        wrongAnswerText1.y = Y1
            
        wrongAnswerText2.x = X2
        wrongAnswerText2.y = Y1

        wrongAnswerText3.x = X1
        wrongAnswerText3.y = Y2

    end
end

--------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
--------------------------------------------------------------------------------------

-- the function called when the screen doesn't exist
function scene:create(event)

    -- creat a group tht associates objects with the scene
    local sceneGroup = self.view

    ----------------------------------------------------------------------------------
    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.5)

    ----------------------------------------------------------------------------------
    -- make a cover rectangle to have rhe background fully blocked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*1.5, display.contentHeight*0.95, 50)
    -- set the cover color
    cover:setFillColor(102/255, 0/255, 0/255)

    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 70)
    questionText:scale(0.7,0.7)


    -- create the answer text object & wrong answer text objects
    correctAnswerText = display.newText("", X1, Y2, Arial, 60)
    correctAnswerText.anchorX = 0
    correctAnswerText:scale(0.7,0.7)

    wrongAnswerText1 = display.newText("", X2, Y2, Arial, 60)
    wrongAnswerText1.anchorX = 0
    wrongAnswerText1:scale(0.7,0.7)

    wrongAnswerText2 = display.newText("", X1, Y1, Arial, 60)
    wrongAnswerText2.anchorX = 0
    wrongAnswerText2:scale(0.7,0.7)

    wrongAnswerText3 = display.newText("", X2, Y1, Arial, 60)
    wrongAnswerText3.anchorX = 0
    wrongAnswerText3:scale(0.7,0.7)

    ----------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert(correctAnswerText)
    sceneGroup:insert(wrongAnswerText1)
    sceneGroup:insert(wrongAnswerText2)
    sceneGroup:insert(wrongAnswerText3)

end

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

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        AskQuestion()
        PositionAnswers()
        AddTouchListeners()
    end

end --function scene:show( event )

----------------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    ------------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        --parent:resumeGame()
    ------------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveTouchListeners()
    end

end --function scene:hide( event )

----------------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    ------------------------------------------------------------------------------------------

    -- Called prior to the removal of scene's view ("sceneGroup"). 
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

----------------------------------------------------------------------------------------------
-- EVENT LISTENERS
----------------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



-----------------------------------------------------------------------------------------

return scene