Ball = Class {}

INITIAL_SPEED_X = 200
INITIAL_SPEED_Y = 100

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = math.random(2) == 1 and INITIAL_SPEED_X or -INITIAL_SPEED_X
    self.dy = math.random(-INITIAL_SPEED_Y, INITIAL_SPEED_Y)
end

function Ball:reset(sign)
    self.x = VIRTUAL_WIDTH / 2 - self.width
    self.y = VIRTUAL_HEIGHT / 2 - self.height
    sign = sign or math.random(-1,0)
    sign = sign > 0 and 1 or -1
    self.dx = sign * INITIAL_SPEED_X
    self.dy = math.random(-INITIAL_SPEED_Y, INITIAL_SPEED_Y)
end

--[[
    Update the velocity to position, scaled by deltaTime
]]
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x ,self.y, self.width, self.height)
end

--[[
    This is a very simple check for intersection of aligned rectangles. 
    It's called AABB collission detection
]]
function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    return true
end
