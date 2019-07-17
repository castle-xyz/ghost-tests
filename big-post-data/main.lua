local DATA_LENGTH = 4 * 1024 * 1024

function love.draw()
    love.graphics.print('press P to make a post with huge data!', 20, 20)
end

function love.keypressed(key)
    if key == 'p' then
        local chars = {}
        for i = 1, DATA_LENGTH do
            chars[i] = tostring(math.random(0, 9))
        end
        local data = table.concat(chars)
        network.async(function()
            print('`data` is ' .. #data .. ' characters long')
            castle.post.create({
                message = 'Testing a post with huge data!',
                data = data,
            })
        end)
    end
end