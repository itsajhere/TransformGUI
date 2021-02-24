# Transform GUI
### Installation
Insert [this](https://github.com/itsajhere/transformgui/releases) model into ReplicatedStorage.
### Basic Usage
Create a ScreenGui inside StarterGui with a Frame inside. Create a LocalScript and add the following code.
```lua
local TransformGui = require(game.ReplicatedStorage.TransformGui)
local tGui = TransformGui.new(script.Parent.Frame, false)
tGui:makeDraggable()
```
The code should make the GUI draggable with your mouse.
If this works then you're all set to go.

**TransformGui is in early beta and will get more features very soon.**