GlobalState = Class {
    __includes = BaseState
}

WINNING_SCORE = 5

function GlobalState:init()
    player1Score = 0
    player2Score = 0

    player1 = Paddle(10, 30, 5, PADDLE_HEIGHT)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, PADDLE_HEIGHT)

    ball = Ball(VIRTUAL_WIDTH / 2 - BALL_SIDE / 2, VIRTUAL_HEIGHT / 2 - BALL_SIDE / 2, BALL_SIDE, BALL_SIDE)
end

function GlobalState:render()
    self:displayScore()
    player1:render()
    player2:render()
    ball:render()

    -- displayFPS()
    -- displayBallSpeed()
end

function GlobalState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    player1:update(dt)
    player2:update(dt)
end

function GlobalState:displayScore()
    -- draw score on the left and right center of the screen
    -- need to switch font to draw before actually printing
    love.graphics.setFont(gFonts.large)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
end

function GlobalState:addPoint(player)
    if player == 1 then
        player1Score = player1Score + 1
        if player1Score >= WINNING_SCORE then
            gStateMachine:change('done', {
                winningPlayer = 1
            })
        end
    else
        player2Score = player2Score + 1
        if player2Score >= WINNING_SCORE then
            gStateMachine:change('done', {
                winningPlayer = 2
            })
        end
    end
end

function GlobalState:reset()
    player1Score = 0
    player2Score = 0
end
