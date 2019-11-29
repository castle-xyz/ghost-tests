local helloData = love.filesystem.newFileData('hello.txt')

local helloString = helloData:getString()
local helloName = helloData:getFilename()
local helloExtension = helloData:getExtension()

local httpsData = love.filesystem.newFileData('https://raw.githubusercontent.com/castle-games/ghost-tests/master/README.md')

local httpsString = httpsData:getString()

function love.draw()
    love.graphics.print('helloString: ' .. helloString, 20, 20)
    love.graphics.print('\nhelloName: ' .. helloName, 20, 20)
    love.graphics.print('\n\nhelloExtension: ' .. helloExtension, 20, 20)

    love.graphics.print('\n\n\n\nhttpsString: ' .. httpsString, 20, 20)
end