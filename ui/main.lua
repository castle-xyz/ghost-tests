--- UI

local ui = {}


local state = require 'https://raw.githubusercontent.com/castle-games/share.lua/b94c77cacc9e842877e7d8dd71c17792bd8cbc32/state.lua'
local cjson = (require 'cjson').new()
cjson.encode_sparse_array(true, 1, 0)
local jsEvents = require 'jsEvents'


local root = state.new()
root:__autoSync(true)


root.panes = {}

root.panes.DEFAULT = {
    type = 'pane',
    props = {},
}


local function hash(s)
    return love.data.encode('string', 'base64', love.data.hash('md5', s))
end


local stack = {}

local function push(element)
    table.insert(stack, {
        element = element,
        newChildren = { count = 0 },
    })
end

local function addChild(id)
    id = tostring(id)

    local top = stack[#stack]
    top.newChildren.count = top.newChildren.count + 1

    -- Form dedup'ing id if exists in new
    if top.newChildren[id] then
        id = hash(id .. top.newChildren.count)
    end

    -- Reuse old child if exists, add to new, return
    local oldChild
    if top.element.children and top.element.children[id] then
        child = top.element.children[id]
    end
    local child = oldChild or {}
    top.newChildren[id] = child
    child.order = top.newChildren.count
    return child
end

local function pop()
    local top = table.remove(stack)
    top.element.children = top.newChildren
end


local function mergeTable(t, u, ...)
    if u == nil then
        return t
    end
    local r = {}
    for k in pairs(t) do
        r[k] = t[k]
    end
    for k in pairs(u) do
        r[k] = u[k]
    end
    return mergeTable(r, ...)
end

function ui.heading(text, props)
    local c = addChild(hash(text))
    c.type = 'heading'
    c.props = type(text) == 'table' and text or mergeTable({ text = text }, props)
end

function ui.markdown(text, props)
    local c = addChild(hash(text))
    c.type = 'markdown'
    c.props = type(text) == 'table' and text or mergeTable({ text = text }, props)
end

function ui.paragraph(text, props)
    local c = addChild(hash(text))
    c.type = 'paragraph'
    c.props = type(text) == 'table' and text or mergeTable({ text = text }, props)
end

function ui.text(text, props)
    local c = addChild(hash(text))
    c.type = 'text'
    c.props = type(text) == 'table' and text or mergeTable({ text = text }, props)
end


function ui.update()
    push(root.panes.DEFAULT)
    castle.uiupdate()
    pop()

    local diff = root:__diff(0)
    if diff ~= nil then
        local diffJson = cjson.encode(diff)
        jsEvents.send('CASTLE_TOOLS_UPDATE', diffJson)
    end
    root:__flush()
end

function castle.uiupdate()
end

ui.update()


--- MAIN

local val = 42

local keys = {}

function castle.uiupdate()
    ui.markdown([[
## Hi there!

This is **cool**! Right? [Google](https://www.google.com)...
    ]])
    for _, key in ipairs(keys) do
        ui.text(key, {
            color = 'status-critical',
        })
    end
end

function love.update()
    ui.update()
end

function love.draw()
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)
    love.graphics.print('\n\nval is: ' .. val, 20, 20)
end

function love.keypressed(key)
    if key == 'delete' then
        keys = {}
    elseif key == 'backspace' then
        keys[#keys] = nil
    else
        table.insert(keys, key)
    end
end