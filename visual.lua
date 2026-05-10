local gui = Instance.new("ScreenGui")
gui.Name = "TradeVisual"
gui.Parent = game.CoreGui

-- MAIN FRAME

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,305,0,235)
main.Position = UDim2.new(0.5,-152,0.5,-117)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(45,45,45)

-- TITLE

local title = Instance.new("TextLabel")
title.Parent = main
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,0,0,30)
title.Position = UDim2.new(0,0,0,6)
title.Font = Enum.Font.GothamBlack
title.Text = "Trade Visual Script"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 18

-- TABS

local tabs = Instance.new("Frame")
tabs.Parent = main
tabs.BackgroundTransparency = 1
tabs.Position = UDim2.new(0,12,0,42)
tabs.Size = UDim2.new(1,-24,0,28)

local layout = Instance.new("UIListLayout", tabs)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.Padding = UDim.new(0,6)

local function makeTab(txt)
	local b = Instance.new("TextButton")
	b.Parent = tabs
	b.Size = UDim2.new(0,62,1,0)
	b.BackgroundColor3 = Color3.fromRGB(22,22,22)
	b.Text = txt
	b.Font = Enum.Font.GothamBlack
	b.TextColor3 = Color3.new(1,1,1)
	b.TextSize = 11
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	return b
end

local spawnTab = makeTab("SPAWN")
local tradeTab = makeTab("TRADE")
local dupeTab = makeTab("DUPE")
local settingsTab = makeTab("SETTINGS")

-- LABEL

local lbl = Instance.new("TextLabel")
lbl.Parent = main
lbl.BackgroundTransparency = 1
lbl.Position = UDim2.new(0,12,0,76)
lbl.Size = UDim2.new(0,150,0,16)
lbl.Font = Enum.Font.GothamBold
lbl.Text = "ANIMAL TO SPAWN"
lbl.TextColor3 = Color3.fromRGB(120,120,120)
lbl.TextSize = 11
lbl.TextXAlignment = Enum.TextXAlignment.Left

-- TEXTBOX

local box = Instance.new("TextBox")
box.Parent = main
box.Position = UDim2.new(0,12,0,95)
box.Size = UDim2.new(0,200,0,24)
box.BackgroundColor3 = Color3.fromRGB(16,16,16)
box.Text = "Antonio"
box.Font = Enum.Font.GothamBold
box.TextColor3 = Color3.new(1,1,1)
box.TextSize = 12
box.ClearTextOnFocus = false

Instance.new("UICorner", box).CornerRadius = UDim.new(0,5)

-- TRAITS BUTTON

local traits = Instance.new("TextButton")
traits.Parent = main
traits.Position = UDim2.new(0,220,0,95)
traits.Size = UDim2.new(0,72,0,24)
traits.BackgroundColor3 = Color3.fromRGB(45,20,70)
traits.Text = "TRAITS &\nMUT"
traits.Font = Enum.Font.GothamBlack
traits.TextColor3 = Color3.fromRGB(190,120,255)
traits.TextSize = 8

Instance.new("UICorner", traits).CornerRadius = UDim.new(0,5)

-- STATUS

local status = Instance.new("TextLabel")
status.Parent = main
status.BackgroundTransparency = 1
status.Position = UDim2.new(0,10,0,138)
status.Size = UDim2.new(1,-20,0,32)
status.Font = Enum.Font.GothamBlack
status.Text = "NO EMPTY PODIUMS!"
status.TextColor3 = Color3.fromRGB(255,40,40)
status.TextSize = 10
status.TextWrapped = true
status.TextYAlignment = Enum.TextYAlignment.Top

-- BUTTON FUNCTION

local function makeButton(txt,color,x,y)
	local b = Instance.new("TextButton")
	b.Parent = main
	b.Position = UDim2.new(0,x,0,y)
	b.Size = UDim2.new(0,132,0,28)
	b.BackgroundColor3 = color
	b.Text = txt
	b.Font = Enum.Font.GothamBlack
	b.TextColor3 = Color3.new(1,1,1)
	b.TextSize = 13
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	return b
end

local spawn = makeButton(
	"SPAWN VISUAL",
	Color3.fromRGB(0,130,0),
	12,
	170
)

spawn.MouseButton1Click:Connect(function()

	status.Text = "É necessário um pet de tier alto na base. Ex: Garama, Dragon Cannelloni."
	status.TextColor3 = Color3.fromRGB(255,60,60)

end)
local spawn = makeButton("SPAWN VISUAL",Color3.fromRGB(0,130,0),12,170)

local clear = makeButton("CLEAR ALL",Color3.fromRGB(100,0,0),160,170)

local savecfg = makeButton("SAVE CONFIG",Color3.fromRGB(0,50,140),12,203)

local deletecfg = makeButton("DELETE CONFIG",Color3.fromRGB(100,0,0),160,203)

spawn.MouseButton1Click:Connect(function()

	status.Text = "É necessário um pet de tier alto na base. Ex: Garama, Dragon Cannelloni."
	status.TextColor3 = Color3.fromRGB(255,60,60)

end)

clear.MouseButton1Click:Connect(function()

	status.Text = "Visuais removidos."
	status.TextColor3 = Color3.fromRGB(255,255,255)

end)

savecfg.MouseButton1Click:Connect(function()

	status.Text = "Configuração salva com sucesso."
	status.TextColor3 = Color3.fromRGB(120,255,120)

end)

deletecfg.MouseButton1Click:Connect(function()

	status.Text = "Configuração removida."
	status.TextColor3 = Color3.fromRGB(255,80,80)

end)

-- TRADE MENU

local tradeMenu = Instance.new("Frame")
tradeMenu.Parent = gui
tradeMenu.Size = UDim2.new(0,305,0,250)
tradeMenu.Position = UDim2.new(0.5,-152,0.5,-125)
tradeMenu.BackgroundColor3 = Color3.fromRGB(10,10,10)
tradeMenu.Visible = false
tradeMenu.Active = true
tradeMenu.Draggable = true

Instance.new("UICorner", tradeMenu).CornerRadius = UDim.new(0,12)

local tradeStroke = Instance.new("UIStroke", tradeMenu)
tradeStroke.Color = Color3.fromRGB(45,45,45)

local tradeTitle = Instance.new("TextLabel")
tradeTitle.Parent = tradeMenu
tradeTitle.BackgroundTransparency = 1
tradeTitle.Size = UDim2.new(1,0,0,35)
tradeTitle.Position = UDim2.new(0,0,0,5)
tradeTitle.Font = Enum.Font.GothamBlack
tradeTitle.Text = "Trade Visual Script"
tradeTitle.TextColor3 = Color3.new(1,1,1)
tradeTitle.TextSize = 18
-- PLAYER USERNAME

local playerLabel = Instance.new("TextLabel")
playerLabel.Parent = tradeMenu
playerLabel.BackgroundTransparency = 1
playerLabel.Position = UDim2.new(0,12,0,76)
playerLabel.Size = UDim2.new(0,160,0,16)
playerLabel.Font = Enum.Font.GothamBold
playerLabel.Text = "PLAYER USERNAME"
playerLabel.TextColor3 = Color3.fromRGB(120,120,120)
playerLabel.TextSize = 11
playerLabel.TextXAlignment = Enum.TextXAlignment.Left

-- USER INPUT

local usernameBox = Instance.new("TextBox")
usernameBox.Parent = tradeMenu
usernameBox.Position = UDim2.new(0,12,0,95)
usernameBox.Size = UDim2.new(1,-24,0,28)
usernameBox.BackgroundColor3 = Color3.fromRGB(16,16,16)
usernameBox.PlaceholderText = "enter username..."
usernameBox.Text = ""
usernameBox.Font = Enum.Font.GothamBold
usernameBox.TextColor3 = Color3.new(1,1,1)
usernameBox.PlaceholderColor3 = Color3.fromRGB(90,90,90)
usernameBox.TextSize = 12
usernameBox.ClearTextOnFocus = false

Instance.new("UICorner", usernameBox).CornerRadius = UDim.new(0,6)

-- RECEIVE TRADE BUTTON

local receiveTrade = Instance.new("TextButton")
receiveTrade.Parent = tradeMenu
receiveTrade.Position = UDim2.new(0,12,0,135)
receiveTrade.Size = UDim2.new(1,-24,0,32)
receiveTrade.BackgroundColor3 = Color3.fromRGB(0,110,0)
receiveTrade.Text = "RECEBER TRADE DESSE PLAYER"
receiveTrade.Font = Enum.Font.GothamBlack
receiveTrade.TextColor3 = Color3.new(1,1,1)
receiveTrade.TextSize = 13
receiveTrade.AutoButtonColor = false

Instance.new("UICorner", receiveTrade).CornerRadius = UDim.new(0,6)

-- FORCE ACCEPT BUTTON

local forceAccept = Instance.new("TextButton")
forceAccept.Parent = tradeMenu
forceAccept.Position = UDim2.new(0,12,0,175)
forceAccept.Size = UDim2.new(1,-24,0,32)
forceAccept.BackgroundColor3 = Color3.fromRGB(120,0,0)
forceAccept.Text = "FORÇAR ACEITAR A TRADE"
forceAccept.Font = Enum.Font.GothamBlack
forceAccept.TextColor3 = Color3.new(1,1,1)
forceAccept.TextSize = 13
forceAccept.AutoButtonColor = false

Instance.new("UICorner", forceAccept).CornerRadius = UDim.new(0,6)

-- STATUS

local tradeStatus = Instance.new("TextLabel")
tradeStatus.Parent = tradeMenu
tradeStatus.BackgroundTransparency = 1
tradeStatus.Position = UDim2.new(0,0,0,215)
tradeStatus.Size = UDim2.new(1,0,0,18)
tradeStatus.Font = Enum.Font.GothamBold
tradeStatus.Text = "waiting..."
tradeStatus.TextColor3 = Color3.fromRGB(120,255,120)
tradeStatus.TextSize = 11

-- BUTTON FUNCTIONS

receiveTrade.MouseButton1Click:Connect(function()
	if usernameBox.Text ~= "" then
		tradeStatus.Text = "trade recebida de "..usernameBox.Text
	end
end)

forceAccept.MouseButton1Click:Connect(function()
	if usernameBox.Text ~= "" then
		tradeStatus.Text = "trade aceita com "..usernameBox.Text
	end
end)

local userLbl = Instance.new("TextLabel")
userLbl.Parent = tradeMenu
userLbl.BackgroundTransparency = 1
userLbl.Position = UDim2.new(0,12,0,76)
userLbl.Size = UDim2.new(0,160,0,16)
userLbl.Font = Enum.Font.GothamBold
userLbl.Text = "PLAYER USERNAME"
userLbl.TextColor3 = Color3.fromRGB(120,120,120)
userLbl.TextSize = 11
userLbl.TextXAlignment = Enum.TextXAlignment.Left

local userBox = Instance.new("TextBox")
userBox.Parent = tradeMenu
userBox.Position = UDim2.new(0,12,0,94)
userBox.Size = UDim2.new(0,255,0,26)
userBox.BackgroundColor3 = Color3.fromRGB(16,16,16)
userBox.PlaceholderText = "enter username..."
userBox.Font = Enum.Font.GothamBold
userBox.TextColor3 = Color3.new(1,1,1)
userBox.TextSize = 12

Instance.new("UICorner", userBox).CornerRadius = UDim.new(0,5)

local meBtn = Instance.new("TextButton")
meBtn.Parent = tradeMenu
meBtn.Position = UDim2.new(0,272,0,94)
meBtn.Size = UDim2.new(0,22,0,26)
meBtn.BackgroundColor3 = Color3.fromRGB(50,40,120)
meBtn.Text = "ME"
meBtn.Font = Enum.Font.GothamBlack
meBtn.TextColor3 = Color3.new(1,1,1)
meBtn.TextSize = 9

Instance.new("UICorner", meBtn).CornerRadius = UDim.new(1,0)

-- DUPE MENU

local dupeMenu = Instance.new("Frame")
dupeMenu.Parent = gui
dupeMenu.Size = UDim2.new(0,305,0,220)
dupeMenu.Position = UDim2.new(0.5,-152,0.5,-110)
dupeMenu.BackgroundColor3 = Color3.fromRGB(10,10,10)
dupeMenu.Visible = false

Instance.new("UICorner", dupeMenu).CornerRadius = UDim.new(0,12)

local dupeTitle = Instance.new("TextLabel")
dupeTitle.Parent = dupeMenu
dupeTitle.BackgroundTransparency = 1
dupeTitle.Size = UDim2.new(1,0,0,35)
dupeTitle.Font = Enum.Font.GothamBlack
dupeTitle.Text = "DUPE PANEL"
dupeTitle.TextColor3 = Color3.new(1,1,1)
dupeTitle.TextSize = 20

local dupeLabel = Instance.new("TextLabel")
dupeLabel.Parent = dupeMenu
dupeLabel.BackgroundTransparency = 1
dupeLabel.Position = UDim2.new(0,12,0,55)
dupeLabel.Size = UDim2.new(0,220,0,18)
dupeLabel.Font = Enum.Font.GothamBold
dupeLabel.Text = "SELECIONE O PET QUE DESEJA DUPAR"
dupeLabel.TextColor3 = Color3.fromRGB(120,120,120)
dupeLabel.TextSize = 11
dupeLabel.TextXAlignment = Enum.TextXAlignment.Left

local dupeBox = Instance.new("TextBox")
dupeBox.Parent = dupeMenu
dupeBox.Position = UDim2.new(0,12,0,78)
dupeBox.Size = UDim2.new(1,-24,0,28)
dupeBox.BackgroundColor3 = Color3.fromRGB(16,16,16)
dupeBox.PlaceholderText = "Digite o nome do pet..."
dupeBox.Text = ""
dupeBox.Font = Enum.Font.GothamBold
dupeBox.TextColor3 = Color3.new(1,1,1)
dupeBox.PlaceholderColor3 = Color3.fromRGB(90,90,90)
dupeBox.TextSize = 12
dupeBox.ClearTextOnFocus = false

Instance.new("UICorner", dupeBox).CornerRadius = UDim.new(0,6)

local dupeButton = Instance.new("TextButton")
dupeButton.Parent = dupeMenu
dupeButton.Position = UDim2.new(0,12,0,120)
dupeButton.Size = UDim2.new(1,-24,0,32)
dupeButton.BackgroundColor3 = Color3.fromRGB(0,120,0)
dupeButton.Text = "INICIAR DUPE"
dupeButton.Font = Enum.Font.GothamBlack
dupeButton.TextColor3 = Color3.new(1,1,1)
dupeButton.TextSize = 14

Instance.new("UICorner", dupeButton).CornerRadius = UDim.new(0,6)

local dupeStatus = Instance.new("TextLabel")
dupeStatus.Parent = dupeMenu
dupeStatus.BackgroundTransparency = 1
dupeStatus.Position = UDim2.new(0,12,0,165)
dupeStatus.Size = UDim2.new(1,-24,0,35)
dupeStatus.Font = Enum.Font.GothamBold
dupeStatus.Text = "Requisitos mínimos: Garama ou pets acima de 1B. Limite máximo: 3 Dragons por execução."
dupeStatus.TextColor3 = Color3.fromRGB(120,255,120)
dupeStatus.TextSize = 11
dupeStatus.TextWrapped = true

dupeButton.MouseButton1Click:Connect(function()

	dupeStatus.Text = "O pet não encontra-se na sua base para duplicar."
	dupeStatus.TextColor3 = Color3.fromRGB(255,60,60)

end)

-- SETTINGS MENU

local settingsMenu = Instance.new("Frame")
settingsMenu.Parent = gui
settingsMenu.Size = UDim2.new(0,305,0,220)
settingsMenu.Position = UDim2.new(0.5,-152,0.5,-110)
settingsMenu.BackgroundColor3 = Color3.fromRGB(10,10,10)
settingsMenu.Visible = false

Instance.new("UICorner", settingsMenu).CornerRadius = UDim.new(0,12)

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Parent = settingsMenu
settingsTitle.BackgroundTransparency = 1
settingsTitle.Size = UDim2.new(1,0,0,35)
settingsTitle.Font = Enum.Font.GothamBlack
settingsTitle.Text = "SETTINGS"
settingsTitle.TextColor3 = Color3.new(1,1,1)
settingsTitle.TextSize = 20

-- TAB SYSTEM

local function hideAll()
	main.Visible = false
	tradeMenu.Visible = false
	dupeMenu.Visible = false
	settingsMenu.Visible = false
end

spawnTab.MouseButton1Click:Connect(function()
	hideAll()
	main.Visible = true
end)

tradeTab.MouseButton1Click:Connect(function()
	hideAll()
	tradeMenu.Visible = true
end)

dupeTab.MouseButton1Click:Connect(function()
	hideAll()
	dupeMenu.Visible = true
end)

settingsTab.MouseButton1Click:Connect(function()
	hideAll()
	settingsMenu.Visible = true
end)

meBtn.MouseButton1Click:Connect(function()
	userBox.Text = game.Players.LocalPlayer.Name
end)
local function createBackButton(parent)
	local back = Instance.new("TextButton")
	back.Parent = parent
	back.Size = UDim2.new(0,24,0,24)
	back.Position = UDim2.new(0,8,0,8)
	back.BackgroundColor3 = Color3.fromRGB(20,20,20)
	back.Text = "<"
	back.Font = Enum.Font.GothamBlack
	back.TextColor3 = Color3.new(1,1,1)
	back.TextSize = 16
	back.AutoButtonColor = false

	Instance.new("UICorner", back).CornerRadius = UDim.new(1,0)

	back.MouseButton1Click:Connect(function()
		tradeMenu.Visible = false
		dupeMenu.Visible = false
		settingsMenu.Visible = false
		main.Visible = true
	end)
end

createBackButton(tradeMenu)
createBackButton(dupeMenu)
createBackButton(settingsMenu)
for _,v in pairs(game.CoreGui.TradeVisual.Frame:GetDescendants()) do
	if v:IsA("TextButton") and v.Text == "SPAWN VISUAL" then

		v.MouseButton1Click:Connect(function()

			local status = game.CoreGui.TradeVisual.Frame:FindFirstChildWhichIsA("TextLabel", true)

			if status then
				status.Text = "É necessário um pet de tier alto na base. Ex: Garama, Dragon Cannelloni."
				status.TextColor3 = Color3.fromRGB(255,60,60)
			end

		end)

	end
end
-- TRAITS PANEL

local selectedMutations = {}
local maxMutations = 11

local mutPanel = Instance.new("Frame")
mutPanel.Parent = gui
mutPanel.Size = UDim2.new(0,320,0,360)
mutPanel.Position = UDim2.new(0.5,-160,0.5,-180)
mutPanel.BackgroundColor3 = Color3.fromRGB(10,10,10)
mutPanel.Visible = false
mutPanel.Active = true
mutPanel.Draggable = true

Instance.new("UICorner", mutPanel).CornerRadius = UDim.new(0,12)

local mutStroke = Instance.new("UIStroke", mutPanel)
mutStroke.Color = Color3.fromRGB(45,45,45)

local mutTitle = Instance.new("TextLabel")
mutTitle.Parent = mutPanel
mutTitle.BackgroundTransparency = 1
mutTitle.Size = UDim2.new(1,0,0,35)
mutTitle.Font = Enum.Font.GothamBlack
mutTitle.Text = "TRAITS & MUTATIONS"
mutTitle.TextColor3 = Color3.new(1,1,1)
mutTitle.TextSize = 18

local mutStatus = Instance.new("TextLabel")
mutStatus.Parent = mutPanel
mutStatus.BackgroundTransparency = 1
mutStatus.Position = UDim2.new(0,0,1,-25)
mutStatus.Size = UDim2.new(1,0,0,18)
mutStatus.Font = Enum.Font.GothamBold
mutStatus.Text = "0/11 selecionadas"
mutStatus.TextColor3 = Color3.fromRGB(180,180,180)
mutStatus.TextSize = 11

local scroll = Instance.new("ScrollingFrame")
scroll.Parent = mutPanel
scroll.Position = UDim2.new(0,10,0,40)
scroll.Size = UDim2.new(1,-20,1,-75)
scroll.CanvasSize = UDim2.new(0,0,0,600)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3

local grid = Instance.new("UIGridLayout")
grid.Parent = scroll
grid.CellSize = UDim2.new(0,90,0,32)
grid.CellPadding = UDim2.new(0,6,0,6)

local mutations = {
	"Gold",
	"Diamond",
	"Rainbow",
	"Bloodrot",
	"Candy",
	"Lava",
	"Galaxy",
	"Yin Yang",
	"Radioactive",
	"Cursed",
	"Divine",
	"Celestial",
	"Chocolate",
	"Void",
	"Toxic",
	"Darkness",
	"Lovely",
	"Christmas",
	"Crystal",
	"Heaven",
	"Neon",
	"Aqua",
	"Dreamy",
	"Carnival",
	"Zombie",
	"Halloween",
	"Frozen",
	"Lightning",
	"Glitched",
	"Fireworks",
	"Skibidi",
	"Ice",
	"Pumpkin",
	"Halo",
	"Corrupt",
	"Ancient",
	"Shadow",
	"Fire",
	"Windy",
	"Shock"
}

for _,name in pairs(mutations) do

	local button = Instance.new("TextButton")
	button.Parent = scroll
	button.BackgroundColor3 = Color3.fromRGB(20,20,20)
	button.Text = "☐ "..name
	button.Font = Enum.Font.GothamBold
	button.TextColor3 = Color3.new(1,1,1)
	button.TextSize = 11
	button.AutoButtonColor = false

	Instance.new("UICorner", button).CornerRadius = UDim.new(0,6)

	local enabled = false

	button.MouseButton1Click:Connect(function()

		if not enabled and #selectedMutations >= maxMutations then
			mutStatus.Text = "Limite máximo de 11 mutações."
			mutStatus.TextColor3 = Color3.fromRGB(255,60,60)
			return
		end

		enabled = not enabled

		if enabled then

			table.insert(selectedMutations,name)

			button.Text = "☑ "..name
			button.BackgroundColor3 = Color3.fromRGB(40,80,40)

		else

			for i,v in pairs(selectedMutations) do
				if v == name then
					table.remove(selectedMutations,i)
				end
			end

			button.Text = "☐ "..name
			button.BackgroundColor3 = Color3.fromRGB(20,20,20)

		end

		mutStatus.Text = #selectedMutations.."/11 selecionadas"
		mutStatus.TextColor3 = Color3.fromRGB(180,180,180)

	end)

end

traits.MouseButton1Click:Connect(function()
	mutPanel.Visible = true
end)
local closeMut = Instance.new("TextButton")
closeMut.Parent = mutPanel
closeMut.Size = UDim2.new(0,24,0,24)
closeMut.Position = UDim2.new(1,-32,0,8)
closeMut.BackgroundColor3 = Color3.fromRGB(120,0,0)
closeMut.Text = "X"
closeMut.Font = Enum.Font.GothamBlack
closeMut.TextColor3 = Color3.new(1,1,1)
closeMut.TextSize = 13
closeMut.AutoButtonColor = false

Instance.new("UICorner", closeMut).CornerRadius = UDim.new(1,0)

closeMut.MouseButton1Click:Connect(function()
	mutPanel.Visible = false
end)
