local uis = game:GetService("UserInputService")
local TransformableGui = {}

function TransformableGui.makeDraggable(guiObject)
	local moving = false
	local delta = nil
	guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			moving = true
			local mLocation = uis:GetMouseLocation()
			delta = guiObject.Position - UDim2.new(0, mLocation.X, 0, mLocation.Y)
		end
	end)
	uis.InputChanged:Connect(function(input, r)
		if r then return end
		if moving and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch )then
			local mLocation = uis:GetMouseLocation()
			guiObject.Position = UDim2.new(0, mLocation.X, 0, mLocation.Y) + delta
		end
	end)
	guiObject.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			moving = false
			delta = nil
		end
	end)
end

return TransformableGui
