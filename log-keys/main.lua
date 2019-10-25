local messages = {}

local function addMessage(message)
    table.insert(messages, message)
    while #messages > 10 do
        table.remove(messages, 1)
    end
end

function love.draw()
    local concatenated = ''
    for _, message in ipairs(messages) do
        concatenated = concatenated .. message .. '\n'
    end
    love.graphics.print(concatenated, 20, 20)
end

function love.keypressed(k)
    addMessage(k .. ' pressed')
end

function love.keyreleased(k)
    addMessage(k .. ' released')
end