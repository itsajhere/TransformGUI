local TransformGui = require(game.ReplicatedStorage.Source.TransformGui)

local sGui = Instance.new("ScreenGui", script.Parent.Parent);

-- Drag
do
	local t = Instance.new("TextLabel", sGui)
	t.Size = UDim2.new(0, 200, 0, 100)
	t.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	t.Text = "Drag Me"
	t.Font = Enum.Font.GothamBold
	t.TextScaled = true
	t.TextColor3 = Color3.fromRGB(255, 255, 255)

	local pad = Instance.new("UIPadding", t)
	pad.PaddingTop = UDim.new(0.2, 0)
	pad.PaddingLeft = UDim.new(0.2, 0)
	pad.PaddingRight = UDim.new(0.2, 0)
	pad.PaddingBottom = UDim.new(0.2, 0)

	Instance.new("UICorner", t)
	local tGui = TransformGui.new(t, false)
	tGui:makeDraggable()
	tGui.onDragBegin:Connect(function()
		print("Drag Begin")
	end)
	tGui.onDragEnded:Connect(function()
		print("Drag End")
	end)
end
do
	local t = Instance.new("TextLabel", sGui)
	t.Size = UDim2.new(0, 200, 0, 100)
	t.Position = UDim2.new(0, 250, 0, 0)
	t.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	t.Text = "Resize Me"
	t.Font = Enum.Font.GothamBold
	t.TextScaled = true
	t.TextColor3 = Color3.fromRGB(255, 255, 255)

	local pad = Instance.new("UIPadding", t)
	pad.PaddingTop = UDim.new(0.2, 0)
	pad.PaddingLeft = UDim.new(0.2, 0)
	pad.PaddingRight = UDim.new(0.2, 0)
	pad.PaddingBottom = UDim.new(0.2, 0)

	Instance.new("UICorner", t)

	local tGui = TransformGui.new(t, false)
	tGui:makeResizeable()
	tGui.onResizeBegin:Connect(function()
		print("Resize Begin")
	end)
	tGui.onResizeEnded:Connect(function()
		print("Resize End")
	end)
end
do
	local t = Instance.new("TextLabel", sGui)
	t.Size = UDim2.new(0, 300, 0, 100)
	t.Position = UDim2.new(0, 500, 0, 0)
	t.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	t.Text = "Drag & Resize Me"
	t.Font = Enum.Font.GothamBold
	t.TextScaled = true
	t.TextColor3 = Color3.fromRGB(255, 255, 255)

	local pad = Instance.new("UIPadding", t)
	pad.PaddingTop = UDim.new(0.2, 0)
	pad.PaddingLeft = UDim.new(0.2, 0)
	pad.PaddingRight = UDim.new(0.2, 0)
	pad.PaddingBottom = UDim.new(0.2, 0)

	Instance.new("UICorner", t)

	local tGui = TransformGui.new(t, false)
	tGui:makeDraggable()
	tGui:makeResizeable()
	tGui.onDragBegin:Connect(function()
		print("Drag Begin")
	end)
	tGui.onDragEnded:Connect(function()
		print("Drag End")
	end)
	tGui.onResizeBegin:Connect(function()
		print("Resize Begin")
	end)
	tGui.onResizeEnded:Connect(function()
		print("Resize End")
	end)
end