local fileData = love.filesystem.newFileData('dir.zip')

love.filesystem.mount(fileData, 'dir', true)
love.filesystem.getDirectoryItems('dir', function(filename)
    print(filename)
end)

local myRequire = require

local code = myRequire 'dir.dir.code'

print(code.foo())
