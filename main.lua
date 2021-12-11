require 'src/Dependencies'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200
PADDLE_HEIGHT = 25
SPEED_DELTA_RATE = 1.1
MAX_SPEED_DELTA = 600
MAX_DELTA_Y = 250
BALL_SIDE = 4

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Pong')
    math.randomseed(os.time())

    love.graphics.setFont(gFonts.small)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gStateMachine = StateMachine {
        ['start'] = function()
            return StartState()
        end,
        ['play'] = function()
            return PlayState()
        end,
        ['serve'] = function()
            return ServeState()
        end,
        ['done'] = function()
            return DoneState()
        end
    }
    -- State variable to handle the transitions between the games's possible states.

    gStateMachine:change('start')
    globalState = GlobalState()
    -- initialize input table
    love.keyboard.keysPressed = {}
end

--[[
    Called by LÖVE whenever we resize the screen; here, we just want to pass in the
    width and height to push so our virtual resolution can be resized as needed.
]]
function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Having to click the x to quit is a drag. Let the player use the ESC key for that
]]
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
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

    gStateMachine:render()
    globalState:render()
    push:apply('end')
end

--[[
    dt will always be a fraction of a second, this function is used by LÖVE2D so
        you can make any required changes to the state of the game.
]]

function love.update(dt)

    gStateMachine:update(dt)
    globalState:update(dt)
    love.keyboard.keysPressed = {}
end

