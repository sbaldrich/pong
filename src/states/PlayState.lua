PlayState = Class {
    __includes = BaseState
}

function PlayState:init()
    self.serving = true
end

function PlayState:enter(params)
    self.servingPlayer = params.servingPlayer
end

function PlayState:render()
    if self.serving then
        love.graphics.setFont(gFonts.small)
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.printf('Player ' .. tostring(self.servingPlayer) .. "'s serve!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255, 255, 255, 255)
    end
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if self.serving then
            self.serving = false
        end
    end
    if not self.serving then
        if ball:collides(player1) then
            ball.x = player1.x + 5
            ball.dx = -ball.dx * SPEED_DELTA_RATE
            ball.dx = math.min(ball.dx, MAX_SPEED_DELTA)

            -- Keep the same vertical direction when
            -- colliding with a paddle
            ball.dy = (ball.dy < 0 and -1 or 1) * math.random(10, MAX_DELTA_Y)
            gSounds['paddle_hit']:play()
        end

        if ball:collides(player2) then
            ball.x = player2.x - ball.width
            ball.dx = -ball.dx * SPEED_DELTA_RATE
            ball.dx = math.max(ball.dx, -MAX_SPEED_DELTA)

            -- Keep the same vertical direction when
            -- colliding with a paddle
            ball.dy = (ball.dy < 0 and -1 or 1) * math.random(10, MAX_DELTA_Y)
            gSounds['paddle_hit']:play()
        end

        -- Handle collision with upper or lower bounds
        if ball.y <= 0 or ball.y >= VIRTUAL_HEIGHT then
            ball.y = ball.y <= 0 and 0 or VIRTUAL_HEIGHT
            ball.dy = -ball.dy
            gSounds['wall_hit']:play()
        end

        if ball.x > VIRTUAL_WIDTH then
            gSounds['score']:play()
            GlobalState:addPoint(1)
            self.serving = true
            self.servingPlayer = 2
            ball:reset(-1)
        end

        if ball.x < 0 then
            GlobalState:addPoint(2)
            gSounds['score']:play()
            self.serving = true
            self.servingPlayer = 1
            ball:reset(1)
        end
        ball:update(dt)
    end
end
