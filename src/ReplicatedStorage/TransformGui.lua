local uis = game:GetService("UserInputService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local textures = {
	["Y"] = "rbxasset://textures/StudioUIEditor/icon_resize4.png",
	["X"] = "rbxasset://textures/StudioUIEditor/icon_resize2.png",
	["CornerTLBR"] = "rbxasset://textures/StudioUIEditor/icon_resize3.png",
	["CornerBLTR"] = "rbxasset://textures/StudioUIEditor/icon_resize1.png",
}

local TransformGui = {}
TransformGui.__index = TransformGui

function TransformGui.new(guiObject: GuiObject, frameProperty: string, isTopBarEnabled: boolean)
	local self = setmetatable({}, TransformGui)
	self.guiObject = guiObject
	self.isTopBarEnabled = isTopBarEnabled or true
	self.resizing = false
	self.dragging = false
	
	-- Events
	self._onResizeBeginEvent = Instance.new("BindableEvent")
	self._onResizeChangedEvent = Instance.new("BindableEvent")
	self._onResizeEndedEvent = Instance.new("BindableEvent")
	self._onDragBeginEvent = Instance.new("BindableEvent")
	self._onDragChangedEvent = Instance.new("BindableEvent")
	self._onDragEndedEvent = Instance.new("BindableEvent")
	self.onResizeBegin = self._onResizeBeginEvent.Event
	self.onResizeChanged = self._onResizeChangedEvent.Event
	self.onResizeEnded = self._onResizeEndedEvent.Event
	self.onDragBegin = self._onDragBeginEvent.Event
	self.onDragChanged = self._onDragChangedEvent.Event
	self.onDragEnded = self._onDragEndedEvent.Event
	
	self:ApplyFrameProperties(frameProperty)
	
	return self
end

function TransformGui:ApplyFrameProperties(property)
	if property == "Resize" then
		self:makeResizeable()
	elseif property == "Drag" then
		self:makeDraggable()
	elseif property == "ResizeDrag" then
		self:makeResizeable()
		self:makeDraggable()
	end
end

function TransformGui:makeDraggable()
	local moving = false
	local delta = nil
	self.guiObject.InputBegan:Connect(function(input)
		if self.resizing then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			moving = true
			local mLocation = uis:GetMouseLocation()
			delta = self.guiObject.Position - UDim2.new(0, mLocation.X, 0, mLocation.Y)
			self.dragging = true
			self._onDragBeginEvent:Fire()
		end
	end)
	uis.InputChanged:Connect(function(input)
		if self.resizing then return end
		if moving and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local mLocation = uis:GetMouseLocation()
			self.guiObject.Position = UDim2.new(0, mLocation.X, 0, mLocation.Y) + delta
			self._onDragChangedEvent:Fire()
		end
	end)
	self.guiObject.InputEnded:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and self.dragging then
			moving = false
			delta = nil
			self.dragging = false
			self._onDragEndedEvent:Fire()
		end
	end)
end

function inRange(n1, n2, range)
	return n1 > n2 - range/2 and n1 < n2 + range/2
end

function TransformGui:makeResizeable()
	local moving = false
	local oldMousePos = Vector2.new(0, 0)
	local isValid = {{false, false}, {false, false}}
	-- L = Left, R = Right, T = Top, B = Bottom
	local xL = false
	local xR = false
	local yT = false
	local yB = false
	local prevMouseIcon = Mouse.Icon
	uis.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			local mLocation = uis:GetMouseLocation()
			if self.isTopBarEnabled then 
				mLocation -= Vector2.new(0, 36) 
			end
			local absPos = self.guiObject.AbsolutePosition -- Top Left
			local absSize = self.guiObject.AbsoluteSize
			local endPos = absPos + absSize -- Bottom Right
			xR = inRange(mLocation.X, absPos.X + absSize.X, 10) and inRange(mLocation.Y, absPos.Y + absSize.Y/2, absSize.Y + 10)
			xL = not xR and inRange(mLocation.X, absPos.X, 10) and inRange(mLocation.Y, absPos.Y + absSize.Y/2, absSize.Y + 10)
			yB = inRange(mLocation.Y, absPos.Y + absSize.Y, 10) and inRange(mLocation.X, absPos.X + absSize.X/2, absSize.X + 10)
			yT = inRange(mLocation.Y, absPos.Y, 10) and inRange(mLocation.X, absPos.X + absSize.X/2, absSize.X + 10)
			
			if yB or yT or xR or xL then
				Mouse.Icon = (xR or xL) and not (yB or yT) and textures.X or
					(yB or yT) and not (xR or xL) and textures.Y or
					((yT and xL) or (yB and xR)) and textures.CornerTLBR or
					((yB and xL) or (yT and xR)) and textures.CornerBLTR
				self.resizing = true
				moving = true
				oldMousePos = mLocation
				self._onResizeBeginEvent:Fire()
			end
		end
	end)
	uis.InputChanged:Connect(function(input)
		if moving and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local mLocation = uis:GetMouseLocation()
			if self.isTopBarEnabled then 
				mLocation -= Vector2.new(0, 36) 
			end
			if xR then
				local delta = mLocation - oldMousePos
				self.guiObject.Size += UDim2.new(0, delta.X, 0, 0)
			elseif xL then
				local delta = mLocation - oldMousePos
				self.guiObject.Size -= UDim2.new(0, delta.X, 0, 0)
				self.guiObject.Position += UDim2.new(0, delta.X, 0, 0)
			end
			
			if yT then
				local delta = mLocation - oldMousePos
				self.guiObject.Size -= UDim2.new(0, 0, 0, delta.Y)
				self.guiObject.Position += UDim2.new(0, 0, 0, delta.Y)
			elseif yB then
				local delta = mLocation - oldMousePos
				self.guiObject.Size += UDim2.new(0, 0, 0, delta.Y)
			end
			
			oldMousePos = mLocation
			self._onResizeChangedEvent:Fire()
		end
	end)
	uis.InputEnded:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and self.resizing then
			moving = false
			xL = false
			xR = false
			yT = false
			yB = false
			self.resizing = false
			Mouse.Icon = prevMouseIcon
			self._onResizeEndedEvent:Fire()
		end
	end)
end

return TransformGui
