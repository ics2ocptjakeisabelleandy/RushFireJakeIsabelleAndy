-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Allison
-- Date: May 16, 2017
-- Description: This is the level 1 screen of the game. the charater can be dragged to move
--If character goes off a certain araea they go back to the start. When a user interactes
--with piant a trivia question will come up. they will have a limided time to click on the answer
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
local wrongAnswerText4
local wrongAnswerText5
local wrongAnswerText6

local answer
local wrongAnswer1
local wrongAnswer2
local wrongAnswer3
local wrongAnswer4
local wrongAnswer5
local wrongAnswer6

local answerPosition = 1
local cover

local userAnswer
local textTouched = false

local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*4/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5/5/7

local questionObject
local numericField
local userAnswer
local correctAnswer
local incorrectAnswer
local randomOperator

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

        BackToLevel1( )
    
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer1(touch)
    userAnswer = wrongAnswerText1.text
    
    if (touch.phase == "ended") then
        
        BackToLevel1( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)
    userAnswer = wrongAnswerText2.text
    
    if (touch.phase == "ended") then
        
        BackToLevel1( ) 
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer3(touch)
    userAnswer = wrongAnswerText3.text
    
    if (touch.phase == "ended") then
        
        BackToLevel1( )
          
    end 
end

-- add the event listeners
local function AddTextListeners()
	correctAnswerText:addEventListener("touch", TouchListenerAnswer)
	wrongAnswerText1:addEventListener("tocuh", TouchListenerWrongAnswer1)
	wrongAnswerText2:addEventListener("tocuh", TouchListenerWrongAnswer2)
	wrongAnswerText3:addEventListener("tocuh", TouchListenerWrongAnswer3)
end

-- remove event listeners
local function RemoveTextListeners()
	correctAnswerText:removeEventListener("touch", TouchListenerAnswer)
	wrongAnswerText1:removeEventListener("touch", TouchListenerWrongAnswer1)
    wrongAnswerText2:removeEventListener("touch", TouchListenerWrongAnswer2)
    wrongAnswerText3:removeEventListener("touch", TouchListenerWrongAnswer3)
end

local function DisplayQuestion()
    -- generate a random number between 1 and 2
    -- *** declare this variable above
    randomOperator = math.random(1,2)

    if (randomOperator == 1) then

        -- correct answer
        correctAnswer = " 8 "

        -- wrong answers
        wrongAnswer1 = correctAnswer - math.random(1, 3)
        wrongAnswer2 = correctAnswer + math.random(1, 3)
        wrongAnswer3 = correctAnswer - math.random(4, 5)

        questionObject.text == " How many planets are there? "

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

        questionObjectText.text == " What planet has life on it? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongAnswerText1.text = wrongAnswer1
        wrongAnswerText2.text = wrongAnswer2
        wrongAnswerText3.text = wrongAnswer3
    end
end

local function PositionAnswers()

    --creating random positions in a certain area
    answerPosition = math.random(1,2)

    if (answerPosition == 1) then

        correctAnswerText.x = X1
        correctAnswerText.y = Y1

        wrongAnswerText1.x = X2
        wrongAnswerText1.y = Y2

        wrongAnswerText2.x = X3
        wrongAnswerText2.y = Y3

        wrongAnswerText3.x = X4
        wrongAnswerText3.y = Y4

    elseif (answerPosition == 2) then

        correctAnswerText.x = X4
        correctAnswerText.y = Y3

        wrongAnswerText1.x = X2
        wrongAnswerText1.y = Y1

        wrongAnswerText2.x = X1
        wrongAnswerText2.y = Y4

        wrongAnswerText3.x = X3
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
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50)
    -- set the cover color
    cover:settFillColor(96/255, 96/255, 96/255)

    -- create the question text object
    questionObjectText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)

    -- create the answer text object & wrong answer text objects
    correctAnswerText = display.newText("", X1, Y1, Arial, 75)
    correctAnswerText.anchorX = 0
    wrongAnswerText1 = display.newText("", X2, Y2, Arial, 75)
    wrongAnswerText1.anchorX = 0
    wrongAnswerText2 = display.newText("", X3, Y3, Arial, 75)
    wrongAnswerText2.anchorX = 0
    wrongAnswerText3 = display.newText("", X4, Y4, Arial, 75)
    wrongAnswerText3.anchorX = 0

    ----------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(questionObjectText)
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
        DisplayQuestion()
        PositionAnswers()
        AddTextListeners()
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
        --parent:resumeGame()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveTextListeners()
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