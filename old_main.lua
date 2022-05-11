x = 10
y = 10
step = 5
font = love.graphics.getFont()

function love.load()
    sprite = love.graphics.newImage("queen.png")
 end

function love.draw()
    love.graphics.draw(sprite, x, y)
    text = love.graphics.newText( font, "Hello World!" )
    
end
-- function love.draw()
--     -- love.graphics.print("Hello World!", 400, 300)
--     love.graphics.print("Hello World!")
-- end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
       love.event.quit()
    end
    move(key)

end

function move(key)
    if key == "right" then
        x = x + step
    end
    if key == "down" then
        y = y + step
    end
    if key == "left" then
        x = x - step
    end
    if key == "up" then
        y = y - step
    end    
end


--switch(key){  
--    case "right":  
--    printf("number is equal to 10\n");  
--    case 50:  
--    printf("number is equal to 50\n");  
--    case 100:  
--    printf("number is equal to 100\n");  
--    default:  
--    printf("number is not equal to 10, 50 or 100");  
--    } 