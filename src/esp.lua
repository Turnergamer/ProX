local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local COREGUI = game:GetService("CoreGui") -- Get CoreGui service

local ESPenabled = false -- Initialize variables
local CHMSenabled = false
local espTransparency = 0.5 -- Set your desired transparency

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function createESP(plr, espType) -- Combined ESP/CHMS function, takes type as argument
    local espFolder = Instance.new("Folder") -- Use a local variable
    espFolder.Name = plr.Name .. "_" .. espType -- Consistent naming
    espFolder.Parent = COREGUI

    local characterAddedConnection -- Store the connection for later disconnection
    local teamChangedConnection

    characterAddedConnection = plr.CharacterAdded:Connect(function(character)
        characterAddedConnection:Disconnect() -- Disconnect immediately

        if not character:FindFirstChild("HumanoidRootPart") then return end -- Check for HumanoidRootPart

        -- BoxHandleAdornments (only if ESP or CHMS is enabled)
        if espType == "ESP" or espType == "CHMS" then
            for _, part in pairs(character:GetDescendants()) do -- Use GetDescendants for all parts
                if part:IsA("BasePart") then
                    local adornment = Instance.new("BoxHandleAdornment")
                    adornment.Name = plr.Name
                    adornment.Parent = espFolder
                    adornment.Adornee = part
                    adornment.AlwaysOnTop = true
                    adornment.ZIndex = 10
                    adornment.Size = part.Size
                    adornment.Transparency = espTransparency
                    adornment.Color = plr.TeamColor
                end
            end
        end

        -- BillboardGui (Name, Health, Distance)
        local billboard = Instance.new("BillboardGui")
        billboard.Adornee = character.Head -- Directly reference the head
        billboard.Name = plr.Name
        billboard.Parent = espFolder
        billboard.Size = UDim2.new(0, 100, 0, 150)
        billboard.StudsOffset = Vector3.new(0, 1, 0)
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboard
        textLabel.BackgroundTransparency = 1
        textLabel.Position = UDim2.new(0, 0, 0, -50)
        textLabel.Size = UDim2.new(0, 100, 0, 100)
        textLabel.Font = Enum.Font.SourceSansSemibold
        textLabel.TextSize = 20
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
        textLabel.ZIndex = 10

        local updateFunc -- Declare update function
        updateFunc = function() -- Define the update function
            if espFolder and espFolder.Parent then -- Check if the folder still exists
                local distance = math.floor((Players.LocalPlayer.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude) -- Calculate distance
                textLabel.Text = string.format("Name: %s | Health: %s | Studs: %d", plr.Name, round(character.Humanoid.Health, 1), distance) -- Format the text
            else
                RunService.RenderStepped:Disconnect(updateConnection) -- Disconnect if the folder is gone
                teamChangedConnection:Disconnect()
                characterAddedConnection:Disconnect()
            end
        end

        local updateConnection = RunService.RenderStepped:Connect(updateFunc) -- Connect the update function

        teamChangedConnection = plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
            if espFolder and espFolder.Parent then -- Check if folder exists
                for _, adornment in pairs(espFolder:GetChildren()) do
                    if adornment:IsA("BoxHandleAdornment") then
                        adornment.Color = plr.TeamColor
                    end
                end
            else
                teamChangedConnection:Disconnect()
            end
        end)


    end)
end


local function toggleESP(enabled) -- Combined toggle function
    ESPenabled = enabled
    for _, plr in pairs(Players:GetPlayers()) do
        local espFolder = COREGUI:FindFirstChild(plr.Name .. "_ESP")
        if espFolder then
            espFolder:Destroy() -- Destroy old ESP
        end
        if enabled and plr ~= Players.LocalPlayer then
            createESP(plr, "ESP") -- Create new ESP
        end
    end
end

local function toggleCHMS(enabled) -- Combined toggle function
    CHMSenabled = enabled
    for _, plr in pairs(Players:GetPlayers()) do
        local chmsFolder = COREGUI:FindFirstChild(plr.Name .. "_CHMS")
        if chmsFolder then
            chmsFolder:Destroy() -- Destroy old CHMS
        end
        if enabled and plr ~= Players.LocalPlayer then
            createESP(plr, "CHMS") -- Create new CHMS
        end
    end
end


-- Initial ESP/CHMS setup for existing players
for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= Players.LocalPlayer then
        if ESPenabled then createESP(plr, "ESP") end
        if CHMSenabled then createESP(plr, "CHMS") end
    end
end

-- Handle new players
Players.PlayerAdded:Connect(function(plr)
    if ESPenabled and plr ~= Players.LocalPlayer then createESP(plr, "ESP") end
    if CHMSenabled and plr ~= Players.LocalPlayer then createESP(plr, "CHMS") end
end)



-- Example Toggle Keybinds (Using UserInputService - Works in Executors)
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then -- Toggle ESP
        toggleESP(not ESPenabled)
    elseif input.KeyCode == Enum.KeyCode.C then -- Toggle CHMS
        toggleCHMS(not CHMSenabled)
    end
end)


print("ESP/CHMS Loaded")