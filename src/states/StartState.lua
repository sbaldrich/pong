StartState = Class {
    __includes = BaseState
}

function StartState:render()
    love.graphics.setFont(gFonts.large)
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.printf('Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts.small)
    love.graphics.printf('Press Enter to begin!', 0, 45, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {servingPlayer = math.random(2)})
    end
end
