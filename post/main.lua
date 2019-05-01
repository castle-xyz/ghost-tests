local text = ''
local creator
local initialPost = castle.post.getInitialPost()

function castle.postopened(post)
    creator = post.creator
    text = post.data.text
end

function love.draw()
    love.graphics.print([[
    press ENTER to make a post

    the text so far is: []] .. text .. [[]
    the time is: ]] .. love.timer.getTime() .. [[

    creator was: ]] .. (creator and creator.username or 'no one') .. [[
    initial post had text: ]] .. (initialPost and initialPost.data.text or 'jk nothing') .. [[
    ]], 20, 20)
end

function love.keypressed(key)
    if key == 'return' then
        network.async(function()
            castle.post.create {
                message = 'hello, world!',
                data = { text = text },
            }
        end)
    end
end

function love.textinput(t)
    text = text .. t
end