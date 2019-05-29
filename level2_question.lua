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
sceneName = "level2_question"

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

local questionText
local questionText2
local questionText3
local numericField
local userAnswer
local correctAnswer1
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
    userAnswer = answerText.text
    
    questionsAnswered = questionsAnswered + 1

    if (touch.phase == "ended") then

        BackToLevel1( )
    
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer1(touch)
    userAnswer = wrongText1.text
    
    if (touch.phase == "ended") then
        
        BackToLevel2( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)
    userAnswer = wrongText2.text
    
    if (touch.phase == "ended") then
        
        BackToLevel2( ) 
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer3(touch)
    userAnswer = wrongText3.text
    
    if (touch.phase == "ended") then
        
        BackToLeve2( )
          
    end 
end

-- add the event listeners
local function AddTextListeners()
	answerText:addEventListener("touch", TouchListenerAnswer)
	wrongText1:addEventListener("touch", TouchListenerWrongAnswer1)
	wrongText2:addEventListener("touch", TouchListenerWrongAnswer2)
	wrongText3:addEventListener("touch", TouchListenerWrongAnswer3)
    wrongText4:addEventListener("touch", TouchListenerWrongAnswer4)
    wrongText5:addEventListener("touch", TouchListenerWrongAnswer5)
    wrongText6:addEventListener("touch", TouchListenerWrongAnswer6)
end

-- remove event listeners
local function RemoveTextListeners()
	answerText:removeEventListener("touch", TouchListenerAnswer)
	wrongText1:removeEventListener("touch", TouchListenerWrongAnswer1)
    wrongText2:removeEventListener("touch", TouchListenerWrongAnswer2)
    wrongText3:removeEventListener("touch", TouchListenerWrongAnswer3)
    wrongText4:addEventListener("touch", TouchListenerWrongAnswer4)
    wrongText5:addEventListener("touch", TouchListenerWrongAnswer5)
    wrongText6:addEventListener("touch", TouchListenerWrongAnswer6)
end

local function AskQuestion()
    -- generate a random number between 1 and 2
    -- *** declare this variable above
    randomOperator = math.random(1,2)

    if (randomOperator == 1) then

        -- correct answer
        correctAnswer = " Chicken "

        -- wrong answers
        wrongAnswer1 = " Carrot "
        wrongAnswer2 = " Yogurt "
        wrongAnswer3 = " Cereal "
        wrongAsnwer4 = " Orange "

        questionText = " what is in the protein food group? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongText1.text = wrongAnswer1
        wrongText2.text = wrongAnswer2
        wrongText3.text = wrongAnswer3
    
    elseif (randomOperator == 2) then

        -- correct answer
        correctAnswer = " Dairy "

        -- wrong answers
        wrongAnswer4 = " Vegetables "
        wrongAnswer5 = " Protein "
        wrongAnswer6 = " Fruits "
        wrongAnswer7 = " Grains "

        questionText2 = " what food group is milk part of? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongText4.text = wrongAnswer4
        wrongText5.text = wrongAnswer5
        wrongText6.text = wrongAnswer6
    end
end

local function PositionAnswers()

    --creating random positions in a certain area
    answerPosition = math.random(1,2)

    if (answerPosition == 1) then

        answerText.x = X1
        answerText.y = Y1
        
        wrongText1.x = X2
        wrongText1.y = Y1
        
        wrongText2.x = X3
        wrongText2.y = Y3

        wrongText3.x = X1
        wrongText3.y = Y2 
        
    elseif (answerPosition == 2) then

        answerText.x = X1
        answerText.y = Y2
                    
        wrongText1.x = X1
        wrongText1.y = Y1
            
        wrongText2.x = X2
        wrongText2.y = Y1
        
        wrongText3.x = X3
        wrongText3.y = Y3

    elseif (answerPosition == 3) then

        answerText.x = X3
        answerText.y = Y3
            
        wrongText1.x = X1
        wrongText1.y = Y2
            
        wrongText2.x = X1
        wrongText2.y = Y1
        
        wrongText3.x = Y2
        wrongText3.y = Y1

    elseif (answerPosition == 4) then

        answerText.x = X2
        answerText.y = Y1

        wrongText1.x = X3
        wrongText1.y = Y3

        wrongText2.x = X1
        wrongText2.y = Y2

        wrongText3.x = Y1
        wrongText3.y = Y1
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
    -- make a cover rectangle to have rhe background fully blocked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50)
    -- set the cover color
    cover:setFillColor(96/255, 96/255, 96/255)
    ----------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(cover)
   
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)
    questionText2 = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)
    answerText = display.newText("", X1, Y2, Arial, 75)
    answerText.anchorX = 0
    wrongText1 = display.newText("", X2, Y2, Arial, 75)
    wrongText1.anchorX = 0
    wrongText2 = display.newText("", X1, Y1, Arial, 75)
    wrongText2.anchorX = 0
    wrongText3 = display.newText("", X1, Y1, Arial, 75)
    wrongText3.anchorX = 0
    wrongText4 = display.newText("", X1, Y1, Arial, 75)
    wrongText4.anchorX = 0
     -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert(answerText)
    sceneGroup:insert(wrongText1)
    sceneGroup:insert(wrongText2)
    sceneGroup:insert(wrongText3)
    sceneGroup:insert(wrongText4)
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
        --DisplayQuestion()
        --PositionAnswers()
        --AddTextListeners()
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