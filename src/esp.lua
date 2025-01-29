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
            adornment.Color = plr.TeamColor -- Or a custom color
            adornment.AlwaysOnTop = true
            adornment.ZIndex = 5
        end
    end

    -- Billboard for name and distance (optional, but helpful)
    local billboard = Instance.new("BillboardGui")
    billboard.Parent = espFolder
    billboard.Adornee = plr.Character.Head
    billboard.Size = UDim2.new(0, 100, 0, 50) -- Adjust size as needed
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
      if not Players.LocalPlayer.Character or not getRoot(Players.LocalPlayer.Character) then return end -- Check if local player character exists

        if espFolder and plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid") then
            local distance = math.floor((getRoot(Players.LocalPlayer.Character).Position - getRoot(plr.Character).Position).magnitude)
            textLabel.Text = string.format("Name: %s | Dist: %d", plr.Name, distance) -- Simplified text
        else
          espFolder:Destroy()
          updateTextFunc:Disconnect()
        end
    end)

    plr.CharacterAdded:Connect(function(char)
      task.wait(0.1) -- small wait to ensure everything is loaded
        if ESPenabled then
            espFolder:Destroy()
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
              if not existingESP and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then -- Check if character exists before creating
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

ContextActionService:BindAction("ToggleESP", toggleESP, false, Enum.KeyCode.E) -- Toggle with E

-- Initial ESP for players already in the game
for _, player in pairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then -- Check if character exists before creating
        createESP(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function() -- Wait for character to be added
      task.wait(0.1) -- small wait to ensure everything is loaded
        if ESPenabled then
            createESP(player)
        end
    end)
end)