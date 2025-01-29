local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local COREGUI = game:GetService("CoreGui")

local ESPenabled = false
local espTransparency = 0.5 -- Adjust as needed

local function getRoot(char)
    return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
end

local function createESP(plr)
    local espFolder = Instance.new("Folder")
    espFolder.Name = plr.Name .. "_ESP"
    espFolder.Parent = COREGUI

    for _, part in pairs(plr.Character:GetChildren()) do
        if part:IsA("BasePart") then
            local adornment = Instance.new("BoxHandleAdornment")
            adornment.Parent = espFolder
            adornment.Adornee = part
            adornment.Size = part.Size
            adornment.Transparency = espTransparency
            adornment.Color = plr.TeamColor
            adornment.AlwaysOnTop = true
            adornment.ZIndex = 5
        end
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Parent = espFolder
    billboard.Adornee = plr.Character.Head
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 1, 0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboard
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Font = Enum.Font.SourceSans
    textLabel.TextSize = 14
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextYAlignment = Enum.TextYAlignment.Bottom

    local updateTextFunc

    updateTextFunc = RunService.RenderStepped:Connect(function()
        if espFolder and plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid") and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local distance = math.floor((getRoot(Players.LocalPlayer.Character).Position - getRoot(plr.Character).Position).magnitude)
            textLabel.Text = string.format("Name: %s | Health: %d | Dist: %d", plr.Name, plr.Character.Humanoid.Health, distance)
        else
          espFolder:Destroy()
          updateTextFunc:Disconnect()
        end
    end)

    plr.CharacterAdded:Connect(function()
        if ESPenabled then
            espFolder:Destroy() -- Clean up before recreating
            createESP(plr)
        end
    end)

    plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
        if ESPenabled then
            espFolder:Destroy()
            createESP(plr)
        end
    end)
end

local function toggleESP()
    ESPenabled = not ESPenabled

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            local existingESP = COREGUI:FindFirstChild(player.Name .. "_ESP")
            if ESPenabled then
              if not existingESP then -- Only create if it doesn't exist
                createESP(player)
              end
            else
                if existingESP then
                    existingESP:Destroy()
                end
            end
        end
    end
end

ContextActionService:BindAction("ToggleESP", toggleESP, false, Enum.KeyCode.E)

-- Initial ESP for players already in the game
for _, player in pairs(Players:GetPlayers()) do
  if player ~= Players.LocalPlayer then
    createESP(player)
  end
end

Players.PlayerAdded:Connect(function(player)
    if ESPenabled then
        createESP(player)
    end
end)