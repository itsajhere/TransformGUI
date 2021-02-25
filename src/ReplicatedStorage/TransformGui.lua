local uis = game:GetService("UserInputService")
local TransformGui = {}
TransformGui.__index = TransformGui

function TransformGui.new(guiObject: GuiObject, ignoreGuiInsetEnabled: boolean)
	local self = setmetatable({}, TransformGui)
	self.guiObject = guiObject
	self.ignoreGuiInsetEnabled = ignoreGuiInsetEnabled
	self.resizing = false
	self.dragging = false

	-- Events
	self._onResizeBeginEvent = Instance.new("BindableEvent")
	self._onResizeEndedEvent = Instance.new("BindableEvent")
	self._onDragBeginEvent = Instance.new("BindableEvent")
	self._onDragEndedEvent = Instance.new("BindableEvent")
	self.onResizeBegin = self._onResizeBeginEvent.Event
	self.onResizeEnded = self._onResizeEndedEvent.Event
	self.onDragBegin = self._onDragBeginEvent.Event
	self.onDragEnded = self._onDragEndedEvent.Event
	return self
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
	uis.InputChanged:Connect(function(input, r)
		if r then return end
		if moving and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch )then
			local mLocation = uis:GetMouseLocation()
			self.guiObject.Position = UDim2.new(0, mLocation.X, 0, mLocation.Y) + delta
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

function TransformGui:makeResizeable()
	local moving = false
	local oldMousePos = Vector2.new(0, 0)
	local xL = false
	local xR = false
	local yT = false
	local yB = false
	self.guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			local mLocation = uis:GetMouseLocation()
			if not self.ignoreGuiInsetEnabled then 
				mLocation -= Vector2.new(0, 36) 
			end
			if mLocation.X < self.guiObject.AbsolutePosition.X + self.guiObject.AbsoluteSize.X + 5 and mLocation.X > self.guiObject.AbsolutePosition.X + self.guiObject.AbsoluteSize.X - 5 then
				moving = true
				self.resizing = true
				oldMousePos = mLocation
				xR = true
			elseif mLocation.X < self.guiObject.AbsolutePosition.X + 5 and mLocation.X > self.guiObject.AbsolutePosition.X - 5 then
				moving = true
				self.resizing = true
				oldMousePos = mLocation
				xL = true
			elseif mLocation.Y < self.guiObject.AbsolutePosition.Y + self.guiObject.AbsoluteSize.Y + 5 and mLocation.Y > self.guiObject.AbsolutePosition.Y + self.guiObject.AbsoluteSize.Y - 5 then
				moving = true
				self.resizing = true
				oldMousePos = mLocation
				yB = true
			elseif mLocation.Y < self.guiObject.AbsolutePosition.Y + 5 and mLocation.Y > self.guiObject.AbsolutePosition.Y - 5 then
				moving = true
				self.resizing = true
				oldMousePos = mLocation
				yT = true
			end
			if yB or yT or xR or xL then
				self._onResizeBeginEvent:Fire()
			end
		end
	end)
	uis.InputChanged:Connect(function(input, r)
		if r then return end
		if moving and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local mLocation = uis:GetMouseLocation()
			if not self.ignoreGuiInsetEnabled then 
				mLocation -= Vector2.new(0, 36) 
			end
			if xR then
				local delta = mLocation - oldMousePos
				self.guiObject.Size += UDim2.new(0, delta.X, 0, 0)
				oldMousePos = mLocation
			elseif xL then
				local delta = mLocation - oldMousePos
				self.guiObject.Size -= UDim2.new(0, delta.X, 0, 0)
				self.guiObject.Position += UDim2.new(0, delta.X, 0, 0)
				oldMousePos = mLocation
			elseif yT then
				local delta = mLocation - oldMousePos
				self.guiObject.Size -= UDim2.new(0, 0, 0, delta.Y)
				self.guiObject.Position += UDim2.new(0, 0, 0, delta.Y)
				oldMousePos = mLocation
			elseif yB then
				local delta = mLocation - oldMousePos
				self.guiObject.Size += UDim2.new(0, 0, 0, delta.Y)
				oldMousePos = mLocation
			end
		end
	end)
	self.guiObject.InputEnded:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and self.resizing then
			moving = false
			xL = false
			xR = false
			yT = false
			yB = false
			self.resizing = false
			self._onResizeEndedEvent:Fire()
		end
	end)
end

return TransformGui