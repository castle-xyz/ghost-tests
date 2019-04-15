function love.draw()
    love.graphics.print([[
    press P to make a post
    ]], 20, 20)
end

function love.keypressed(key)
    if key == 'p' then
        network.async(function()
            castle.post.create {
                message = 'hello, world!',
                data = { a = 1, b = 2 },
            }
        end)
    end
end
