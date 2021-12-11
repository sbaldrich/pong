DoneState = Class {
    __includes = BaseState
}

function DoneState:render()
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.setFont(gFonts.large)
    love.graphics.printf('Player ' .. tostring(self.winningPlayer) .. ' wins!', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts.small)
    love.graphics.printf('Press Enter to restart!', 0, 50, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
end

function DoneState:enter(params)
    self.winningPlayer = params.winningPlayer
end

function DoneState:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        GlobalState:reset()
        gStateMachine:change('play', {servingPlayer = self.winningPlayer == 1 and 2 or 1})
    end
end


