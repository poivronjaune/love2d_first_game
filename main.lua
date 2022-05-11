VIRTUAL_WIDTH  = 384
VIRTUAL_HEIGHT = 216
WINDOW_WIDTH   = 1280
WINDOW_HEIGHT  = 720

push = require 'push'

function love.load()
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)
end

function love.update(dt)

end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    push:start()
    love.graphics.print('Hello World!')
    push:finish()
end