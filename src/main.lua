-- Create GUI Elements

loadstring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/VersionCheck.lua", true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/Premium.lua", true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/dsync.lua", true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/log.lua", true))()

_G.DsyncCheck = false



--


























local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local button = Instance.new("TextButton")
local UserInputService = game:GetService("UserInputService")





-- Parent the GUI to the Player's ScreenGui
screenGui.Parent = game:GetService("CoreGui")
-- Configure the Frame
frame.Parent = screenGui
frame.Size = UDim2.new(0, 600, 0, 400) -- Increased size
frame.Position = UDim2.new(0.2, 0, 0.15, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 15)
frameCorner.Parent = frame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.Position = UDim2.new(-0.42, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ProX"
TitleLabel.TextColor3 = Color3.fromRGB(8, 146, 208)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.ArialBold
TitleLabel.Parent = frame

local DividerLine = Instance.new("Frame")
DividerLine.Name = "DividerLine"
DividerLine.Size = UDim2.new(0, 4, 0.9, 0)
DividerLine.Position = UDim2.new(0.15, 0, 0.05, 0)
DividerLine.BackgroundColor3 = Color3.fromRGB(8, 146, 208)
DividerLine.Parent = frame

-- Function to create Tab Buttons
local function createTabButton(name, text, posY)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(0.15, 0, 0.08, 0)
	button.Position = UDim2.new(0, 0, posY, 0)
	button.BackgroundTransparency = 1
	button.Text = text
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextScaled = true
	button.Font = Enum.Font.GothamBold
	button.Parent = frame
	return button
end

-- Tab Buttons
local CombatTabButton = createTabButton("CombatTabButton", "Combat", 0.1)
local VisualsTabButton = createTabButton("VisualsTabButton", "Visuals", 0.2)
local MiscTabButton = createTabButton("MiscTabButton", "Misc", 0.3)
local CreditsTabButton = createTabButton("CreditsTabButton", "Credits", 0.4)

-- Function to create Tabs
local function createTab(name)
	local tab = Instance.new("Frame")
	tab.Name = name
	tab.Size = UDim2.new(0.82, 0, 0.9, 0)
	tab.Position = UDim2.new(0.18, 0, 0.05, 0)
	tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	tab.Visible = false
	tab.Parent = frame
	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = UDim.new(0, 15)
	frameCorner.Parent = tab
	return tab
end

-- Create Tabs
local CombatTab = createTab("CombatTab")
local VisualsTab = createTab("VisualsTab")
local MiscTab = createTab("MiscTab")
local CreditsTab = createTab("CreditsTab")

-- Function to Connect Tab Buttons to Tabs
local function connectTabButton(button, tab)
	button.MouseButton1Click:Connect(function()
		CombatTab.Visible = false
		VisualsTab.Visible = false
		MiscTab.Visible = false
		CreditsTab.Visible = false
		tab.Visible = true
	end)
end

-- Connect Tab Buttons
connectTabButton(CombatTabButton, CombatTab)
connectTabButton(VisualsTabButton, VisualsTab)
connectTabButton(MiscTabButton, MiscTab)
connectTabButton(CreditsTabButton, CreditsTab)

---visuals


-- Movement Text in Combat Tab
local MovementText = Instance.new("TextLabel")
MovementText.Name = "MovementText"
MovementText.Size = UDim2.new(0.2, 0, 0.2, 0)
MovementText.Position = UDim2.new(0, 0, 0, 0)
MovementText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MovementText.Text = "ESP"
MovementText.TextColor3 = Color3.fromRGB(255, 255, 255)
MovementText.TextScaled = true
MovementText.Font = Enum.Font.GothamBold
MovementText.Parent = VisualsTab



local ESPBUTTON = Instance.new("TextButton")
ESPBUTTON.Name = "SilentAimButton"
ESPBUTTON.Size = UDim2.new(0.2, 0, 0.15, 0)
ESPBUTTON.Position = UDim2.new(0, 0, 0.2, 0)
ESPBUTTON.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ESPBUTTON.Text = "ESP"
ESPBUTTON.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBUTTON.TextScaled = true
ESPBUTTON.BorderColor3 = Color3.fromRGB(8, 146, 208)
ESPBUTTON.Font = Enum.Font.GothamBold
ESPBUTTON.Parent = VisualsTab


-- Movement Text in Combat Tab
local FullbrightText = Instance.new("TextLabel")
FullbrightText.Name = "MovementText"
FullbrightText.Size = UDim2.new(0.4, 0, 0.2, 0)
FullbrightText.Position = UDim2.new(0.3, 0, 0, 0)
FullbrightText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FullbrightText.Text = "FullBright"
FullbrightText.TextColor3 = Color3.fromRGB(255, 255, 255)
FullbrightText.TextScaled = true
FullbrightText.Font = Enum.Font.GothamBold
FullbrightText.Parent = VisualsTab

local FullBrightButton = Instance.new("TextButton")
FullBrightButton.Name = "SilentAimButton"
FullBrightButton.Size = UDim2.new(0.2, 0, 0.15, 0)
FullBrightButton.Position = UDim2.new(0.4, 0, 0.2, 0)
FullBrightButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FullBrightButton.Text = "FullBright"
FullBrightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FullBrightButton.TextScaled = true
FullBrightButton.BorderColor3 = Color3.fromRGB(8, 146, 208)
FullBrightButton.Font = Enum.Font.GothamBold
FullBrightButton.Parent = VisualsTab


Lighting = game:GetService("Lighting")
FullBrightButton.MouseButton1Click:Connect(function()
	Lighting.FogEnd = 100000
	for i,v in pairs(Lighting:GetDescendants()) do
		if v:IsA("Atmosphere") then
			v:Destroy()
		end
	end
end)

ESPBUTTON.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/esp.lua", true))() -- Toggle tpwalking state only when the button is clicked
end)
-- FOV Slider UI Setup (same as previous)



-- Make the slider button draggable




-- Now you can call the function and it will use the adjusted FOV value







local FOVText = Instance.new("TextLabel")
FOVText.Name = "MovementText"
FOVText.Size = UDim2.new(0.2, 0, 0.2, 0)
FOVText.Position = UDim2.new(0, 0, 0.4, 0)
FOVText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FOVText.Text = "FOV"
FOVText.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVText.TextScaled = true
FOVText.Font = Enum.Font.GothamBold
FOVText.Parent = VisualsTab

local FovButton = Instance.new("TextButton")
FovButton.Name = "SilentAimButton"
FovButton.Size = UDim2.new(0.2, 0, 0.15, 0)
FovButton.Position = UDim2.new(0, 0, 0.6, 0)
FovButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FovButton.Text = "Enable FOV"
FovButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FovButton.TextScaled = true
FovButton.BorderColor3 = Color3.fromRGB(8, 146, 208)
FovButton.Font = Enum.Font.GothamBold
FovButton.Parent = VisualsTab

local fov = false -- Start with FOV disabled

FovButton.MouseButton1Click:Connect(function()
	if fov then
		-- If FOV is enabled, set it to default (70)
		workspace.CurrentCamera.FieldOfView = 70
		FovButton.Text = "Enable FOV" -- Change button text
	else
		-- If FOV is disabled, set it to 120
		workspace.CurrentCamera.FieldOfView = 120
		FovButton.Text = "Disable FOV" -- Change button text
	end
	-- Toggle the state of FOV
	fov = not fov
end)

-- Combat Tab Elements
local SilentAimText = Instance.new("TextLabel")
SilentAimText.Name = "SilentAimText"
SilentAimText.Size = UDim2.new(0.6, 0, 0.2, 0)
SilentAimText.Position = UDim2.new(0.2, 0, 0, 0)
SilentAimText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SilentAimText.Text = "Silent Aim"
SilentAimText.TextColor3 = Color3.fromRGB(255, 255, 255)
SilentAimText.TextScaled = true
SilentAimText.Font = Enum.Font.GothamBold
SilentAimText.Parent = CombatTab

local SilentAimButton = Instance.new("TextButton")
SilentAimButton.Name = "SilentAimButton"
SilentAimButton.Size = UDim2.new(0.2, 0, 0.15, 0)
SilentAimButton.Position = UDim2.new(0.4, 0, 0.2, 0)
SilentAimButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SilentAimButton.Text = "Activate Silent Aim"
SilentAimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SilentAimButton.TextScaled = true
SilentAimButton.BorderColor3 = Color3.fromRGB(8, 146, 208)
SilentAimButton.Font = Enum.Font.GothamBold
SilentAimButton.Parent = CombatTab

-- Movement Text in Combat Tab
local MovementText = Instance.new("TextLabel")
MovementText.Name = "MovementText"
MovementText.Size = UDim2.new(0.4, 0, 0.2, 0)
MovementText.Position = UDim2.new(0, 0, 0.4, 0)
MovementText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MovementText.Text = "Movement Options"
MovementText.TextColor3 = Color3.fromRGB(255, 255, 255)
MovementText.TextScaled = true
MovementText.Font = Enum.Font.GothamBold
MovementText.Parent = CombatTab

local SPEEDHACK = Instance.new("TextButton")
SPEEDHACK.Name = "Speedhack"
SPEEDHACK.Size = UDim2.new(0.2, 0, 0.15, 0)
SPEEDHACK.Position = UDim2.new(0.1, 0, 0.6, 0)
SPEEDHACK.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SPEEDHACK.Text = "Speedhack"
SPEEDHACK.TextColor3 = Color3.fromRGB(255, 255, 255)
SPEEDHACK.TextScaled = true
SPEEDHACK.BorderColor3 = Color3.fromRGB(8, 146, 208)
SPEEDHACK.Font = Enum.Font.GothamBold
SPEEDHACK.Parent = CombatTab







local Dsync = Instance.new("TextLabel")
Dsync.Name = "DsyncText"
Dsync.Size = UDim2.new(0.4, 0, 0.2, 0)
Dsync.Position = UDim2.new(0.5, 0, 0.4, 0)
Dsync.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Dsync.Text = "Dsync"
Dsync.TextColor3 = Color3.fromRGB(255, 255, 255)
Dsync.TextScaled = true
Dsync.Font = Enum.Font.GothamBold
Dsync.Parent = CombatTab





local DsyncKeybind = Instance.new("TextButton")
DsyncKeybind.Name = "Dsync Keybind"
DsyncKeybind.Size = UDim2.new(0.2, 0, 0.15, 0)
DsyncKeybind.Position = UDim2.new(0.6, 0, 0.6, 0)
DsyncKeybind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DsyncKeybind.Text = "Press a Key..."
DsyncKeybind.TextColor3 = Color3.fromRGB(255, 255, 255)
DsyncKeybind.TextScaled = true
DsyncKeybind.BorderColor3 = Color3.fromRGB(8, 146, 208)
DsyncKeybind.Font = Enum.Font.GothamBold
DsyncKeybind.Parent = CombatTab


local DsyncKeybindIs = Enum.KeyCode.P -- Default Key is "F"





waitingForKey2 = false

DsyncKeybind.MouseButton1Click:Connect(function()
	if waitingForKey2 then return end
	waitingForKey2 = true
	DsyncKeybind.Text = "Press a Key..."

	local connection
	connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			DsyncKeybindIs = input.KeyCode -- Set new keybind
			DsyncKeybind.Text = "Key: " .. tostring(DsyncKeybindIs):gsub("Enum.KeyCode.", "")
			waitingForKey2 = false
			connection:Disconnect()
		end
	end)
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == DsyncKeybindIs then
		_G.DsyncCheck = not _G.DsyncCheck
		print("sigma") -- Replace this with your Silent Aim function
	end
end)

tpwalking = false  -- Start with tpwalking off



SPEEDHACK.MouseButton1Click:Connect(function()
	tpwalking = not tpwalking  -- Toggle tpwalking state only when the button is clicked
end)

game:GetService("RunService").Heartbeat:Connect(function(delta)
	local chr = game.Players.LocalPlayer.Character
	local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

	if hum and hum.MoveDirection.Magnitude > 0 then
		if tpwalking then
			local tpValue = 5  -- Always use 5 as the teleport distance
			chr:TranslateBy(hum.MoveDirection * tpValue * delta * 10)  -- Apply teleportation
		end
	end
end)


-- Misc Tab Elements
local CrateText = Instance.new("TextLabel")
CrateText.Name = "CrateText"
CrateText.Size = UDim2.new(0.6, 0, 0.2, 0)
CrateText.Position = UDim2.new(0.2, 0, 0, 0)
CrateText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CrateText.Text = "Money Generator"
CrateText.TextColor3 = Color3.fromRGB(255, 255, 255)
CrateText.TextScaled = true
CrateText.Font = Enum.Font.GothamBold
CrateText.Parent = MiscTab

local RollAndSell = Instance.new("TextButton")
RollAndSell.Name = "RollAndSell"
RollAndSell.Size = UDim2.new(0.2, 0, 0.15, 0)
RollAndSell.Position = UDim2.new(0.1, 0, 0.2, 0)
RollAndSell.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
RollAndSell.Text = "Roll And Sell"
RollAndSell.TextColor3 = Color3.fromRGB(255, 255, 255)
RollAndSell.TextScaled = true
RollAndSell.BorderColor3 = Color3.fromRGB(8, 146, 208)
RollAndSell.Font = Enum.Font.GothamBold
RollAndSell.Parent = MiscTab

local JustRoll = Instance.new("TextButton")
JustRoll.Name = "JustRoll"
JustRoll.Size = UDim2.new(0.2, 0, 0.15, 0)
JustRoll.Position = UDim2.new(0.4, 0, 0.2, 0)
JustRoll.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JustRoll.Text = "Just Roll"
JustRoll.TextColor3 = Color3.fromRGB(255, 255, 255)
JustRoll.TextScaled = true
JustRoll.BorderColor3 = Color3.fromRGB(8, 146, 208)
JustRoll.Font = Enum.Font.GothamBold
JustRoll.Parent = MiscTab

local JustSell = Instance.new("TextButton")
JustSell.Name = "JustSell"
JustSell.Size = UDim2.new(0.2, 0, 0.15, 0)
JustSell.Position = UDim2.new(0.7, 0, 0.2, 0)
JustSell.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JustSell.Text = "Just Sell"
JustSell.TextColor3 = Color3.fromRGB(255, 255, 255)
JustSell.TextScaled = true
JustSell.BorderColor3 = Color3.fromRGB(8, 146, 208)
JustSell.Font = Enum.Font.GothamBold
JustSell.Parent = MiscTab

-- Credits Tab Elements

local CreditTitle = Instance.new("TextLabel")
CreditTitle.Name = "CreditText"
CreditTitle.Size = UDim2.new(0.8, 0, 0.2, 0)
CreditTitle.Position = UDim2.new(0.1, 0, 0.2, 0)
CreditTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CreditTitle.Text = "Made With Love By Ben"
CreditTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditTitle.TextScaled = true
CreditTitle.Font = Enum.Font.GothamBold
CreditTitle.Parent = CreditsTab

local CreditTitle = Instance.new("TextLabel")
CreditTitle.Name = "CreditText"
CreditTitle.Size = UDim2.new(0.8, 0, 0.2, 0)
CreditTitle.Position = UDim2.new(0.1, 0, 0.4, 0)
CreditTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CreditTitle.Text = "https://discord.gg/CTdCRgpZvS"
CreditTitle.TextColor3 = Color3.fromRGB(8, 146, 208)
CreditTitle.TextScaled = true
CreditTitle.Font = Enum.Font.GothamBold
CreditTitle.Parent = CreditsTab

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.Position = UDim2.new(-0.42, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ProX"
TitleLabel.TextColor3 = Color3.fromRGB(8, 146, 208)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.ArialBold
TitleLabel.Parent = frame


local CreditText = Instance.new("TextLabel")
CreditText.Name = "CreditText"
CreditText.Size = UDim2.new(0.8, 0, 0.2, 0)
CreditText.Position = UDim2.new(0.1, 0, 0, 0)
CreditText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CreditText.Text = "ProX Credits"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditText.TextScaled = true
CreditText.Font = Enum.Font.ArialBold
CreditText.Parent = CreditsTab
CreditText.BackgroundTransparency = 1
-- End of the GUI Setup


local Nocooldown = Instance.new("TextLabel")
Nocooldown.Name = "CrateText"
Nocooldown.Size = UDim2.new(0.4, 0, 0.2, 0)
Nocooldown.Position = UDim2.new(0, 0, 0.4, 0)
Nocooldown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Nocooldown.Text = "No Cooldown"
Nocooldown.TextColor3 = Color3.fromRGB(255, 255, 255)
Nocooldown.TextScaled = true
Nocooldown.Font = Enum.Font.GothamBold
Nocooldown.Parent = MiscTab

local Nocooldown = Instance.new("TextButton")
Nocooldown.Name = "No Cooldown"
Nocooldown.Size = UDim2.new(0.2, 0, 0.15, 0)
Nocooldown.Position = UDim2.new(0.1, 0, 0.6, 0)
Nocooldown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Nocooldown.Text = "Enable"
Nocooldown.TextColor3 = Color3.fromRGB(255, 255, 255)
Nocooldown.TextScaled = true
Nocooldown.BorderColor3 = Color3.fromRGB(8, 146, 208)
Nocooldown.Font = Enum.Font.GothamBold
Nocooldown.Parent = MiscTab

Nocooldown.MouseButton1Click:Connect(function()
	for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			v["HoldDuration"] = 0
		end
	end


	game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(v)
		v["HoldDuration"] = 0
	end)
end)









--MISC

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.U then
		frame.Visible = not frame.Visible
	end
end)






--silent aim 


local UserInputService = game:GetService("UserInputService")

-- Default Keybind
local SilentAimKeybind = Enum.KeyCode.F -- Default Key is "F"

-- Create Keybind Change Button
local ChangeKeybind = Instance.new("TextButton")
ChangeKeybind.Name = "ChangeKeybind"
ChangeKeybind.Size = UDim2.new(0.2, 0, 0.15, 0)
ChangeKeybind.Position = UDim2.new(0.4, 0, 0.2, 0)
ChangeKeybind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ChangeKeybind.Text = "Change Keybind"
ChangeKeybind.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangeKeybind.TextScaled = true
ChangeKeybind.BorderColor3 = Color3.fromRGB(8, 146, 208)
ChangeKeybind.Font = Enum.Font.GothamBold
ChangeKeybind.Parent = CombatTab

local waitingForKey = false

ChangeKeybind.MouseButton1Click:Connect(function()
	if waitingForKey then return end
	waitingForKey = true
	ChangeKeybind.Text = "Press a Key..."

	local connection
	connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			SilentAimKeybind = input.KeyCode -- Set new keybind
			ChangeKeybind.Text = "Key: " .. tostring(SilentAimKeybind):gsub("Enum.KeyCode.", "")
			waitingForKey = false
			connection:Disconnect()
		end
	end)
end)

-- Detect Key Press to Toggle Silent Aim
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == SilentAimKeybind then
		print("Silent Aim Activated") -- Replace this with your Silent Aim function
	end
end)






local waitingForKey = false

ChangeKeybind.MouseButton1Click:Connect(function()
	if waitingForKey then return end
	waitingForKey = true
	ChangeKeybind.Text = "Press a Key..."

	local connection
	connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			SilentAimKeybind = input.KeyCode -- Set new keybind
			ChangeKeybind.Text = "Key: " .. tostring(SilentAimKeybind):gsub("Enum.KeyCode.", "")
			waitingForKey = false
			connection:Disconnect()
		end
	end)
end)

--silent aim--

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvent = replicatedStorage:WaitForChild("RemoteEvent")
local localPlayer = players.LocalPlayer
local userInputService = game:GetService("UserInputService")

-- Find nearest player to localPlayer (excluding localPlayer)
local function getNearestPlayer()
	local nearestPlayer = nil
	local shortestDistance = math.huge  -- Start with an infinitely large distance

	for _, player in pairs(players:GetPlayers()) do
		if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
			if distance < shortestDistance then
				shortestDistance = distance
				nearestPlayer = player
			end
		end
	end

	return nearestPlayer
end

-- Generate bullet CFrame that spawns just out of the player's position
local function createBulletCFrame(targetPlayer)
	if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local targetPos = targetPlayer.Character.HumanoidRootPart.Position
		-- Offset slightly out of the player in front of them (adjust the offset as necessary)
		local offset = targetPlayer.Character.HumanoidRootPart.CFrame.LookVector * 2  -- 2 studs out in front of the player

		local bulletPosition = targetPos + offset  -- Bullet position slightly in front of the target player

		-- Create a CFrame pointing towards the target player
		local bulletCFrame = CFrame.new(bulletPosition, targetPos)
		return bulletCFrame
	end
	return nil
end

-- Main function to fire the bullet
local function fireBullet()
	local nearestPlayer = getNearestPlayer()

	if nearestPlayer then
		local bulletCFrame = createBulletCFrame(nearestPlayer)

		if bulletCFrame then
			-- Fire the first event
			local args = {
				[1] = "M1D",  -- The weapon or action to perform for bullet firing
				[2] = bulletCFrame
			}

			-- Fire the event for mouse down
			remoteEvent:FireServer(unpack(args))
		end
	end
end

-- Function to stop firing when the "T" key is released
local function stopFiring()
	local args = {
		[1] = "M1U",  -- The action to perform for mouse button up
	}

	-- Fire the event for mouse up
	remoteEvent:FireServer(unpack(args))
end

local firing = false

userInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end  -- Ignore if the game already processed this input

	if input.KeyCode == SilentAimKeybind then
		if not firing then
			firing = true
			-- Continuously fire bullets while "T" is pressed
			while firing do
				fireBullet()
				wait(0.1)  -- Adjust this delay to control firing rate
			end
		end
	end
end)

userInputService.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then return end  -- Ignore if the game already processed this input

	if input.KeyCode == SilentAimKeybind then
		-- Stop firing and simulate mouse button up
		firing = false
		stopFiring()
	end
end)
--














--args



local function invokeRollRemote()
	local remoteFunctionArgs = {
		[1] = "PremRollSkin10"
	}
	game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(remoteFunctionArgs))
end


local function invokeSellRemote()
	local skins = {
		"Hot Pink", "Agent", "Checkered", "Grey Camo", "Rusted Red",
		"Green Camo", "Orange Crush", "Painted Yellow", "Painted Orange",
		"Damaged", "Earth", "Painted Blue", "Painted Green", "Painted Red", 
		"Painted Pink", "Painted Purple", "Green Sentry", "Pink Sentry", 
		"Red Sentry", "Royal", "Fallen Agent"
	}
	local guns = {"SMG", "LMG", "Double Barrel Shotgun", "Revolver", "AK47", "Turret", "Shotgun"}

	for _, gun in ipairs(guns) do
		for _, skin in ipairs(skins) do
			-- Invoke sell remote function twice for painted skins
			local eventArgs = {
				[1] = "SellSkin",
				[2] = gun,
				[3] = skin
			}
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(eventArgs))
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(eventArgs))
		end
	end
end

-- Slowing down the roll loop by using a while loop and wait()
local function startRollLoop()
	coroutine.wrap(function()
		while true do
			invokeRollRemote()
			wait(300)


		end
	end)()
end

-- Slowing down the sell loop by using a while loop and wait()
local function startSellLoop()
	coroutine.wrap(function()
		while true do
			invokeSellRemote()
			wait(0.2)  -- Increased wait time to 1 second between sells
		end
	end)()
end

-- Slowing down both roll and sell loop by using a while loop and wait()
local function startRollAndSellLoop()
	coroutine.wrap(function()
		while true do

			invokeRollRemote()
			invokeSellRemote()
			wait(300)  -- Increased wait time to 1 second for selling
		end
	end)()
end

JustRoll.MouseButton1Click:Connect(function()
	screenGui:Destroy()
	startRollLoop()
end)

-- Button "Sell All" logic: Start only the sell loop
JustSell.MouseButton1Click:Connect(function()
	screenGui:Destroy()
	startSellLoop()
end)

-- Button "Roll and Sell" logic: Start both the roll and sell loops
RollAndSell.MouseButton1Click:Connect(function()
	screenGui:Destroy()
	startRollAndSellLoop()
end)



-- Button cli

-- Create ScreenGui and Frame
local ascreenGui = Instance.new("ScreenGui")
local closeopen = Instance.new("Frame")

-- Parent the GUI to the Player's PlayerGui
ascreenGui.Parent = game:GetService("CoreGui")

-- Set up the frame (for closing/opening)
closeopen.Size = UDim2.new(0.4, 0, 0.4, 0)  -- Set frame size
closeopen.Position = UDim2.new(0.3, 0, 0.3, 0)  -- Position it in the middle
closeopen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Set frame color
closeopen.Visible = false  -- Initially hidden
closeopen.Parent = ascreenGui

-- Create the Close/Open button
local button = Instance.new("TextButton")
button.Name = "Close/Open"
button.Size = UDim2.new(0.15, 0, 0.08, 0)
button.Position = UDim2.new(0, 0, 1, -40)  -- Position the button at the bottom of the screen
button.BackgroundTransparency = 1
button.Text = "Close/Open"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.Parent = ascreenGui

-- Function to toggle the frame visibility
local function toggleFrameVisibility()
	frame.Visible = not frame.Visible  -- Toggle visibility
end

-- Connect the button click to the function
button.MouseButton1Click:Connect(toggleFrameVisibility)







--
--checki
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Check if _G.number exists and if it's set to 1
if _G.number == 1 then
	player:Kick("Don't Execute Twice. Sent to a Moderator.") -- Kicks the player if _G.number is set to 1
end

-- If _G.number is nil, assign it to 1 and print it
if _G.number == nil then
	_G.number = 1
end









local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Target the parts you want to delete
local rightLowerArm = character:FindFirstChild("RightLowerArm")
local rightUpperArm = character:FindFirstChild("RightUpperArm")
local rightUpperArm = character:FindFirstChild("LeftUpperArm")
local rightLowerArm = character:FindFirstChild("LeftLowerArm")

-- Check if the parts exist and delete them
if rightLowerArm then
	rightLowerArm:Destroy()
end

if rightUpperArm then
	rightUpperArm:Destroy()
end









-- Define the keybind you're using for Dsync

-- Other initialization code
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    -- Check if the GUI exists, otherwise recreate it
    if not screenGui.Parent then
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
	if not ascreenGui.Parent then
        ascreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
end)


local Players = game:GetService("Players")

-- Check if the server is private
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Function to check if the player is the only one in the server
local function checkIfAlone()
    -- Wait for the player list to be available (just in case we're still waiting for players to load)
    while #Players:GetPlayers() == 0 do
        wait(1)
    end

    -- Check if this player is the only one in the server
    if #Players:GetPlayers() == 1 then
        -- If this is the only player, kick them
        player:Kick("You are the only player in the server.")
    end
end

-- Call the function to check if the player is alone
checkIfAlone()

-- Optionally, keep checking periodically (in case new players join after some time)
Players.PlayerAdded:Connect(function()
    checkIfAlone()
end)
