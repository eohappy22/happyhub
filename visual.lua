-- ============================================================
--  TradeVisual Script  |  Refatorado e corrigido
-- ============================================================

-- ── Constantes de cor ──────────────────────────────────────
local C = {
	BG          = Color3.fromRGB(10, 10, 10),
	PANEL       = Color3.fromRGB(16, 16, 16),
	STROKE      = Color3.fromRGB(45, 45, 45),
	BTN_DARK    = Color3.fromRGB(22, 22, 22),
	BTN_MUT     = Color3.fromRGB(45, 20, 70),
	BTN_GREEN   = Color3.fromRGB(0, 130, 0),
	BTN_RED     = Color3.fromRGB(100, 0, 0),
	BTN_BLUE    = Color3.fromRGB(0, 50, 140),
	BTN_PURPLE  = Color3.fromRGB(50, 40, 120),
	BTN_DKRED   = Color3.fromRGB(120, 0, 0),
	MUT_ON      = Color3.fromRGB(40, 80, 40),
	MUT_OFF     = Color3.fromRGB(20, 20, 20),
	WHITE       = Color3.new(1, 1, 1),
	GRAY        = Color3.fromRGB(120, 120, 120),
	RED         = Color3.fromRGB(255, 60, 60),
	GREEN_TEXT  = Color3.fromRGB(120, 255, 120),
	LGRAY       = Color3.fromRGB(180, 180, 180),
}

local MAX_MUTATIONS = 11

-- ── Helpers de criação de UI ───────────────────────────────

local function addCorner(parent, radius)
	local c = Instance.new("UICorner", parent)
	c.CornerRadius = UDim.new(0, radius or 6)
	return c
end

local function addStroke(parent, color)
	local s = Instance.new("UIStroke", parent)
	s.Color = color or C.STROKE
	return s
end

local function makeFrame(props)
	local f = Instance.new("Frame")
	for k, v in pairs(props) do f[k] = v end
	return f
end

local function makeLabel(props)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	for k, v in pairs(props) do l[k] = v end
	return l
end

local function makeButton(parent, props)
	local b = Instance.new("TextButton")
	b.Parent = parent
	b.Font = Enum.Font.GothamBlack
	b.TextColor3 = C.WHITE
	b.AutoButtonColor = false
	for k, v in pairs(props) do b[k] = v end
	addCorner(b, 6)
	return b
end

local function makeTextBox(parent, props)
	local tb = Instance.new("TextBox")
	tb.Parent = parent
	tb.BackgroundColor3 = C.PANEL
	tb.Font = Enum.Font.GothamBold
	tb.TextColor3 = C.WHITE
	tb.TextSize = 12
	tb.ClearTextOnFocus = false
	tb.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
	for k, v in pairs(props) do tb[k] = v end
	addCorner(tb, 6)
	return tb
end

local function setStatus(label, text, color)
	label.Text = text
	label.TextColor3 = color or C.WHITE
end

-- ── Raiz ───────────────────────────────────────────────────

local gui = Instance.new("ScreenGui")
gui.Name = "TradeVisual"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- ============================================================
--  ESTADO GLOBAL
-- ============================================================

local selectedMutations = {}   -- { [mutationName] = true }

-- ============================================================
--  PAINEL PRINCIPAL (aba SPAWN)
-- ============================================================

local main = makeFrame({
	Parent          = gui,
	Name            = "MainFrame",
	Size            = UDim2.new(0, 305, 0, 235),
	Position        = UDim2.new(0.5, -152, 0.5, -117),
	BackgroundColor3 = C.BG,
	BorderSizePixel = 0,
	Active          = true,
	Draggable       = true,
})
addCorner(main, 12)
addStroke(main)

-- Barra de abas (presente no main e replicada nas outras telas via tabs compartilhadas)
makeLabel({
	Parent        = main,
	Size          = UDim2.new(1, 0, 0, 30),
	Position      = UDim2.new(0, 0, 0, 6),
	Font          = Enum.Font.GothamBlack,
	Text          = "Trade Visual Script",
	TextColor3    = C.WHITE,
	TextSize      = 18,
})

-- Tabs
local tabsFrame = makeFrame({
	Parent              = main,
	BackgroundTransparency = 1,
	Position            = UDim2.new(0, 12, 0, 42),
	Size                = UDim2.new(1, -24, 0, 28),
})
local tabLayout = Instance.new("UIListLayout", tabsFrame)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 6)

local function makeTab(txt)
	return makeButton(tabsFrame, {
		Size             = UDim2.new(0, 62, 1, 0),
		BackgroundColor3 = C.BTN_DARK,
		Text             = txt,
		TextSize         = 11,
	})
end

local spawnTab    = makeTab("SPAWN")
local tradeTab    = makeTab("TRADE")
local dupeTab     = makeTab("DUPE")
local settingsTab = makeTab("SETTINGS")

-- Label "Animal to spawn"
makeLabel({
	Parent           = main,
	Position         = UDim2.new(0, 12, 0, 76),
	Size             = UDim2.new(0, 150, 0, 16),
	Font             = Enum.Font.GothamBold,
	Text             = "ANIMAL TO SPAWN",
	TextColor3       = C.GRAY,
	TextSize         = 11,
	TextXAlignment   = Enum.TextXAlignment.Left,
})

-- TextBox de nome do animal
local animalBox = makeTextBox(main, {
	Position = UDim2.new(0, 12, 0, 95),
	Size     = UDim2.new(0, 200, 0, 24),
	Text     = "Antonio",
})

-- Botão Traits & Mut
local traitsBtn = makeButton(main, {
	Position         = UDim2.new(0, 220, 0, 95),
	Size             = UDim2.new(0, 72, 0, 24),
	BackgroundColor3 = C.BTN_MUT,
	Text             = "TRAITS &\nMUT",
	TextColor3       = Color3.fromRGB(190, 120, 255),
	TextSize         = 8,
})

-- Status
local spawnStatus = makeLabel({
	Parent        = main,
	Position      = UDim2.new(0, 10, 0, 138),
	Size          = UDim2.new(1, -20, 0, 32),
	Font          = Enum.Font.GothamBlack,
	Text          = "NO EMPTY PODIUMS!",
	TextColor3    = Color3.fromRGB(255, 40, 40),
	TextSize      = 10,
	TextWrapped   = true,
	TextYAlignment = Enum.TextYAlignment.Top,
})

-- Botões de ação
local spawnBtn = makeButton(main, {
	Position         = UDim2.new(0, 12, 0, 170),
	Size             = UDim2.new(0, 132, 0, 28),
	BackgroundColor3 = C.BTN_GREEN,
	Text             = "SPAWN VISUAL",
	TextSize         = 13,
})

local clearBtn = makeButton(main, {
	Position         = UDim2.new(0, 160, 0, 170),
	Size             = UDim2.new(0, 132, 0, 28),
	BackgroundColor3 = C.BTN_RED,
	Text             = "CLEAR ALL",
	TextSize         = 13,
})

local saveCfgBtn = makeButton(main, {
	Position         = UDim2.new(0, 12, 0, 203),
	Size             = UDim2.new(0, 132, 0, 28),
	BackgroundColor3 = C.BTN_BLUE,
	Text             = "SAVE CONFIG",
	TextSize         = 13,
})

local deleteCfgBtn = makeButton(main, {
	Position         = UDim2.new(0, 160, 0, 203),
	Size             = UDim2.new(0, 132, 0, 28),
	BackgroundColor3 = C.BTN_RED,
	Text             = "DELETE CONFIG",
	TextSize         = 13,
})

-- Callbacks do painel principal
spawnBtn.MouseButton1Click:Connect(function()
	setStatus(spawnStatus,
		"É necessário um pet de tier alto na base. Ex: Garama, Dragon Cannelloni.",
		C.RED)
end)

clearBtn.MouseButton1Click:Connect(function()
	setStatus(spawnStatus, "Visuais removidos.", C.WHITE)
end)

saveCfgBtn.MouseButton1Click:Connect(function()
	setStatus(spawnStatus, "Configuração salva com sucesso.", C.GREEN_TEXT)
end)

deleteCfgBtn.MouseButton1Click:Connect(function()
	setStatus(spawnStatus, "Configuração removida.", Color3.fromRGB(255, 80, 80))
end)

-- ============================================================
--  PAINEL TRADE
-- ============================================================

local tradeMenu = makeFrame({
	Parent           = gui,
	Name             = "TradeMenu",
	Size             = UDim2.new(0, 305, 0, 250),
	Position         = UDim2.new(0.5, -152, 0.5, -125),
	BackgroundColor3 = C.BG,
	Visible          = false,
	Active           = true,
	Draggable        = true,
})
addCorner(tradeMenu, 12)
addStroke(tradeMenu)

makeLabel({
	Parent     = tradeMenu,
	Size       = UDim2.new(1, 0, 0, 35),
	Position   = UDim2.new(0, 0, 0, 5),
	Font       = Enum.Font.GothamBlack,
	Text       = "Trade Visual Script",
	TextColor3 = C.WHITE,
	TextSize   = 18,
})

makeLabel({
	Parent           = tradeMenu,
	Position         = UDim2.new(0, 12, 0, 46),
	Size             = UDim2.new(0, 160, 0, 16),
	Font             = Enum.Font.GothamBold,
	Text             = "PLAYER USERNAME",
	TextColor3       = C.GRAY,
	TextSize         = 11,
	TextXAlignment   = Enum.TextXAlignment.Left,
})

local usernameBox = makeTextBox(tradeMenu, {
	Position        = UDim2.new(0, 12, 0, 65),
	Size            = UDim2.new(0, 255, 0, 26),
	PlaceholderText = "enter username...",
	Text            = "",
})

-- Botão "ME"
local meBtn = makeButton(tradeMenu, {
	Position         = UDim2.new(0, 272, 0, 65),
	Size             = UDim2.new(0, 22, 0, 26),
	BackgroundColor3 = C.BTN_PURPLE,
	Text             = "ME",
	TextSize         = 9,
})
-- canto totalmente redondo
tradeMenu:FindFirstChildWhichIsA("UICorner", true) -- já existe no frame
local meBtnCorner = Instance.new("UICorner", meBtn)
meBtnCorner.CornerRadius = UDim.new(1, 0)

local receiveTradeBtn = makeButton(tradeMenu, {
	Position         = UDim2.new(0, 12, 0, 103),
	Size             = UDim2.new(1, -24, 0, 32),
	BackgroundColor3 = Color3.fromRGB(0, 110, 0),
	Text             = "RECEBER TRADE DESSE PLAYER",
	TextSize         = 13,
})

local forceAcceptBtn = makeButton(tradeMenu, {
	Position         = UDim2.new(0, 12, 0, 143),
	Size             = UDim2.new(1, -24, 0, 32),
	BackgroundColor3 = Color3.fromRGB(120, 0, 0),
	Text             = "FORÇAR ACEITAR A TRADE",
	TextSize         = 13,
})

local tradeStatus = makeLabel({
	Parent     = tradeMenu,
	Position   = UDim2.new(0, 0, 0, 185),
	Size       = UDim2.new(1, 0, 0, 18),
	Font       = Enum.Font.GothamBold,
	Text       = "waiting...",
	TextColor3 = C.GREEN_TEXT,
	TextSize   = 11,
})

meBtn.MouseButton1Click:Connect(function()
	usernameBox.Text = game.Players.LocalPlayer.Name
end)

receiveTradeBtn.MouseButton1Click:Connect(function()
	local user = usernameBox.Text
	if user ~= "" then
		setStatus(tradeStatus, "Trade recebida de " .. user, C.GREEN_TEXT)
	else
		setStatus(tradeStatus, "Digite um username primeiro.", C.RED)
	end
end)

forceAcceptBtn.MouseButton1Click:Connect(function()
	local user = usernameBox.Text
	if user ~= "" then
		setStatus(tradeStatus, "Trade aceita com " .. user, C.GREEN_TEXT)
	else
		setStatus(tradeStatus, "Digite um username primeiro.", C.RED)
	end
end)

-- ============================================================
--  PAINEL DUPE
-- ============================================================

local dupeMenu = makeFrame({
	Parent           = gui,
	Name             = "DupeMenu",
	Size             = UDim2.new(0, 305, 0, 220),
	Position         = UDim2.new(0.5, -152, 0.5, -110),
	BackgroundColor3 = C.BG,
	Visible          = false,
	Active           = true,
	Draggable        = true,
})
addCorner(dupeMenu, 12)
addStroke(dupeMenu)

makeLabel({
	Parent     = dupeMenu,
	Size       = UDim2.new(1, 0, 0, 35),
	Font       = Enum.Font.GothamBlack,
	Text       = "DUPE PANEL",
	TextColor3 = C.WHITE,
	TextSize   = 20,
})

makeLabel({
	Parent           = dupeMenu,
	Position         = UDim2.new(0, 12, 0, 40),
	Size             = UDim2.new(0, 220, 0, 18),
	Font             = Enum.Font.GothamBold,
	Text             = "SELECIONE O PET QUE DESEJA DUPAR",
	TextColor3       = C.GRAY,
	TextSize         = 11,
	TextXAlignment   = Enum.TextXAlignment.Left,
})

local dupeBox = makeTextBox(dupeMenu, {
	Position        = UDim2.new(0, 12, 0, 62),
	Size            = UDim2.new(1, -24, 0, 28),
	PlaceholderText = "Digite o nome do pet...",
	Text            = "",
})

local dupeBtn = makeButton(dupeMenu, {
	Position         = UDim2.new(0, 12, 0, 100),
	Size             = UDim2.new(1, -24, 0, 32),
	BackgroundColor3 = Color3.fromRGB(0, 120, 0),
	Text             = "INICIAR DUPE",
	TextSize         = 14,
})

local dupeStatus = makeLabel({
	Parent       = dupeMenu,
	Position     = UDim2.new(0, 12, 0, 143),
	Size         = UDim2.new(1, -24, 0, 50),
	Font         = Enum.Font.GothamBold,
	Text         = "Requisitos mínimos: Garama ou pets acima de 1B. Limite máximo: 3 Dragons por execução.",
	TextColor3   = C.GREEN_TEXT,
	TextSize     = 11,
	TextWrapped  = true,
})

dupeBtn.MouseButton1Click:Connect(function()
	if dupeBox.Text ~= "" then
		setStatus(dupeStatus,
			"O pet não se encontra na sua base para duplicar.",
			C.RED)
	else
		setStatus(dupeStatus, "Digite o nome do pet primeiro.", C.RED)
	end
end)

-- ============================================================
--  PAINEL SETTINGS
-- ============================================================

local settingsMenu = makeFrame({
	Parent           = gui,
	Name             = "SettingsMenu",
	Size             = UDim2.new(0, 305, 0, 220),
	Position         = UDim2.new(0.5, -152, 0.5, -110),
	BackgroundColor3 = C.BG,
	Visible          = false,
	Active           = true,
	Draggable        = true,
})
addCorner(settingsMenu, 12)
addStroke(settingsMenu)

makeLabel({
	Parent     = settingsMenu,
	Size       = UDim2.new(1, 0, 0, 35),
	Font       = Enum.Font.GothamBlack,
	Text       = "SETTINGS",
	TextColor3 = C.WHITE,
	TextSize   = 20,
})

-- (adicione suas opções de settings aqui)

-- ============================================================
--  SISTEMA DE ABAS
-- ============================================================

local allPanels = { main, tradeMenu, dupeMenu, settingsMenu }

local function hideAll()
	for _, panel in ipairs(allPanels) do
		panel.Visible = false
	end
end

local function showOnly(panel)
	hideAll()
	panel.Visible = true
end

spawnTab.MouseButton1Click:Connect(function()    showOnly(main) end)
tradeTab.MouseButton1Click:Connect(function()    showOnly(tradeMenu) end)
dupeTab.MouseButton1Click:Connect(function()     showOnly(dupeMenu) end)
settingsTab.MouseButton1Click:Connect(function() showOnly(settingsMenu) end)

-- ── Botão de voltar (compartilhado) ───────────────────────
local function createBackButton(parent)
	local back = makeButton(parent, {
		Size             = UDim2.new(0, 24, 0, 24),
		Position         = UDim2.new(0, 8, 0, 8),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		Text             = "<",
		TextSize         = 16,
	})
	back.MouseButton1Click:Connect(function()
		showOnly(main)
	end)
	return back
end

createBackButton(tradeMenu)
createBackButton(dupeMenu)
createBackButton(settingsMenu)

-- ============================================================
--  PAINEL DE MUTATIONS / TRAITS
-- ============================================================

local mutPanel = makeFrame({
	Parent           = gui,
	Name             = "MutPanel",
	Size             = UDim2.new(0, 320, 0, 360),
	Position         = UDim2.new(0.5, -160, 0.5, -180),
	BackgroundColor3 = C.BG,
	Visible          = false,
	Active           = true,
	Draggable        = true,
})
addCorner(mutPanel, 12)
addStroke(mutPanel)

makeLabel({
	Parent     = mutPanel,
	Size       = UDim2.new(1, 0, 0, 35),
	Font       = Enum.Font.GothamBlack,
	Text       = "TRAITS & MUTATIONS",
	TextColor3 = C.WHITE,
	TextSize   = 18,
})

-- Status de seleção (declarado aqui, usado dentro do loop)
local mutStatusLabel = makeLabel({
	Parent     = mutPanel,
	Position   = UDim2.new(0, 0, 1, -25),
	Size       = UDim2.new(1, 0, 0, 18),
	Font       = Enum.Font.GothamBold,
	Text       = "0/" .. MAX_MUTATIONS .. " selecionadas",
	TextColor3 = C.LGRAY,
	TextSize   = 11,
})

-- Botão fechar mutations
local closeMutBtn = makeButton(mutPanel, {
	Size             = UDim2.new(0, 24, 0, 24),
	Position         = UDim2.new(1, -32, 0, 8),
	BackgroundColor3 = C.BTN_DKRED,
	Text             = "X",
	TextSize         = 13,
})
local closeCorner = Instance.new("UICorner", closeMutBtn)
closeCorner.CornerRadius = UDim.new(1, 0)

closeMutBtn.MouseButton1Click:Connect(function()
	mutPanel.Visible = false
end)

traitsBtn.MouseButton1Click:Connect(function()
	mutPanel.Visible = true
end)

-- ScrollingFrame com grid
local scroll = Instance.new("ScrollingFrame")
scroll.Parent = mutPanel
scroll.Position = UDim2.new(0, 10, 0, 40)
scroll.Size = UDim2.new(1, -20, 1, -75)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)   -- auto via UIGridLayout
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3

local grid = Instance.new("UIGridLayout", scroll)
grid.CellSize    = UDim2.new(0, 90, 0, 32)
grid.CellPadding = UDim2.new(0, 6, 0, 6)

local MUTATIONS = {
	"Gold","Diamond","Rainbow","Bloodrot","Candy","Lava","Galaxy",
	"Yin Yang","Radioactive","Cursed","Divine","Celestial","Chocolate",
	"Void","Toxic","Darkness","Lovely","Christmas","Crystal","Heaven",
	"Neon","Aqua","Dreamy","Carnival","Zombie","Halloween","Frozen",
	"Lightning","Glitched","Fireworks","Skibidi","Ice","Pumpkin","Halo",
	"Corrupt","Ancient","Shadow","Fire","Windy","Shock",
}

-- Atualiza o label e cor do status de mutações
local function refreshMutStatus()
	local count = 0
	for _ in pairs(selectedMutations) do count = count + 1 end
	mutStatusLabel.Text = count .. "/" .. MAX_MUTATIONS .. " selecionadas"
	mutStatusLabel.TextColor3 = C.LGRAY
end

for _, name in ipairs(MUTATIONS) do
	local btn = makeButton(scroll, {
		BackgroundColor3 = C.MUT_OFF,
		Text             = "☐ " .. name,
		TextSize         = 11,
	})

	btn.MouseButton1Click:Connect(function()
		if selectedMutations[name] then
			-- Desselecionar
			selectedMutations[name] = nil
			btn.Text             = "☐ " .. name
			btn.BackgroundColor3 = C.MUT_OFF
		else
			-- Verificar limite
			local count = 0
			for _ in pairs(selectedMutations) do count = count + 1 end
			if count >= MAX_MUTATIONS then
				setStatus(mutStatusLabel,
					"Limite máximo de " .. MAX_MUTATIONS .. " mutações.",
					C.RED)
				return
			end
			-- Selecionar
			selectedMutations[name] = true
			btn.Text             = "☑ " .. name
			btn.BackgroundColor3 = C.MUT_ON
		end
		refreshMutStatus()
	end)
end
