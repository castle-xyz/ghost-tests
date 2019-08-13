local cjson = require 'cjson'

local post, media, creatorPhoto
network.async(function()
    post = castle.post.get { postId = '438', data = true }
    print('post json: ' .. cjson.encode(post))
    media = love.graphics.newImage(post.mediaUrl)
    creatorPhoto = love.graphics.newImage(post.creator.photoUrl)
end)

function love.draw()
    if post then
        love.graphics.print('postId: ' .. post.postId, 20, 20)
        love.graphics.print('\ncreator.userId: ' .. post.creator.userId, 20, 20)
        love.graphics.print('\n\ncreator.username: ' .. post.creator.username, 20, 20)
        love.graphics.print('\n\n\ncreator.name: ' .. post.creator.name, 20, 20)
        love.graphics.print('\n\n\n\ncreator.photoUrl: ' .. post.creator.photoUrl, 20, 20)
        love.graphics.print('\n\n\n\n\nmediaUrl: ' .. post.mediaUrl, 20, 20)
    end

    if media then
        local s = math.min(1, 100 / media:getHeight())
        love.graphics.draw(media, 20, 124, 0, s, s)
    end

    if creatorPhoto then
        local s = math.min(1, 100 / creatorPhoto:getHeight())
        love.graphics.draw(creatorPhoto, 20, 244, 0, s, s)
    end
end