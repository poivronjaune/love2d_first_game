-- Physical window on device
WINDOW_WIDTH   = 1280
WINDOW_HEIGHT  = 720

-- Adjusted ow res window for retro game
VIRTUAL_WIDTH  = 384
VIRTUAL_HEIGHT = VIRTUAL_WIDTH * 0.5625     -- VIRTUAL_HEIGHT = 216 (almost 2:1)

-- Paddle constants
PADDLE_WIDTH  = 8
PADDLE_HEIGHT = 32
PADDLE_SPEED  = 140                         -- Pixels / second

-- Ball constants
BALL_SIZE     = 4

-- UI Constants
LARGE_FONT = love.graphics.newFont(25)
SMALL_FONT = love.graphics.newFont(10)

-- GAME Parameters
WIN_SCORE = 3

-- Libraries
push = require 'push'

-- State machine to manage game states
gameState = 'title'

player1 = {
    x = 10, 
    y = 10,
    score = 0
}

player2 = {
    x = VIRTUAL_WIDTH - PADDLE_WIDTH - player1.x, 
    y = VIRTUAL_HEIGHT - PADDLE_HEIGHT - player1.y,
    score = 0
}

ball = {
    x = VIRTUAL_WIDTH / 2 - BALL_SIZE / 2,
    y = VIRTUAL_HEIGHT / 2 - BALL_SIZE / 2,
    dx = 0,
    dy = 0
}

-- Initialize the game engine
function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

    resetBall()
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1.y = math.max(player1.y - PADDLE_SPEED * dt, 0)
    elseif love.keyboard.isDown('s') then
        player1.y = math.min(player1.y + PADDLE_SPEED * dt, VIRTUAL_HEIGHT - PADDLE_HEIGHT)
    end

    if love.keyboard.isDown('up') then
        player2.y = math.max(player2.y - PADDLE_SPEED * dt, 0)
    elseif love.keyboard.isDown('down') then
        player2.y = math.min(player2.y + PADDLE_SPEED * dt, VIRTUAL_HEIGHT - PADDLE_HEIGHT)
    end    

    if gameState == 'play' then
        ball.x = ball.x + ball.dx * dt
        ball.y = ball.y + ball.dy * dt

        if ball.x <= 0 then
            resetBall()
            gameState = 'serve'
            player2.score = player2.score + 1
            if player2.score >= WIN_SCORE then gameState = 'win' end
        elseif ball.x >= VIRTUAL_WIDTH then
            resetBall()
            gameState = 'serve'
            player1.score = player1.score + 1
            if player1.score >= WIN_SCORE then gameState = 'win' end
        end

        if ball.y <= 0 then
            ball.dy = -ball.dy
        elseif ball.y >= VIRTUAL_HEIGHT - BALL_SIZE then
            ball.dy = -ball.dy
        end

        if collides(ball, player1) then
            ball.x = player1.x + PADDLE_WIDTH
            ball.dx = - ball.dx
        elseif collides(ball, player2) then
            ball.x = player2.x - BALL_SIZE
            ball.dx = - ball.dx
        end
    end

end

function love.draw()
    push:start()
    -- love.graphics.print('Hello World!')
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if gameState == 'title' then
        love.graphics.setFont(LARGE_FONT)
        love.graphics.printf('Love2D Pong', 0, 50, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(SMALL_FONT)
        love.graphics.printf('Press ENTER to start', 0, VIRTUAL_HEIGHT - 32, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(SMALL_FONT)
        love.graphics.printf('Pres ENTER to serve', 0, VIRTUAL_HEIGHT - 32, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'win' then
        love.graphics.setFont(LARGE_FONT)
        local winner = player1.score >= WIN_SCORE and '2' or '1'
        love.graphics.printf('Player ' .. winner .. ' wins!', 0, 50, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(SMALL_FONT)
        love.graphics.printf('Pres ENTER to restart', 0, VIRTUAL_HEIGHT - 32, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(LARGE_FONT)
    love.graphics.print(player1.score, VIRTUAL_WIDTH / 2 - 32, 5)   -- Move left a certain amount and move further for width of text
    love.graphics.print(player2.score, VIRTUAL_WIDTH / 2 + 16, 5)

    love.graphics.rectangle('fill', player1.x, player1.y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', player2.x, player2.y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', ball.x, ball.y, BALL_SIZE, BALL_SIZE)
    -- love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 1, 0, 2, VIRTUAL_HEIGHT)
    push:finish()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end 

    if key == 'enter' or key == 'return' then
        if gameState == 'title' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'win' then
            player1.score = 0
            player2.score = 0
            gameState = 'serve'
        end
    end
end


-- Customized functions
function collides(b, p)
    -- Return true for a collision detected
    no_collision_detected = b.y > p.y + PADDLE_HEIGHT or b.x > p.x + PADDLE_WIDTH or p.y > b.y + BALL_SIZE or p.x > b.x + BALL_SIZE
    return not no_collision_detected
end

function resetBall()
    -- Place ball to center
    ball.x = VIRTUAL_WIDTH / 2 - BALL_SIZE / 2
    ball.y = VIRTUAL_HEIGHT / 2 - BALL_SIZE / 2
    -- ball.dx = math.random(60)
    ball.dx = 60 + math.random(60)
    if math.random(2) == 1 then
        ball.dx = -ball.dx
    end
    ball.dy = 30 + math.random(60)
    if math.random(2) == 1 then
        ball.dy = -ball.dy
    end
end        