-- ============================================================
--  TradeVisual Script  |  Refatorado e corrigido
-- ============================================================

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

local MAX_MUTATIONS  = 11
local SPAWN_DURATION = 35

-- ── Helpers ───────────────────────────────────────────────

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
	label.Visible = text ~= ""
end

-- ── Raiz ───────────────────────────────────────────────────

local gui = Instance.new("ScreenGui")
gui.Name = "TradeVisual"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- ── Estado global ──────────────────────────────────────────

local selectedMutations = {}
local selectedBrainrot  = nil
local spawnRunning      = false

-- ============================================================
--  LISTA DE BRAINROTS
-- ============================================================

local BRAINROTS = {
	{ name = "Noobini Pizzanini",         rarity = "Common"       },
	{ name = "Lirili Larila",             rarity = "Common"       },
	{ name = "Tim Cheese",                rarity = "Common"       },
	{ name = "Fluriflura",                rarity = "Common"       },
	{ name = "Talpa Di Fero",             rarity = "Common"       },
	{ name = "Noobini Santanini",         rarity = "Common"       },
	{ name = "Svinina Bombardino",        rarity = "Common"       },
	{ name = "Raccooni Jandelini",        rarity = "Common"       },
	{ name = "Pipi Kiwi",                 rarity = "Common"       },
	{ name = "Tartaragno",                rarity = "Common"       },
	{ name = "Pipi Corni",                rarity = "Common"       },
	{ name = "Holy Arepa",                rarity = "Common"       },
	{ name = "Trippi Troppi",             rarity = "Rare"         },
	{ name = "Tung Tung Tung Sahur",      rarity = "Rare"         },
	{ name = "Gangster Footera",          rarity = "Rare"         },
	{ name = "Bandito Bobritto",          rarity = "Rare"         },
	{ name = "Boneca Ambalabu",           rarity = "Rare"         },
	{ name = "Cacto Hipopotamo",          rarity = "Rare"         },
	{ name = "Ta Ta Ta Ta Sahur",         rarity = "Rare"         },
	{ name = "Tric Trac Baraboom",        rarity = "Rare"         },
	{ name = "Frogo Elfo",                rarity = "Rare"         },
	{ name = "Pipi Avocado",              rarity = "Rare"         },
	{ name = "Pengolino Nuvoletto",       rarity = "Rare"         },
	{ name = "Burbaloni Luliloli",        rarity = "Epic"         },
	{ name = "Capuchino Assassino",       rarity = "Epic"         },
	{ name = "Tralalero Tralala",         rarity = "Epic"         },
	{ name = "Bombombini Gusini",         rarity = "Epic"         },
	{ name = "Brrr Brrr Patapim",         rarity = "Epic"         },
	{ name = "Glorbo Fruttodrillo",       rarity = "Epic"         },
	{ name = "Lirilì Larilà",             rarity = "Epic"         },
	{ name = "Salamino Penguino",         rarity = "Epic"         },
	{ name = "Tracotoco Tracata",         rarity = "Epic"         },
	{ name = "Orangutan Ciucciotto",      rarity = "Epic"         },
	{ name = "Chimpanzini Bananini",      rarity = "Legendary"    },
	{ name = "Sigma Boy",                 rarity = "Legendary"    },
	{ name = "La Vacca Saturno Saturnita",rarity = "Legendary"    },
	{ name = "Frigo Camelo",              rarity = "Legendary"    },
	{ name = "Nucleo Dinossauro",         rarity = "Legendary"    },
	{ name = "Schiaccianoci Volanti",     rarity = "Legendary"    },
	{ name = "Pot Pumpkin",               rarity = "Legendary"    },
	{ name = "Ganganzelli Trulala",       rarity = "Mythic"       },
	{ name = "Gorillo Watermelondrillo",  rarity = "Mythic"       },
	{ name = "Bombardino Crocodillo",     rarity = "Mythic"       },
	{ name = "Frigo Camelo Supremo",      rarity = "Mythic"       },
	{ name = "Trippi Troppi Lungo",       rarity = "Mythic"       },
	{ name = "Talpa Talpa Talpina",       rarity = "Mythic"       },
	{ name = "Piccione Macchina",         rarity = "Brainrot God" },
	{ name = "Colosseo Dragone",          rarity = "Brainrot God" },
	{ name = "Dinosauro Nucleare",        rarity = "Brainrot God" },
	{ name = "Astro Jellyfish",           rarity = "Brainrot God" },
	{ name = "Garama",                    rarity = "Secret"       },
	{ name = "Madundung",                 rarity = "Secret"       },
	{ name = "Cerberus",                  rarity = "Secret"       },
	{ name = "Dragon Cannelloni",         rarity = "Secret"       },
	{ name = "Strawberry Elephant",       rarity = "OG"           },
	{ name = "Meowl",                     rarity = "OG"           },
}

local RARITY_COLOR = {
	["Common"]       = Color3.fromRGB(180, 180, 180),
	["Rare"]         = Color3.fromRGB(80,  140, 255),
	["Epic"]         = Color3.fromRGB(160, 80,  255),
	["Legendary"]    = Color3.fromRGB(255, 180, 0  ),
	["Mythic"]       = Color3.fromRGB(255, 80,  80 ),
	["Brainrot God"] = Color3.fromRGB(255, 120, 30 ),
	["Secret"]       = Color3.fromRGB(100, 255, 220),
	["OG"]           = Color3.fromRGB(255, 215, 0  ),
}

-- ============================================================
--  PAINEL PRINCIPAL (aba SPAWN)
-- ============================================================

local main = makeFrame({
	Parent           = gui,
	Name             = "MainFrame",
	Size             = UDim2.new(0, 305, 0, 260),
	Position         = UDim2.new(0.5, -152, 0.5, -130),
	BackgroundColor3 = C.BG,
	BorderSizePixel  = 0,
	Active           = true,
	Draggable        = true,
})
addCorner(main, 12)
addStroke(main)

makeLabel({
	Parent     = main,
	Size       = UDim2.new(1, 0, 0, 30),
	Position   = UDim2.new(0, 0, 0, 6),
	Font       = Enum.Font.GothamBlack,
	Text       = "Trade Visual Script",
	TextColor3 = C.WHITE,
	TextSize   = 18,
})

-- Tabs
local tabsFrame = makeFrame({
	Parent                 = main,
	BackgroundTransparency = 1,
	Position               = UDim2.new(0, 12, 0, 42),
	Size                   = UDim2.new(1, -24, 0, 28),
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

-- Label
makeLabel({
	Parent         = main,
	Position       = UDim2.new(0, 12, 0, 77),
	Size           = UDim2.new(0, 180, 0, 13),
	Font           = Enum.Font.GothamBold,
	Text           = "BRAINROT TO SPAWN",
	TextColor3     = C.GRAY,
	TextSize       = 10,
	TextXAlignment = Enum.TextXAlignment.Left,
})

-- Botão de seleção (dropdown trigger)
local selectBtn = makeButton(main, {
	Position         = UDim2.new(0, 12, 0, 92),
	Size             = UDim2.new(0, 195, 0, 24),
	BackgroundColor3 = C.PANEL,
	Text             = "Selecione um brainrot...",
	TextColor3       = C.GRAY,
	TextSize         = 10,
	Font             = Enum.Font.GothamBold,
})

-- Botão Traits & Mut
local traitsBtn = makeButton(main, {
	Position         = UDim2.new(0, 215, 0, 92),
	Size             = UDim2.new(0, 78, 0, 24),
	BackgroundColor3 = C.BTN_MUT,
	Text             = "TRAITS &\nMUT",
	TextColor3       = Color3.fromRGB(190, 120, 255),
	TextSize         = 8,
})

-- ── Dropdown ──────────────────────────────────────────────
local dropdown = makeFrame({
	Parent           = main,
	Position         = UDim2.new(0, 12, 0, 118),
	Size             = UDim2.new(1, -24, 0, 110),
	BackgroundColor3 = Color3.fromRGB(14, 14, 14),
	Visible          = false,
	ZIndex           = 10,
})
addCorner(dropdown, 6)
addStroke(dropdown)

local ddScroll = Instance.new("ScrollingFrame")
ddScroll.Parent = dropdown
ddScroll.Position = UDim2.new(0, 4, 0, 4)
ddScroll.Size = UDim2.new(1, -8, 1, -8)
ddScroll.BackgroundTransparency = 1
ddScroll.BorderSizePixel = 0
ddScroll.ScrollBarThickness = 3
ddScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ddScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ddScroll.ZIndex = 10

Instance.new("UIListLayout", ddScroll).Padding = UDim.new(0, 2)

local function closeDropdown()
	dropdown.Visible = false
end

for _, entry in ipairs(BRAINROTS) do
	local color = RARITY_COLOR[entry.rarity] or C.WHITE
	local item = makeButton(ddScroll, {
		Size             = UDim2.new(1, 0, 0, 22),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		Text             = "[" .. entry.rarity .. "] " .. entry.name,
		TextColor3       = color,
		TextSize         = 9,
		Font             = Enum.Font.GothamBold,
		ZIndex           = 11,
	})
	item.MouseButton1Click:Connect(function()
		selectedBrainrot     = entry.name
		selectBtn.Text       = entry.name
		selectBtn.TextColor3 = color
		closeDropdown()
	end)
end

selectBtn.MouseButton1Click:Connect(function()
	dropdown.Visible = not dropdown.Visible
end)

-- ── Barra de carregamento ─────────────────────────────────
local barBG = makeFrame({
	Parent           = main,
	Position         = UDim2.new(0, 12, 0, 120),
	Size             = UDim2.new(1, -24, 0, 10),
	BackgroundColor3 = Color3.fromRGB(30, 30, 30),
	Visible          = false,
})
addCorner(barBG, 5)

local barFill = makeFrame({
	Parent           = barBG,
	Position         = UDim2.new(0, 0, 0, 0),
	Size             = UDim2.new(0, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(0, 200, 80),
})
addCorner(barFill, 5)

-- Status (aparece após conclusão ou erro)
local spawnStatus = makeLabel({
	Parent        = main,
	Position      = UDim2.new(0, 10, 0, 134),
	Size          = UDim2.new(1, -20, 0, 36),
	Font          = Enum.Font.GothamBold,
	Text          = "",
	TextColor3    = C.RED,
	TextSize      = 10,
	TextWrapped   = true,
	TextYAlignment = Enum.TextYAlignment.Top,
	Visible       = false,
})

-- Botões de ação
local spawnBtn = makeButton(main, {
	Position         = UDim2.new(0, 12, 0, 173),
	Size             = UDim2.new(0, 132, 0, 28),
	BackgroundColor3 = C.BTN_GREEN,
	Text             = "SPAWN VISUAL",
	TextSize         = 13,
})

local clearBtn = makeButton(main, {
	Position         = UDim2.new(0, 160, 0, 173),
	Size             = UDim2.new(0, 132, 0, 28),
	BackgroundColor3 = C.BTN_RED,
	Text             = "CLEAR ALL",
	TextSize         = 13,
})

local saveCfgBtn = makeButton(main, {
	Position         = UDim2.new(0, 12, 0, 206),
	Size             = UDim2.new(0, 132, 0, 28),
	BackgroundColor3 = C.BTN_BLUE,
	Text             = "SAVE CONFIG",
	TextSize         = 13,
})

local deleteCfgBtn = makeButton(main, {
	Position         = UDim2.new(0, 160, 0, 206),
	Size             = UDim2.new(0, 132, 0, 28),
	BackgroundColor3 = C.BTN_RED,
	Text             = "DELETE CONFIG",
	TextSize         = 13,
})

-- ── Callbacks do painel principal ─────────────────────────

spawnBtn.MouseButton1Click:Connect(function()
	if spawnRunning then return end
	closeDropdown()
	spawnRunning = true
	spawnStatus.Visible = false

	-- Mostra barra e escurece botão
	barFill.Size = UDim2.new(0, 0, 1, 0)
	barBG.Visible = true
	spawnBtn.BackgroundColor3 = Color3.fromRGB(0, 70, 0)

	local startTime = tick()
	local RunService = game:GetService("RunService")
	local conn
	conn = RunService.Heartbeat:Connect(function()
		local elapsed  = tick() - startTime
		local progress = math.clamp(elapsed / SPAWN_DURATION, 0, 1)

		barFill.Size = UDim2.new(progress, 0, 1, 0)

		-- Verde → amarelo → laranja
		local r = math.floor(math.min(progress * 2, 1) * 230)
		local g = math.floor(math.max(1 - progress, 0) * 200 + 55)
		barFill.BackgroundColor3 = Color3.fromRGB(r, g, 0)

		if progress >= 1 then
			conn:Disconnect()
			barBG.Visible = false
			spawnBtn.BackgroundColor3 = C.BTN_GREEN
			spawnRunning = false

			-- Mensagem de falha profissional
			setStatus(spawnStatus,
				"Falha ao spawnar: nenhum Brainrot de tier alto foi detectado na sua base. Certifique-se de ter um Garama, Cerberus, Dragon Cannelloni ou equivalente antes de utilizar este recurso.",
				C.RED)
		end
	end)
end)

clearBtn.MouseButton1Click:Connect(function()
	barBG.Visible       = false
	barFill.Size        = UDim2.new(0, 0, 1, 0)
	spawnStatus.Visible = false
	spawnStatus.Text    = ""
	spawnRunning        = false
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
	Parent         = tradeMenu,
	Position       = UDim2.new(0, 12, 0, 46),
	Size           = UDim2.new(0, 160, 0, 16),
	Font           = Enum.Font.GothamBold,
	Text           = "PLAYER USERNAME",
	TextColor3     = C.GRAY,
	TextSize       = 11,
	TextXAlignment = Enum.TextXAlignment.Left,
})

local usernameBox = makeTextBox(tradeMenu, {
	Position        = UDim2.new(0, 12, 0, 65),
	Size            = UDim2.new(0, 255, 0, 26),
	PlaceholderText = "enter username...",
	Text            = "",
})

local meBtn = makeButton(tradeMenu, {
	Position         = UDim2.new(0, 272, 0, 65),
	Size             = UDim2.new(0, 22, 0, 26),
	BackgroundColor3 = C.BTN_PURPLE,
	Text             = "ME",
	TextSize         = 9,
})
do
	local c = Instance.new("UICorner", meBtn)
	c.CornerRadius = UDim.new(1, 0)
end

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
	Parent         = dupeMenu,
	Position       = UDim2.new(0, 12, 0, 40),
	Size           = UDim2.new(0, 220, 0, 18),
	Font           = Enum.Font.GothamBold,
	Text           = "SELECIONE O PET QUE DESEJA DUPAR",
	TextColor3     = C.GRAY,
	TextSize       = 11,
	TextXAlignment = Enum.TextXAlignment.Left,
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
	Parent      = dupeMenu,
	Position    = UDim2.new(0, 12, 0, 143),
	Size        = UDim2.new(1, -24, 0, 50),
	Font        = Enum.Font.GothamBold,
	Text        = "Requisitos mínimos: Garama ou pets acima de 1B. Limite máximo: 3 Dragons por execução.",
	TextColor3  = C.GREEN_TEXT,
	TextSize    = 11,
	TextWrapped = true,
})

dupeBtn.MouseButton1Click:Connect(function()
	if dupeBox.Text ~= "" then
		setStatus(dupeStatus, "O pet não se encontra na sua base para duplicar.", C.RED)
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

spawnTab.MouseButton1Click:Connect(function()    showOnly(main)         end)
tradeTab.MouseButton1Click:Connect(function()    showOnly(tradeMenu)    end)
dupeTab.MouseButton1Click:Connect(function()     showOnly(dupeMenu)     end)
settingsTab.MouseButton1Click:Connect(function() showOnly(settingsMenu) end)

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

local mutStatusLabel = makeLabel({
	Parent     = mutPanel,
	Position   = UDim2.new(0, 0, 1, -25),
	Size       = UDim2.new(1, 0, 0, 18),
	Font       = Enum.Font.GothamBold,
	Text       = "0/" .. MAX_MUTATIONS .. " selecionadas",
	TextColor3 = C.LGRAY,
	TextSize   = 11,
})

local closeMutBtn = makeButton(mutPanel, {
	Size             = UDim2.new(0, 24, 0, 24),
	Position         = UDim2.new(1, -32, 0, 8),
	BackgroundColor3 = C.BTN_DKRED,
	Text             = "X",
	TextSize         = 13,
})
do
	local c = Instance.new("UICorner", closeMutBtn)
	c.CornerRadius = UDim.new(1, 0)
end

closeMutBtn.MouseButton1Click:Connect(function()
	mutPanel.Visible = false
end)

traitsBtn.MouseButton1Click:Connect(function()
	mutPanel.Visible = true
end)

local scroll = Instance.new("ScrollingFrame")
scroll.Parent = mutPanel
scroll.Position = UDim2.new(0, 10, 0, 40)
scroll.Size = UDim2.new(1, -20, 1, -75)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
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

local function refreshMutStatus()
	local count = 0
	for _ in pairs(selectedMutations) do count = count + 1 end
	mutStatusLabel.Text      = count .. "/" .. MAX_MUTATIONS .. " selecionadas"
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
			selectedMutations[name] = nil
			btn.Text             = "☐ " .. name
			btn.BackgroundColor3 = C.MUT_OFF
		else
			local count = 0
			for _ in pairs(selectedMutations) do count = count + 1 end
			if count >= MAX_MUTATIONS then
				setStatus(mutStatusLabel,
					"Limite máximo de " .. MAX_MUTATIONS .. " mutações.",
					C.RED)
				return
			end
			selectedMutations[name] = true
			btn.Text             = "☑ " .. name
			btn.BackgroundColor3 = C.MUT_ON
		end
		refreshMutStatus()
	end)
end
