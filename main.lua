push = require 'push'

-- Physical window on device
WINDOW_WIDTH   = 1280
WINDOW_HEIGHT  = 720

-- Adjusted ow res window for retro game
VIRTUAL_WIDTH  = 384
VIRTUAL_HEIGHT = VIRTUAL_WIDTH * 0.5625     -- VIRTUAL_HEIGHT = 216 (almost 2:1)

-- Animation constants
PADDLE_WIDTH  = 8
PADDLE_HEIGHT = 32
PADDLE_START_POS_X = 15
PADDLE_START_POS_Y = 20 
PADDLE_SPEED  = 200     -- Pixels per second

player1 = {
    x = PADDLE_START_POS_X,
    y = PADDLE_START_POS_Y,
    score = 0
}
player2 = {
    x = VIRTUAL_WIDTH - PADDLE_START_POS_X - PADDLE_WIDTH,
    y = VIRTUAL_HEIGHT - PADDLE_START_POS_Y - PADDLE_HEIGHT,
    score = 0
}

function love.load()
    -- Adjust resolution for anti aliasing
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Load and set default font
    smallFont = love.graphics.newFont('font.ttf', 8)
    love.graphics.setFont(smallFont)

    -- Setup the retro view insde our physical window size
    push:setupScreen(
        VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
            fullscreen = false,
            resizable = false,
            vsync = true
        })
end

function love.update(dt)
    
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')
    
    -- Clear the screen and set a new background color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    -- Display paddles, ball and game title
    love.graphics.printf('Hello pong!', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.rectangle('fill', player1.x, player1.y, 5, 20)
    love.graphics.rectangle('fill', player2.x, player2.y, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    push:apply('end')
end
