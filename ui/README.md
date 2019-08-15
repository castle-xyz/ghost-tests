![Castle UI API](gif.gif)

The Castle UI API allows you to add user interface components that allow interaction with your game. Castle manages the laying out of your UI relative to the rest of Castle's UI. Uses can range from simple debug tools while developing games to user-facing level editors or text-based adventure games etc.

# Contents

- [Tutorial](#tutorial)
- [Top-level](#top-level)
    - [`ui.setVisible`](#uisetvisible)
    - [`ui.getVisible`](#uigetvisible)
- [Components](#components)
    - [Box](#box)
    - [Button](#button)
    - [Checkbox](#checkbox)
    - [Code editor](#code-editor)
    - [Color picker](#color-picker)
    - [Dropdown](#dropdown)
    - [File picker](#file-picker)
    - [Image](#image)
    - [Markdown](#markdown)
    - [Number input](#number-input)
    - [Radio button group](#radio-button-group)
    - [Scroll box](#scroll-box)
    - [Section](#section)
    - [Slider](#slider)
    - [Tabs](#tabs)
        - [`ui.tabs`](#uitabs)
        - [`ui.tab`](#uitab)
    - [Text area](#text-area)
    - [Text input](#text-input)
    - [Toggle](#toggle)

# Tutorial

To use the UI API, simply define the `castle.uiupdate` function and put your UI calls in it:

```lua
function castle.uiupdate()
    castle.ui.markdown([[
## Hello world!

Welcome to UI.
    ]])
end
```

Since using UI components usually involves a lot of calls to functions in the `castle.ui` module, it helps to make a local variable referencing it:

```lua
local ui = castle.ui

function castle.uiupdate()
    ui.markdown([[
## Hello world!

Welcome to UI.
    ]])
end
```

Components that work as inputs usually take a label and the current value, then return the new value:

```lua
local ui = castle.ui

local myString = 'Edit me!'

function castle.uiupdate()
    myString = ui.textArea('myString', myString)
end

function love.draw()
    love.graphics.print('myString:\n' .. myString, 20, 20)
end
```

`castle.uiupdate`, like `love.draw`, is called repeatedly at a certain frequency. For the UI this is currently 20 times a second, which seems to make for reasonable responsiveness. On each update, you just need to describe the UI for the current state of your game, and don't have to worry about removing or updating the state of 'old' UI components. Simply don't make a call to have something not be displayed. In this sense, UI calls are like LÖVE draw calls.

```lua
local ui = castle.ui

local shouldShowText = true

function castle.uiupdate()
    shouldShowText = ui.checkbox('Show text', shouldShowText)
    
    if shouldShowText then
        ui.markdown('The display of this text is toggled by the above checkbox!')
    end
end
```

See the [code for the 'Circles' demo](./circles.lua) for an example of showing UI for many game entities.

# Top-level

These functions affect top-level properties of the UI as a whole and aren't related to any particular UI component.

## `ui.setVisible`

```
ui.setVisible(visible)
```

Set whether the UI panel is visible. This function can be called outside `ui.update`.

**Arguments**

- `visible` (*boolean*, required): Whether the UI should be visible.

**Returns**

This function doesn't return anything

## `ui.getVisible`

```
visible = ui.getVisible()
```

Get whether the UI panel is visible. This function can be called outside `ui.update`.

**Arguments**

This function doesn't have any arguments.

**Returns**

- `visible` (*boolean*): Whether the UI is visible.

# Components

Each of these functions corresponds to one type of UI component, and must be called inside `ui.update`.

All component functions take some required parameters, and one `props` parameter for additional configuration. All keys in `props` are optional. `props` itself is always optional and defaults to `{}`.

Parent components (components that have more components inside) take an `inside` parameter. The `inside` parameter should be a function that makes more UI calls -- the components created by these calls then become children of the parent component.

Input components generally have required label and value parameters. Labels are strings shown next to inputs to describe their function, and are also used by the system to distinguish the inputs from each other. Value parameters provide the current value of the input. Input components generally return the new values (which may be equal to the values passed in if no changes were made by the user).

## Box

A container to allow custom layouts for components. Children can be laid out horizontally or vertically and the parent can have configurable background color, border, width and height.

```
ui.box(id, props, inner)
ui.box(id, inner)
```

**Arguments**

- `id` (*string*, required): An identifying string for this box. Needs to be unique within the parent of the box. This id isn't displayed anywhere and is just used internally to distinguish boxes from each other.
- `props` (*table*, optional): The table of props:
    - `margin` or `m` (*number* or *string*): Sets `margin` in CSS.
    - `marginTop` or `mt` (*number* or *string*): Sets `margin-top` in CSS.
    - `marginRight` or `mr` (*number* or *string*): Sets `margin-right` in CSS.
    - `marginBottom` or `mb` (*number* or *string*): Sets `margin-bottom` in CSS.
    - `marginLeft` or `ml` (*number* or *string*): Sets `margin-left` in CSS.
    - `marginX` or `mx` (*number* or *string*): Sets both `marginLeft` and `marginRight`.
    - `marginY` or `my` (*number* or *string*): Sets both `marginTop` and `marginBottom`.
    - `padding` or `p` (*number* or *string*): Sets `padding` in CSS.
    - `paddingTop` or `pt` (*number* or *string*): Sets `padding-top` in CSS.
    - `paddingRight` or `pr` (*number* or *string*): Sets `padding-right` in CSS.
    - `paddingBottom` or `pb` (*number* or *string*): Sets `padding-bottom` in CSS.
    - `paddingLeft` or `pl` (*number* or *string*): Sets `padding-left` in CSS.
    - `paddingX` or `px` (*number* or *string*): Sets both `paddingLeft` and `paddingRight`.
    - `paddingY` or `py` (*number* or *string*): Sets both `paddingTop` and `paddingBottom`.
    - `color` (*string*): Sets the text color. Must be a CSS color such as `'#ff0000'` or `'green'`.
    - `backgroundColor` or `bg` (*string*): Sets the background color. Must be a CSS color such as `'#ff0000'` or `'green'`.
    - `width`, `height`, `minWidth`, `minHeight`, `maxWidth`, `maxHeight` (*number* or *string*): Each of these sets the respective CSS property. Numbers from 0-1 are converted to percentages. Numbers greater than 1 are converted to pixel values. Strings are passed as raw CSS (eg. `'100%'`, `'2em'`).
    - `border`, `borderTop`, `borderRight`, `borderBottom`, `borderLeft` (*string*): Each of these sets the respective CSS border property. Strings are directly passed to CSS, so an example string is `'1px solid white'`.
    - `borderStyle` (*string*): Sets the CSS `border-style` property.
    - `borderColor` (*string*): Sets the CSS `border-color` property.
    - `borderRadius` (*number* or *string*): Sets the CSS `border-radius` property. Numbers are converted to pixel values. Strings are passed directly to CSS (eg. `'50%'`).
    - `alignItems`, `alignContent`, `justifyItems`, `justifyContent`, `flexWrap`, `flexDirection`, `flex`, `flexGrow`, `flexShrink`, `flexBasis`, `justifySelf`, `alignSelf`, `order` (*string*): Each of these sets the respective CSS [Flexbox](https://www.w3schools.com/css/css3_flexbox.asp) property.
- `inner` (*function*, required): A function that makes UI calls defining contents of this box. Children are laid out in the direction specified by the `flexDirection` prop. By default the direction is `'column'`.

**Returns**

This function doesn't return anything

## Button

Allows the user to perform an action by clicking.

```
clicked = ui.button(label, props)
```

**Arguments**

- `label` (*string*, required): The label
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the button should be disabled
    - `big` (*function*): Whether the button should be a bigger variant.
    - `kind` (*string*): One of `'primary'`, `'secondary'`, `'danger'` or `'ghost'`. Is `'secondary'` by default. A 'primary' button is highlighted and meant for important actions. A 'danger' button is meant for dangerous actions (such as deleting something). A 'ghost' button has even less visual dominance than a secondary button.
    - `onClick` (*function*): A function to call when the button is clicked. You can use this instead of using the return value directly if you prefer callbacks.

**Returns**

- `clicked` (*boolean*): Whether the button was clicked in this update.

## Checkbox

Allows the user to toggle a boolean value. Checkboxes generally represent one input in a larger flow with a final confirmation step (eg. choosing among many settings then clicking a button to perform an action with those settings). Prefer [toggle switches](#toggle) instead if the resulting action immediately affects something in your game without another step.

```
newChecked = ui.checkbox(label, checked, props)
```

**Arguments**

- `label` (*string*, required): The label
- `checked` (*string*, required): Whether currently checked
- `props` (*table*, optional): The table of props:
    - `indeterminate` (*boolean*): Whether the checkbox is in an 'indeterminate' state between checked and unchecked. This useful when you want to express that the checkbox has a sublist of selections, some selected and some unselected.
    - `disabled` (*boolean*): Whether the input should be disabled
    - `hideLabel` (*boolean*): Whether to hide the label
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

**Returns**

- `newChecked` (*string*): The new checked state. Is equal to `checked` if no change occured in this update.

## Code editor

Display a text editor specifically designed for code (has syntax highlighting, monospace fonts, etc.). The `value` represents the contents of the editor as a string. You can use, for example, the [`load`](https://www.lua.org/manual/5.2/manual.html#pdf-load) function to compile the string if it's meant to be Lua code.

```
newValue = ui.codeEditor(label, value, props)
```

**Arguments**

- `label` (*string*, required): The label
- `value` (*string*, required): The current value
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the input should be disabled
    - `hideLabel` (*boolean*): Whether to hide the label
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.
    - `onChangeCursorPosition` (*function*): A function to call when the user moves the cursor in the text editor. The function is called with one parameter, `position`, which is a table with the following keys:
        - `line` (*number*): The line number that the cursor is on. The first line is numbered 1.
        - `column` (*number*): The column that the cursor is on. The first column is numbered 1.
        - `offset` (*number*): The offset of the cursor in the `value` string. Starts at 0.
        - `word` (*string*): The word in `value` that is at the current cursor position, or `nil` if there is no word.
    - `completions` (*table*): A table containing auto-completion suggestions to display. The editor will automatically filter these suggestions based on what the user is typing. The table is expected to be in the form of a Lua array, where each element represents a suggestion. Each suggestion must itself be a table with the following keys:
        - `label` (*string*, required): The text to display for this item in the completion menu.
        - `kind` (*string*, required): The kind of item this is. Used to decide what icon to in the menu. Must be one of `'Class'`, `'Color'`, `'Constant'`, `'Constructor'`, `'Enum'`, `'EnumMember'`, `'Event'`, `'Field'`, `'File'`, `'Folder'`, `'Function'`, `'Interface'`, `'Keyword'`, `'Method'`, `'Module'`, `'Operator'`, `'Property'`, `'Reference'`, `'Snippet'`, `'Struct'`, `'Text'`, `'TypeParameter'`, `'Unit'`, `'Value'` or `'Variable'`.
        - `insertText` (*string*, optional): The actual text to insert when this item is selected. Is equal to `label` by default. This is useful if you want to use a shorter label than the entire code that is inserted, eg. a `label` "Entity template" that has the entire template code for an entity as its `insertText`.
        - `documentation` (*string*, optional): Documentation to show for this item. Markdown is allowed for formatting. The user can see the documentation by pressing Ctrl + Space when an item is highlighted or by pressing the info icon.
        - `preselect` (*boolean*, optional): Whether to prioritize this item for selection. The editor will still select the best match based on what the user has typed in.
        - `sortText` (*string*, optional): A string to use when comparing this item to other items for sorting. `label` is used by default.
    - *More code editor props will be added soon!*

**Returns**

- `newValue` (*string*): The new value input by the user. Is equal to `value` if no change occured in this update.

## Color picker

Allows the user to select a color using a visual input.

```
newR, newG, newB, newA = ui.colorPicker(label, r, g, b, a, props)
```

**Arguments**

- `label` (*string*, required): The label
- `r` (*number*, required): The red component of the current color, in the 0-1 range.
- `g` (*number*, required): The green component of the current color, in the 0-1 range.
- `b` (*number*, required): The blue component of the current color, in the 0-1 range.
- `a` (*number*, required): The alpha component of the current color, in the 0-1 range. If you want to skip the alpha component, just pass `1` here and pass `false` for `enableAlpha` in `props`.
- `props` (*table*, optional): The table of props:
    - `enableAlpha` (*boolean*): Whether to show a slider for editing the alpha component. By default this is `true`.
    - `mode` (*string*): Format of color components for numeric input. Can be `'RGB'`, `'HSB'` or `'HSL'`. An input in hex format is always shown to alongside this.
    - `disabled` (*boolean*): Whether the input should be disabled
    - `hideLabel` (*boolean*): Whether to hide the label
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

**Returns**

- `newR` (*number*): The red component of the new value input by the user, in the 0-1 range.
- `newG` (*number*): The green component of the new value input by the user, in the 0-1 range.
- `newB` (*number*): The blue component of the new value input by the user, in the 0-1 range.
- `newA` (*number*): The alpha component of the new value input by the user, in the 0-1 range. If `enableAlpha` was `false` in `props`, this is equal to the given `a` value.

## Dropdown

Allows the user to select from list of values.

```
newValue = ui.dropdown(label, value, items, props)
```

**Arguments**

- `label` (*string*, required): The label
- `value` (*string*, required): The current value. Must be one of the values in `items`, or `nil` to indicate that nothing has been selected. When nothing is selected, the control displays `props.placeholder`, which defaults to `'Select an option...'`.
- `items` (*table*, required): A table containing strings that are possible values for the user to select from. The table is expected to be in the form of a Lua array, eg. `{ 'option1', 'option2', 'option3' }`.
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the input should be disabled
    - `placeholder` (*string*): Text to show when no item is selected (i.e., `value` is `nil`). Defaults to `'Select an option...'`.
    - `hideLabel` (*boolean*): Whether to hide the label
    - `invalid` (*boolean*): Whether the value is currently invalid
    - `invalidText` (*string*): An error message to display when the value is invalid
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

**Returns**

- `newValue` (*string*): The new value input by the user. Is equal to `value` if no change occured in this update.

## File picker

Allows the user to pick a file. The user can either browse for files with the system file dialog or drag and drop files onto the control. The file is uploaded to Castle's servers and a URI is returned. This URI can then be used with LÖVE resource-loading functions. Since the file is uploaded, the URI is safe to put in [storage](https://castle.games/documentation/storage-api-reference) or use with multiplayer APIs -- to let a user pick a custom character avatar in a multiplayer game, for example.

```
newValue = ui.filePicker(label, value, props)
```

**Arguments**

- `label` (*string*, required): The label
- `value` (*string*, required): The current value. Must be a URI to an existing file.
- `props` (*table*, optional): The table of props:
    - `type` (*string*): A string specifying what the file type should be. Currently suppors `'image'` to specify that the file should be of any image type. In this case a preview of the currently selected image is shown in the UI, and the user can only browse for image files.
    - `disabled` (*boolean*): Whether the input should be disabled
    - `hideLabel` (*boolean*): Whether to hide the label
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

**Returns**

- `newValue` (*string*): The URI for the new file picked by the user. Is equal to `value` if no change occured in this update.

**Notes**

Since the result is a URI, you need to use `love.graphics.newImage` (or a similar asset-loading function for the relevant asset type) to create a LÖVE resource out of it. So, to load the resulting file as an image:

```lua
-- `imageUrl` stores the URL for the image, `image` will store the image itself
imageUrl = ui.filePicker('Image', imageUrl, {
    type = 'image',
    onChange = function(newImageUrl)
        if newImageUrl == nil then
            image = nil
        else
            network.async(function()
                image = love.graphics.newImage(newImageUrl)
            end)
        end
    end,
})
```

## Image

Displays an image.

```
ui.image(path, props)
```

**Arguments**

- `path` (*string*, required): The path to the image file to display. Can be a path relative to the main Lua file for the game, or can be an absolute URL of an image on the web.
- `props` (*table*, optional): Same as the props for [box](#box).

**Returns**

This function doesn't return anything.

## Markdown

Displays formatted text based on Markdown source. [react-markdown](https://github.com/rexxars/react-markdown) is used to render the Markdown, so this component supports all of the Markdown syntax supported by it.

Image URLs in the source can be relative to the main Lua file (eg. if you have an image file named 'logo.png' next to your main Lua file, you can use `![](logo.png)` in the Markdown source to display it). Absolute URLs to images on the web are also supported.

```
ui.markdown(source, props)
```

**Arguments**

- `source` (*string*, required): The Markdown source to render
- `props` (*table*, optional): The table of props:
    - *Currently `ui.markdown` doesn't have any props, some may be added later*

**Returns**

This function doesn't return anything.

**Notes**

Since Markdown is indentation-sensitive (code blocks are defined by indent), multi-line Lua strings should be defined without indent for expected behavior. So in the following example, all the contents are rendered as code (due to the indent):

```lua
    ui.markdown([[
        # A heading!

        Some text.
    ]])
```

While in this one, there is a heading and some text:

```lua
    ui.markdown([[
# A heading!

Some text.
    ]])
```

## Number input

Allows the user to input a number. Contains controls to increase or decrease the number incrementally.

```
newValue = ui.numberInput(label, value, props)
```

**Arguments**

- `label` (*string*, required): The label
- `value` (*number*, required): The current value
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the input should be disabled
    - `hideLabel` (*boolean*): Whether to hide the label
    - `min` (*number*): The minimum value
    - `max` (*number*): The maximum value
    - `step` (*number*): How much the value should increase or decrease when clicking the up or down button
    - `invalid` (*boolean*): Whether the value is currently invalid
    - `invalidText` (*string*): An error message to display when the value is invalid
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

**Returns**

- `newValue` (*number*): The new value input by the user. Is equal to `value` if no change occured in this update.

## Radio button group

For selecting from a list of two or more options that are mutually exclusive (only one can be selected).

```
newValue = ui.radioButtonGroup(label, value, items, props)
```

**Arguments**

- `label` (*string*, required): The label
- `value` (*string*, required): The current value. Must be one of the values in `items`.
- `items` (*table*, required): A table containing strings that are possible values for the user to select from. The table is expected to be in the form of a Lua array, eg. `{ 'option1', 'option2', 'option3' }`.
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the input should be disabled
    - `hideLabel` (*boolean*): Whether to hide the label
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

**Returns**

- `newValue` (*string*): The new value input by the user. Is equal to `value` if no change occured in this update.

## Scroll box

Like [box](#box), but when the contents to overflow its size it displays a scroll bar and allows scrolling with the mouse.

```
ui.scrollBox(id, props, inner)
ui.scrollBox(id, inner)
```

**Arguments**

- `id` (*string*, required): An identifying string for this scroll box. Needs to be unique within the parent of the scroll box. This id isn't displayed anywhere and is just used internally to distinguish scroll boxes from each other.
- `props` (*table*, optional): Same as the props for [box](#box).
- `inner` (*function*, required): A function that makes UI calls defining contents of this scroll box. Children are laid out in the direction specified by the `flexDirection` prop. By default the direction is `'column'`.

**Returns**

This function doesn't return anything

## Section

An expandable section with a label, containing more UI components inside. Helps with grouping and reducing clutter.

```
newOpen = ui.section(label, props, inner)
newOpen = ui.section(label, inner)
```

**Arguments**

- `label` (*string*, required): The section title
- `props` (*table*, optional): The table of props:
    - `defaultOpen` (*boolean*): Whether the section should be open when first displayed. Sections are closed initially by default.
    - `open` (*boolean*): Whether the section should be currently open. If you leave this out, the section has normal open / close toggling behavior. If you provide this value, the section always reflects this value. The return value of the function will be `true` if the user clicked on the section to open it, but if you pass `false` for this parameter, it will still not open. Thus, you can override the default behavior.
- `inner` (*function*, required): A function that makes UI calls defining contents of this section.

**Returns**

- `newOpen` (*boolean*): Whether the section is open.

## Slider

Indicates a number visually and allows the user to adjust it by dragging a handle along a horizontal track.

```
newValue = ui.slider(label, value, min, max, props)
```

**Arguments**

- `label` (*string*, required): The label
- `value` (*number*, required): The current value
- `min` (*number*, required): The minimum value
- `max` (*number*, required): The maximum value
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the input should be disabled
    - `hideTextInput` (*boolean*): Whether to hide the number input box that appears next to the slider allowing direct entry
    - `hideLabel` (*boolean*): Whether to hide the label
    - `minLabel` (*string*): The label associated with the minimum value
    - `maxLabel` (*string*): The label associated with the maximum value
    - `step` (*number*): How much the value should increase or decrease when sliding the handle by mouse
    - `stepMultiplier` (*number*): How much the value should increase or decrease when using shift + arrow keys (the actual step will be `(max - min) / stepMultiplier`)
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

**Returns**

- `newValue` (*number*): The new value input by the user. Is equal to `value` if no change occured in this update.

## Tabs

For choosing between multiple views in the same context. There are two functions involved: one is `ui.tabs` which is a parent in which you put a group of tabs, and the other is `ui.tab` which represents each tab in the group and contains the components that should be visible in that tab inside it. So, an example layout of these calls could be:

```lua
ui.tabs('tab group 1', function()
    ui.tab('Tab 1', function()
        -- Content of tab 1
    end)
    ui.tab('Tab 2', function()
        -- Content of tab 2
    end)
end)
```

### `ui.tabs`

```
ui.tabs(id, props, inner)
ui.tabs(id, inner)
```

**Arguments**

- `id` (*string*, required): An identifying string for this tab group. Needs to be unique within the parent of the tab group. This id isn't displayed anywhere and is just used internally to distinguish tab groups from each other.
- `props` (*table*, optional): The table of props:
    - `selected` (*number*): The index of the currently selected tab. Use this if you want to control which tab is selected.
- `inner` (*function*, required): A function that makes `ui.tab` calls defining each tab in this group. Any non-`ui.tab` calls are ignored.

**Returns**

This function doesn't return anything

### `ui.tab`

```
newOpen = ui.tab(label, props, inner)
newOpen = ui.tab(label, inner)
```

**Arguments**

- `label` (*string*, required): The section title
- `props` (*table*, optional): The table of props:
    - *Currently `ui.tabs` doesn't have any props, some may be added later*
- `inner` (*function*, required): A function that makes UI calls defining contents of this tab.

**Returns**

- `newOpen` (*boolean*): Whether this tab is open.

## Text area

Allows the user to input a string. The display for the field is multi-line, so if you expect only short single-line strings to be input prefer using a [text input](#text-input) instead.

```
newValue = ui.textArea(label, value, props)
```

**Arguments**

- `label` (*string*, required): The label
- `value` (*string*, required): The current value
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the input should be disabled
    - `placeholder` (*string*): Text to show when the input is empty. It disappears when the user begins entering data and should not contain crucial information. It does not affect the actual value returned.
    - `rows` (*string*): The initial height of the text area in number of rows of text.
    - `hideLabel` (*boolean*): Whether to hide the label
    - `invalid` (*boolean*): Whether the value is currently invalid
    - `invalidText` (*string*): An error message to display when the value is invalid
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `charCount` (*boolean*): Whether to show the character count
    - `maxLength` (*number*): The maximum allowed value length
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

## Text input

Allows the user to input a string. The display for the field is just a single line, so if you expect multi-line strings to be input prefer using a [text area](#text-area) instead.

```
newValue = ui.textInput(label, value, props)
```

**Arguments**

- `label` (*string*, required): The label
- `value` (*string*, required): The current value
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the input should be disabled
    - `placeholder` (*string*): Text to show when the input is empty. It disappears when the user begins entering data and should not contain crucial information. It does not affect the actual value returned.
    - `hideLabel` (*boolean*): Whether to hide the label
    - `invalid` (*boolean*): Whether the value is currently invalid
    - `invalidText` (*string*): An error message to display when the value is invalid
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `charCount` (*boolean*): Whether to show the character count
    - `maxLength` (*number*): The maximum allowed value length
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

**Returns**

- `newValue` (*string*): The new value input by the user. Is equal to `value` if no change occured in this update.

## Toggle

Allows the user to toggle a boolean state. Toggle switches are generally used if the resulting action immediately affects something in your game without another step. Use a checkbox instead if the input just represents one value in a larger flow that includes a later confirmation step.

```
newToggled = ui.toggle(labelA, labelB, toggled, props)
```

**Arguments**

- `labelA` (*string*, required): The label when in off state
- `labelB` (*string*, required): The label when in on state
- `toggled` (*string*, required): Whether currently on
- `props` (*table*, optional): The table of props:
    - `onToggle` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

**Returns**

- `newValue` (*string*): The new value input by the user. Is equal to `value` if no change occured in this update.
