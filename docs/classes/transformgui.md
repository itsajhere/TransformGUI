# TransformGui
## Methods
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
TransformGui:makeDraggable()
```


### makeResizeable

**Description:**

> Enables the TransformGui object to be resized from the edges.

```lua
TransformGui:makeResizeable()
```

## Events
### onDragBegin
**Description:**

> Fires when the user starts dragging the guiObject.

```lua
TransformGui.onDragBegin:Connect(function()
end)
```

### onDragChanged
**Description:**

> Fires when the user drags the guiObject after it has started being dragged.

```lua
TransformGui.onDragChanged:Connect(function()
end)
```

### onDragEnded
**Description:**

> Fires when the user finishes dragging the guiObject.

```lua
TransformGui.onDragEnded:Connect(function()
end)
```

### onResizeBegin
**Description:**

> Fires when the user starts resizing the guiObject.

```lua
TransformGui.onResizeBegin:Connect(function()
end)
```

### onResizeChanged
**Description:**

> Fires when the user resizes the guiObject after it has started being resized.

```lua
TransformGui.onDragChanged:Connect(function()
end)
```

### onResizeEnded
**Description:**

> Fires when the user finishes resizing the guiObject.

```lua
TransformGui.onResizeEnded:Connect(function()
end)
```