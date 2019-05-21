# Castle UI API

![Castle UI API](gif.gif)

The Castle UI API allows you to add user interface elements that allow interaction with your game. Castle manages the laying out of your UI relative to the rest of Castle's UI. Uses can range from simple debug tools while developing games to user-facing level editors or text-based adventure games etc.

## Contents

- [Tutorial](#tutorial)
- [Reference](#reference)
  * [Layout](#layout)
    + [Box](box)
    + [Section](#section)
    + [Tabs and Tab](#tabs-and-tab)
  * [Text](#text)
    + [Heading](heading)
    + [Markdown](markdown)
    + [Paragraph](paragraph)
    + [Text](text)
  * [Buttons](#buttons)
    + [Button](button)
  * [Input](#input)
    + [CheckBox](checkbox)
    + [MaskedInput](maskedinput)
    + [RadioButtonGroup](radiobuttongroup)
    + [RangeInput](rangeinput)
    + [Select](select)
    + [TextInput](textinput)
    + [TextArea](textarea)

## Tutorial

To use the UI API, simply define the `castle.uiupdate` function and put your UI calls in it:

```lua
function castle.uiupdate()
      castle.ui.text('Hello, world!')
end
```

Since using UI elements usually involves a lot of calls to functions in the `castle.ui` module, it helps to make a local variable referencing it:

```lua
local ui = castle.ui

function castle.uiupdate()
    ui.text('Hello, world!')
end
```

Elements that work as inputs usually take an id string (to keep track of which element refers to which value) and the current value, then return the new value:

```lua
local ui = castle.ui

local myString = 'Edit me!'

function castle.uiupdate()
    ui.text('Set myString:')
    myString = ui.textArea('myString', myString)
end

function love.draw()
    love.graphics.print('myString:\n' .. myString, 20, 20)
end
```

A 'range input' (shown as a slider) takes the minimum and maximum of the range along with a 'step' to slide the value by when dragging:

```lua
local ui = castle.ui

local myNumber = 20
local myString = 'Edit me!'

function castle.uiupdate()
    ui.text('Set myNumber:')
    myNumber = ui.rangeInput('myNumber', myNumber, 0, 40, 1)

    ui.text('Set myString:')
    myString = ui.textArea('myString', myString)
end

function love.draw()
    love.graphics.print('myNumber: ' .. myNumber, 20, 20)
    love.graphics.print('\n\nmyString:\n' .. myString, 20, 20)
end
```

The components are implemented with [Grommet](https://v2.grommet.io/) and all 'props' are forwarded so you can do some interesting stuff. `inner` arguments are for nesting components -- you just pass a function that makes more UI calls. ids only need to be unique within the parent component. You can also use callbacks for certain events (more docs coming soon!):

```lua
local ui = castle.ui

function castle.uiupdate()
    ui.box({
        pad = 'small',
        gap = 'small',
        border = { color = 'yellow', size = 'large' }
    }, function()
        ui.text('This is some text inside a box!')

        if ui.button('Button 1') then
            print('Button 1 pressed!')
        end

        ui.button('Button 2', {
            onClick = function()
                print('Button 2 pressed!')
            end
        })
    end)
end
```

See the [code for the 'Circles' demo](./circles.lua) for an example of showing UI for many game entities.

## Reference

The headings here link to the Grommet component docs so you can read a description and see all the props available.

### Layout

#### [Box](https://v2.grommet.io/box)

```
ui.box(inner)
ui.box(props)
ui.box(props, inner)
ui.box(id, props, inner)
```

#### Section

```
active = ui.section(label, inner)
active = ui.section(label, props, inner)
```

A single [accordion panel](https://v2.grommet.io/accordion). Decided to go with the name 'section' because I liked it more.

#### [Tabs](https://v2.grommet.io/tabs) and [Tab](https://v2.grommet.io/tab)

```
ui.tabs(inner)
ui.tabs(props, inner)
ui.tabs(id, props, inner)
```

```
active = ui.tab(title, inner)
active = ui.tab(title, props, inner)
```

Use it as follows:

```
ui.tabs(function()
    ui.tab('Tab 1', function()
        ui.text('This text is in tab 1!')
    end)
    ui.tab('Tab 1', function()
        ui.text('This text is in tab 2!')
    end)
end)
```

### Text

#### [Heading](https://v2.grommet.io/heading)

```
ui.heading(text)
ui.heading(props)
ui.heading(text, props)
```

#### [Markdown](https://v2.grommet.io/markdown)

```
ui.markdown(text)
ui.markdown(props)
ui.markdown(text, props)
```

Putting a 'castle://' link in markdown creates a link to a game!

#### [Paragraph](https://v2.grommet.io/paragraph)

```
ui.paragraph(text)
ui.paragraph(props)
ui.paragraph(text, props)
```

#### [Text](https://v2.grommet.io/text)

```
ui.text(text)
ui.text(props)
ui.text(text, props)
```

### Buttons

#### [Button](https://v2.grommet.io/button)

```
clicked = ui.button(label)
clicked = ui.button(label, props)
```

### Input

#### [CheckBox](https://v2.grommet.io/checkbox)

```
newChecked = ui.checkBox(label, checked, props)
newChecked = ui.checkBox(checked, props)
newChecked = ui.checkBox(label, checked)
newChecked = ui.checkBox(props) -- Known bug: this variant always returns `nil`, will fix
```

#### [MaskedInput](https://v2.grommet.io/maskedinput)

```
newValue = ui.maskedInput(id, value, props)
newValue = ui.maskedInput(value, props)
newValue = ui.maskedInput(id, value)
newValue = ui.maskedInput(props) -- Known bug: this variant always returns `nil`, will fix
```

#### [RadioButtonGroup](https://v2.grommet.io/radiobuttongroup)

```
newValue = ui.radioButtonGroup(id, value, options)
newValue = ui.radioButtonGroup(id, value, options, props)
newValue = ui.radioButtonGroup(props) -- Known bug: this variant always returns `nil`, will fix
```

#### [RangeInput](https://v2.grommet.io/rangeinput)

```
newValue = ui.rangeInput(id, value, min, max, step)
newValue = ui.rangeInput(id, value, min, max, step, props)
newValue = ui.rangeInput(props) -- Known bug: this variant always returns `nil`, will fix
```

#### [Select](https://v2.grommet.io/select)

```
newValue = ui.select(id, value, options)
newValue = ui.select(id, value, options, props)
newValue = ui.select(props) -- Known bug: this variant always returns `nil`, will fix
```

#### [TextInput](https://v2.grommet.io/textinput)

```
newValue = ui.textInput(id, value, props)
newValue = ui.textInput(value, props)
newValue = ui.textInput(id, value)
newValue = ui.textInput(value)
newValue = ui.textInput(props) -- Known bug: this variant always returns `nil`, will fix
```

#### [TextArea](https://v2.grommet.io/textarea)

```
newValue = ui.textArea(id, value, props)
newValue = ui.textArea(value, props)
newValue = ui.textArea(id, value)
newValue = ui.textArea(value)
newValue = ui.textArea(props) -- Known bug: this variant always returns `nil`, will fix
```
