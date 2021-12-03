-- push allows to draw to the screen in a virtual resolution, which will help
-- transmit a more retro aesthetic
-- https://github.com/Ulydev/push (not actively maintained as of Dec 2021)
push = require 'push'

-- It's preferable to use classes to represent the entities in the game
Class = require 'class'

require 'Ball'
require 'Paddle'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    -- This is a more "retro-looking" font that can be used ...
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- larger font for drawing the score on the screen
    scoreFont = love.graphics.newFont('font.ttf', 32)
    -- ... here. After setting it as the current font.
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    -- State variable to handle the transitions between the games's possible states.
    gameState = 'start'
end

--[[
    Having to click the x to quit is a drag. Let the player use the ESC key for that
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else 
            gameState = 'start'
            -- Set the ball to the middle of the screen
            ball:reset()
        end
    end
end

--[[
    Called by LÖVE2D on every frame to redraw the screen.
    ]]
function love.draw()
    -- start rendering at virtual resolution
    push:apply('start')

    -- Set the background to a color similar to the original Pong
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- draw score on the left and right center of the screen
    -- need to switch font to draw before actually printing
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, 
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

    -- Draw the paddles and the ball
    player1:render()
    player2:render()
    ball:render()


    displayFPS()

    -- end rendering at virtual resolution
    push:apply('end')
end

--[[
    dt will always be a fraction of a second, this function is used by LÖVE2D so
        you can make any required changes to the state of the game.
]]
function love.update(dt)
    
    if gameState == 'play' then
        if ball:collides(player1) then
            ball.x = player1.x + 5
            ball.dx = -ball.dx * 1.10
        
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball:collides(player2) then
            ball.x = player2.x - ball.width
            ball.dx = -ball.dx * 1.10
        
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else 
                ball.dy = math.random(10, 150)
            end
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y >= VIRTUAL_HEIGHT then
            ball.y = VIRTUAL_HEIGHT
            ball.dy = -ball.dy
        end

        if ball.x > VIRTUAL_WIDTH then
            player1Score = player1Score + 1
            gameState = "start"
            ball:reset()
        end

        if ball.x < 0 then
            player2Score = player2Score + 1
            gameState = "start"
            ball:reset()
        end
    end

    
    
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        -- No syntactic sugar for adding and assigning at the same time
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end
    
    player1:update(dt)
    player2:update(dt)
end

--[[
    Renders the current FPS.
]]
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
