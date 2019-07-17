local DATA_LENGTH = 20

function love.draw()
    love.graphics.print('press P to make a post with huge data!', 20, 20)
end

function love.keypressed(key)
    if key == 'p' then
        local chars = {}
        for i = 1, DATA_LENGTH do
            chars[i] = tostring(math.random())
        end
        local data = table.concat(chars)
        network.async(function()
            castle.post.create({
                message = 'Testing a post with huge data!',
                data = data,
            })
        end)
    end
end