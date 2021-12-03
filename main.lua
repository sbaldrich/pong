-- push allows to draw to the screen in a virtual resolution, which will help
-- transmit a more retro aesthetic
-- https://github.com/Ulydev/push (not actively maintained as of Dec 2021)
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

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

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

--[[
    Having to click the x to quit is a drag. Let the player use the ESC key for that
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
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
    -- left
    love.graphics.rectangle('fill', 10, player1Y, 5, 20);
    -- right
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20);

    -- ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4);

    -- end rendering at virtual resolution
    push:apply('end')
end

--[[
    dt will always be a fraction of a second, this function is used by LÖVE2D so
        you can make any required changes to the state of the game.
]]
function love.update(dt)
    if love.keyboard.isDown('w') then
        -- No syntactic sugar for adding and assigning at the same time
        player1Y = player1Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('up') then
        -- No syntactic sugar for adding and assigning at the same time
        player2Y = player2Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end

end
