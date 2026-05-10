local gui = Instance.new("ScreenGui")
gui.Name = "ScriptTradeVisual"
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, 620, 0, 380)
main.Position = UDim2.new(0.5, -310, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(12,12,12)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0,20)

local stroke = Instance.new("UIStroke")
stroke.Parent = main
stroke.Color = Color3.fromRGB(40,40,40)
stroke.Thickness = 1.5

local title = Instance.new("TextLabel")
title.Parent = main
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,0,0,50)
title.Position = UDim2.new(0,0,0,15)
title.Font = Enum.Font.GothamBold
title.Text = "Script Trade Visual"
title.TextSize = 32
title.TextColor3 = Color3.fromRGB(255,255,255)

local subtitle = Instance.new("TextLabel")
subtitle.Parent = main
subtitle.BackgroundTransparency = 1
subtitle.Size = UDim2.new(1,0,0,20)
subtitle.Position = UDim2.new(0,0,0,50)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "modern local interface"
subtitle.TextSize = 14
subtitle.TextColor3 = Color3.fromRGB(120,120,120)

local tabs = Instance.new("Frame")
tabs.Parent = main
tabs.BackgroundTransparency = 1
tabs.Position = UDim2.new(0,25,0,90)
tabs.Size = UDim2.new(1,-50,0,50)

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = tabs
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0,12)

local function createTab(text, selected)
	local btn = Instance.new("TextButton")
	btn.Parent = tabs
	btn.Size = UDim2.new(0,130,1,0)
	btn.BackgroundColor3 = selected and Color3.fromRGB(90,50,180) or Color3.fromRGB(22,22,22)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.new(1,1,1)
	btn.AutoButtonColor = false
	
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,14)

	local s = Instance.new("UIStroke")
	s.Parent = btn
	s.Color = selected and Color3.fromRGB(140,100,255) or Color3.fromRGB(35,35,35)

	return btn
end

createTab("SPAWN", true)
createTab("TRADE", false)
createTab("VISUAL", false)
createTab("SETTINGS", false)

local label = Instance.new("TextLabel")
label.Parent = main
label.BackgroundTransparency = 1
label.Position = UDim2.new(0,30,0,165)
label.Size = UDim2.new(0,250,0,25)
label.Font = Enum.Font.GothamMedium
label.Text = "Selected Brainrot"
label.TextSize = 15
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextColor3 = Color3.fromRGB(150,150,150)

local box = Instance.new("TextBox")
box.Parent = main
box.Position = UDim2.new(0,30,0,195)
box.Size = UDim2.new(0,390,0,50)
box.BackgroundColor3 = Color3.fromRGB(18,18,18)
box.PlaceholderText = "John Pork"
box.Text = ""
box.Font = Enum.Font.Gotham
box.TextSize = 18
box.TextColor3 = Color3.new(1,1,1)
box.PlaceholderColor3 = Color3.fromRGB(90,90,90)
box.ClearTextOnFocus = false

Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)

local boxStroke = Instance.new("UIStroke")
boxStroke.Parent = box
boxStroke.Color = Color3.fromRGB(35,35,35)

local traitBtn = Instance.new("TextButton")
traitBtn.Parent = main
traitBtn.Position = UDim2.new(0,440,0,195)
traitBtn.Size = UDim2.new(0,150,0,50)
traitBtn.BackgroundColor3 = Color3.fromRGB(40,20,70)
traitBtn.Text = "TRAITS & MUT"
traitBtn.Font = Enum.Font.GothamBold
traitBtn.TextSize = 15
traitBtn.TextColor3 = Color3.fromRGB(200,160,255)

Instance.new("UICorner", traitBtn).CornerRadius = UDim.new(0,14)

local statusFrame = Instance.new("Frame")
statusFrame.Parent = main
statusFrame.Position = UDim2.new(0,30,0,265)
statusFrame.Size = UDim2.new(1,-60,0,50)
statusFrame.BackgroundColor3 = Color3.fromRGB(10,35,20)

Instance.new("UICorner", statusFrame).CornerRadius = UDim.new(0,14)

local statusStroke = Instance.new("UIStroke")
statusStroke.Parent = statusFrame
statusStroke.Color = Color3.fromRGB(0,170,90)

local status = Instance.new("TextLabel")
status.Parent = statusFrame
status.BackgroundTransparency = 1
status.Size = UDim2.new(1,0,1,0)
status.Font = Enum.Font.GothamBold
status.Text = "✓ Spawned visual locally"
status.TextSize = 17
status.TextColor3 = Color3.fromRGB(120,255,170)

local function createButton(text, color, posX)
	local btn = Instance.new("TextButton")
	btn.Parent = main
	btn.Position = UDim2.new(0,posX,0,330)
	btn.Size = UDim2.new(0,270,0,40)
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.new(1,1,1)
	btn.AutoButtonColor = false
	
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,14)

	return btn
end

local spawn = createButton(
	"SPAWN VISUAL",
	Color3.fromRGB(85,50,180),
	30
)

local clear = createButton(
	"CLEAR ALL",
	Color3.fromRGB(80,20,20),
	320
)

spawn.MouseButton1Click:Connect(function()
	status.Text = "✓ Spawned "..(box.Text ~= "" and box.Text or "Brainrot")
end)

clear.MouseButton1Click:Connect(function()
	box.Text = ""
	status.Text = "✓ Cleared visuals"
end)
