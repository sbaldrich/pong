-- push allows to draw to the screen in a virtual resolution, which will help
-- transmit a more retro aesthetic
-- https://github.com/Ulydev/push (not actively maintained as of Dec 2021)
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- This is a more "retro-looking" font that can be used ...
    local smallFont = love.graphics.newFont('font.ttf', 8)

    -- ... here. After setting it as the current font.
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
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
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- Draw the paddles and the ball
    -- left
    love.graphics.rectangle('fill', 10, 30, 5, 20);
    -- right
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5 , 20);

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
    -- Nothing yet!
end
