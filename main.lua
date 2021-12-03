WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--[[
    Called by LÖVE2D on every frame to redraw the screen.
    ]]
function love.draw()
    love.graphics.printf(
        'Hello Pong!',          -- text to render
        0,                      -- starting X (0 since we're going to center it based on width)
        WINDOW_HEIGHT / 2 - 6,  -- starting Y (halfway down the screen)
        WINDOW_WIDTH,           -- number of pixels to center within (the entire screen here)
        'center')               -- alignment mode, can be 'center', 'left', or 'right'
end


--[[
    dt will always be a fraction of a second, this function is used by LÖVE2D so
        you can make any required changes to the state of the game.
]]
function love.update(dt)
-- Nothing yet!
end
