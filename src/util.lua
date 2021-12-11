--[[
    Renders the current FPS.
]]
function displayFPS()
    love.graphics.setFont(gFonts.small)
    love.graphics.setColor(0, 255 / 255, 0, 255 / 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

--[[
    Renders the current Ball speed.
]]
function displayBallSpeed()
    love.graphics.setFont(gFonts.small)
    love.graphics.setColor(0, 255 / 255, 0, 255 / 255)
    love.graphics.print('Ball speed: ' .. tostring(ball.dx), 10, VIRTUAL_HEIGHT - 10)
end