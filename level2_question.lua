-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Isabelle
-- Date: May 23, 2019
-- Description: Asks a question in level 1. If user gets the question right, then the user
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
sceneName = "level1_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- the local variables for this scene
local correctAnswerText
local wrongAnswerText1
local wrongAnswerText2
local wrongAnswerText3

local correctAnswer
local wrongAnswer1
local wrongAnswer2
local wrongAnswer3

local answerPosition = 1
local bkg
local cover

local questionsAnswered = 0

local userAnswer
local textTouched = false

local X1 = display.contentWidth*1/7
local X2 = display.contentWidth*5/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7

local questionObject
local correctAnswer
local randomOperator
local questionText

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function BackToLevel2() 
    composer.hideOverlay("crossFade", 400 )
  
    ResumeLevel2()
end 


--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerAnswer(touch)
    userAnswer = correctAnswerText.text

    if (touch.phase == "ended") then

        questionsAnswered = questionsAnswered + 1

        timer.performWithDelay(100, BackToLevel2)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer1(touch)
 
    if (touch.phase == "ended") then

        numLives = numLives - 1
        
        timer.performWithDelay(100, BackToLevel2)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)

    if (touch.phase == "ended") then

        numLives = numLives - 1

        timer.performWithDelay(100, BackToLevel2)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer3(touch)

    
    if (touch.phase == "ended") then

        numLives = numLives - 1

        timer.performWithDelay(100, BackToLevel2)
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
        correctAnswer = "baseball"

        -- wrong answers
        wrongAnswer1 = "basketball"
        wrongAnswer2 = "wrestling"
        wrongAnswer3 = "soccer"

        questionText.text = "What sport uses a bat?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3
    
    elseif (randomOperator == 2) then

        -- correct answer
        correctAnswer = "running long"

        -- wrong answers
        wrongAnswer1 = "jumping high"
        wrongAnswer2 = "running fast"
        wrongAnswer3 = "throwing far"

        questionText.text = "What is cardio?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

    elseif (randomOperator == 3) then

        -- correct answer
        correctAnswer = "beer"

        -- wrong answers
        wrongAnswer1 = "Juice"
        wrongAnswer2 = "caffeine"
        wrongAnswer3 = "water"

        questionText.text = " What drink is bad for your health? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

    elseif (randomOperator == 4) then

        -- correct answer
        correctAnswer = "cooking"

        -- wrong answers
        wrongAnswer1 = "fortnite skills"
        wrongAnswer2 = "shoveling"
        wrongAnswer3 = "sports"

        questionText.text = "What is a living skill?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 5) then

        -- correct answer
        correctAnswer = "drink mouthwash"

        -- wrong answers
        wrongAnswer1 = "Brush your teeth"
        wrongAnswer2 = "Brush your gums"
        wrongAnswer3 = "Floss"

        questionText.text = "what shouldn't you do while cleaning your teeth?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 6) then

        -- correct answer
        correctAnswer = "18"

        -- wrong answers
        wrongAnswer1 = "16"
        wrongAnswer2 = "12"
        wrongAnswer3 = "14"

        questionText.text = "what age can you buy alcohol?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 7) then

        -- correct answer
        correctAnswer = "extreme mood swings"

        -- wrong answers
        wrongAnswer1 = "nothing happens"
        wrongAnswer2 = "faster reactions"
        wrongAnswer3 = "hanging out with friends"

        questionText.text = "What are signs of addiction?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 8) then

        -- correct answer
        correctAnswer = "hockey "

        -- wrong answers
        wrongAnswer1 = "volleyball"
        wrongAnswer2 = "basketball"
        wrongAnswer3 = "Tag"

        questionText.text = "What sport do you HAVE to wear a helmet?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 9) then

        -- correct answer
        correctAnswer = "fencing"

        -- wrong answers
        wrongAnswer1 = "Hockey"
        wrongAnswer2 = "Tennis"
        wrongAnswer3 = "surfing"

        questionText.text = " Which sport is a olympic sport? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 10) then

        -- correct answer
        correctAnswer = "football"

        -- wrong answers
        wrongAnswer1 =  "hockey"
        wrongAnswer2 = "basketball"
        wrongAnswer3 = "soccer"

        questionText.text = "What sport can you only allowed do outside?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 11) then

        -- correct answer
        correctAnswer = "Badminton"

        -- wrong answers
        wrongAnswer1 = "rugby"
        wrongAnswer2 = "football"
        wrongAnswer3 = "dodgeball"

        questionText.text = "What sport uses a raquet?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 12) then

        -- correct answer
        correctAnswer = "around "

        -- wrong answers
        wrongAnswer1 = "above"
        wrongAnswer2 = "under"
        wrongAnswer3 = "through"

        questionText.text = "you need to get around a wall with a ceiling. How?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 13) then

        -- correct answer
        correctAnswer = "Track and Field"

        -- wrong answers
        wrongAnswer1 = "volleyball"
        wrongAnswer2 = "basketball"
        wrongAnswer3 = "soccer"

        questionText.text = "Which sport is not a team sport?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 14) then

        -- correct answer
        correctAnswer = "kicking"

        -- wrong answers
        wrongAnswer1 = "punching"
        wrongAnswer2 = "climbing"
        wrongAnswer3 = "Throwing"

        questionText.text = "what action do you do in soccer?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 15) then

        -- correct answer
        correctAnswer = "8 hours "

        -- wrong answers
        wrongAnswer1 = "4 hours"
        wrongAnswer2 = "10 hours"
        wrongAnswer3 = "5 hours"

        questionText.text = "How long should you sleep every night?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 16) then

        -- correct answer
        correctAnswer = "tell a teacher"

        -- wrong answers
        wrongAnswer1 = "run away"
        wrongAnswer2 = "Laugh"
        wrongAnswer3 = "Fight them"

        questionText.text = "what should you do when met with a bully?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 17) then

        -- correct answer
        correctAnswer = "dark chocolate "

        -- wrong answers
        wrongAnswer1 = "chocolate banana"
        wrongAnswer2 = "White chocolate"
        wrongAnswer3 = "Milk chocolate"

        questionText.text = "what is the healthiest Item here?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 18) then

        -- correct answer
        correctAnswer = "2 liters "

        -- wrong answers
        wrongAnswer1 = "10 Oz"
        wrongAnswer2 = "10 liters"
        wrongAnswer3 = "400 milliliters"

        questionText.text = "how much water should you drink a day?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 19) then

        -- correct answer
        correctAnswer = "Orange"

        -- wrong answers
        wrongAnswer1 = "Carrots"
        wrongAnswer2 = "celary"
        wrongAnswer3 = "beef"

        questionText.text = "which item go is in the same food group as apples?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 20) then

        -- correct answer
        correctAnswer = "dairy"

        -- wrong answers
        wrongAnswer1 = "fruits"
        wrongAnswer2 = "protein"
        wrongAnswer3 = "grain"

        questionText.text = "what food group is milk a part of?"

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3
    end
end

local function PositionAnswers()

    --creating random start position in a cretain area
    answerPosition = math.random(1,3)

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

        correctAnswerText.x = X1
        correctAnswerText.y = Y2
            
        wrongAnswerText1.x = X1
        wrongAnswerText1.y = Y1
            
        wrongAnswerText2.x = X2
        wrongAnswerText2.y = Y2

        wrongAnswerText3.x = X2
        wrongAnswerText3.y = Y1


    elseif (answerPosition == 3) then

        correctAnswerText.x = X2
        correctAnswerText.y = Y1
            
        wrongAnswerText1.x = X1
        wrongAnswerText1.y = Y2
            
        wrongAnswerText2.x = X2
        wrongAnswerText2.y = Y2

        wrongAnswerText3.x = X1
        wrongAnswerText3.y = Y1

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
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 60)
    questionText:scale(0.7,0.7)


    -- create the answer text object & wrong answer text objects
    correctAnswerText = display.newText("", X1, Y2, Arial, 40)
    correctAnswerText.anchorX = 0
    correctAnswerText:scale(0.7,0.7)

    wrongAnswerText1 = display.newText("", X2, Y2, Arial, 40)
    wrongAnswerText1.anchorX = 0
    wrongAnswerText1:scale(0.7,0.7)

    wrongAnswerText2 = display.newText("", X1, Y1, Arial, 40)
    wrongAnswerText2.anchorX = 0
    wrongAnswerText2:scale(0.7,0.7)

    wrongAnswerText3 = display.newText("", X2, Y1, Arial, 40)
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

        numLives = 2
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