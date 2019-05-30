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

local userAnswer
local textTouched = false

local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*4/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7

local questionObject
local correctAnswer
local randomOperator
local questionsAnswered
local questionText

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function BackToLevel1() 
    composer.hideOverlay("crossFade", 400 )
  
    ResumeGame()
end 


--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerAnswer(touch)
    userAnswer = correctAnswerText.text

    if (touch.phase == "ended") then

        timer.performWithDelay(100, BackToLevel1)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer1(touch)
    userAnswer = wrongAnswerText1.text
    
    if (touch.phase == "ended") then

        numLives = numLives - 1
        
        timer.performWithDelay(100, BackToLevel1)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)
    userAnswer = wrongAnswerText2.text
    
    if (touch.phase == "ended") then

        numLives = numLives - 1

        timer.performWithDelay(100, BackToLevel1)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer3(touch)
    userAnswer = wrongAnswerText3.text
    
    if (touch.phase == "ended") then

        numLives = numLives - 1

        timer.performWithDelay(100, BackToLevel1)
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
        correctAnswer = " 8 "

        -- wrong answers
        wrongAnswer1 = " 7 "
        wrongAnswer2 = " 6 "
        wrongAnswer3 = " 9 "

        questionText.text = " How many planets are there? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3
    
    elseif (randomOperator == 2) then

        -- correct answer
        correctAnswer = " Earth "

        -- wrong answers
        wrongAnswer1 = " Mars "
        wrongAnswer2 = " Jupiter "
        wrongAnswer3 = " Neptune "

        questionText.text = " What planet has life on it? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

    elseif (randomOperator == 3) then

        -- correct answer
        correctAnswer = " Pluto "

        -- wrong answers
        wrongAnswer1 = " Mercury "
        wrongAnswer2 = " Saturn "
        wrongAnswer3 = " Neptune "

        questionText.text = " What is the smallest planet? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

    elseif (randomOperator == 4) then

        -- correct answer
        correctAnswer = " Blue, Green "

        -- wrong answers
        wrongAnswer1 = " Blue "
        wrongAnswer2 = " Purple, Green "
        wrongAnswer3 = " Red, White "

        questionText.text = " What colours are the Earth? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 5) then

        -- correct answer
        correctAnswer = " Neptune "

        -- wrong answers
        wrongAnswer1 = " Saturn "
        wrongAnswer2 = " Mercury "
        wrongAnswer3 = " Earth "

        questionText.text = " What is the coldest planet? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 6) then

        -- correct answer
        correctAnswer = " The Sun "

        -- wrong answers
        wrongAnswer1 = " Red Star "
        wrongAnswer2 = " Blue Star "
        wrongAnswer3 = " Green Star "

        questionText.text = " What is the biggest Star? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 7) then

        -- correct answer
        correctAnswer = " Earth "

        -- wrong answers
        wrongAnswer1 = " Saturn "
        wrongAnswer2 = " Pluto "
        wrongAnswer3 = " The Moon "

        questionText.text = " What planet do we live on? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 8) then

        -- correct answer
        correctAnswer = " 1 "

        -- wrong answers
        wrongAnswer1 = " 7 "
        wrongAnswer2 = " 100 "
        wrongAnswer3 = " 3 "

        questionText.text = " How much Moons does earth have? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 9) then

        -- correct answer
        correctAnswer = " Saturn "

        -- wrong answers
        wrongAnswer1 = " Jupiter "
        wrongAnswer2 = " Mercury "
        wrongAnswer3 = " Venus "

        questionText.text = " What planet has a ring? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 10) then

        -- correct answer
        correctAnswer = " Jupiter "

        -- wrong answers
        wrongAnswer1 = " Mercury "
        wrongAnswer2 = " Mars "
        wrongAnswer3 = " The Sun "

        questionText.text = " What is the gas planet? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 11) then

        -- correct answer
        correctAnswer = " 100+ "

        -- wrong answers
        wrongAnswer1 = " 1 "
        wrongAnswer2 = " 76 "
        wrongAnswer3 = " 4 "

        questionText.text = " About how many Jupiters can fit on the Sun? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 12) then

        -- correct answer
        correctAnswer = " Jupiter "

        -- wrong answers
        wrongAnswer1 = " Earth "
        wrongAnswer2 = " Uranus "
        wrongAnswer3 = " Mars "

        questionText.text = " What planet has the most storms? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 13) then

        -- correct answer
        correctAnswer = " Mercury "

        -- wrong answers
        wrongAnswer1 = " Saturn "
        wrongAnswer2 = " Pluto "
        wrongAnswer3 = " Earth "

        questionText.text = " What planet has the most violent weather? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 14) then

        -- correct answer
        correctAnswer = " Mars "

        -- wrong answers
        wrongAnswer1 = " Jupiter "
        wrongAnswer2 = " Neptune "
        wrongAnswer3 = " The moon "

        questionText.text = " What planet do we plan to live on? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 15) then

        -- correct answer
        correctAnswer = " Mars "

        -- wrong answers
        wrongAnswer1 = " Earth "
        wrongAnswer2 = " Uranus "
        wrongAnswer3 = " Pluto "

        questionText.text = " What chocolate bar is named after a planet? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 16) then

        -- correct answer
        correctAnswer = " Nothing/Silence "

        -- wrong answers
        wrongAnswer1 = " Rocket blasts "
        wrongAnswer2 = " Laughing "
        wrongAnswer3 = " Crickets "

        questionText.text = " What does space sound like? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 17) then

        -- correct answer
        correctAnswer = " Mercury "

        -- wrong answers
        wrongAnswer1 = " Jupiter "
        wrongAnswer2 = " Neptune "
        wrongAnswer3 = " Earth "

        questionText.text = " What is the hottest planet? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 18) then

        -- correct answer
        correctAnswer = " Unknown "

        -- wrong answers
        wrongAnswer1 = " 10000000000 "
        wrongAnswer2 = " 50 "
        wrongAnswer3 = " 0 "

        questionText.text = " How many stars are in space? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 19) then

        -- correct answer
        correctAnswer = " Venus "

        -- wrong answers
        wrongAnswer1 = " Mars "
        wrongAnswer2 = " Neptune "
        wrongAnswer3 = " Uranus "

        questionText.text = " One day on Earth, ie equal to a year on which planet? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3

        elseif (randomOperator == 20) then

        -- correct answer
        correctAnswer = " Mars "

        -- wrong answers
        wrongAnswer1 = " Saturn "
        wrongAnswer2 = " Venus "
        wrongAnswer3 = " Mercury "

        questionText.text = " What planet has a giant volcano on it? "

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
    cover:setFillColor(96/255, 96/255, 96/255)

    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 60)

    -- create the answer text object & wrong answer text objects
    correctAnswerText = display.newText("", X1, Y2, Arial, 40)
    correctAnswerText.anchorX = 0

    wrongAnswerText1 = display.newText("", X2, Y2, Arial, 40)
    wrongAnswerText1.anchorX = 0

    wrongAnswerText2 = display.newText("", X1, Y1, Arial, 40)
    wrongAnswerText2.anchorX = 0

    wrongAnswerText3 = display.newText("", X2, Y1, Arial, 40)
    wrongAnswerText3.anchorX = 0

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