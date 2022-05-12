push = require 'push'

-- Physical window on device
WINDOW_WIDTH   = 1280
WINDOW_HEIGHT  = 720

-- Adjusted ow res window for retro game
VIRTUAL_WIDTH  = 384
VIRTUAL_HEIGHT = VIRTUAL_WIDTH * 0.5625     -- VIRTUAL_HEIGHT = 216 (almost 2:1)


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
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    love.graphics.printf('Hello pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT -50, 5, 20)
    push:apply('end')
end