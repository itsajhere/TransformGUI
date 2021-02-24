# TransformGui
### new
**Description:**

> Creates the TransformGui class.

**Params:**

> ***guiObject:*** the gui object that you want the module to control.

> ***ignoreGuiInsetEnabled:*** whether the ScreenGui's IgnoreGuiInset property is enabled.

```lua
local TransformGui = require(game.ReplicatedStorage.TransformableGui, false)
TransformGui.new(script.Parent.Frame, false)
```


### makeDraggable

**Description:**

> Enables the TransformGui object to be moved with the mouse.

```lua
tGui.makeDraggable()
```


### makeResizeable

**Description:**

> Enables the TransformGui object to be resized from the edges.

```lua
tGui.makeDraggable()
```