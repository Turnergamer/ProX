-- Configuration
local espTransparency = 0.5 -- Adjust transparency of the ESP boxes
local COREGUI = game:GetService("CoreGui") -- Get CoreGui service
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Helper function to get the root part of a character
local function getRoot(char)
    if char and char:FindFirstChild("HumanoidRootPart") then
        return char.HumanoidRootPart
    elseif char and char:FindFirstChild("Torso") then -- For R6 avatars
        return char.Torso
    end
    return nil
end

-- Rounding function
local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- ESP Function
local function ESP(plr)
    task.spawn(function()
        -- Clean up old ESP elements for the player
        for i, v in pairs(COREGUI:GetChildren()) do
            if v.Name == plr.Name .. '_ESP' then
                v:Destroy()
            end
        end

        wait() -- Small delay to ensure cleanup

        if plr.Character and plr.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(plr.Name .. '_ESP') then
            local ESPholder = Instance.new("Folder")
            ESPholder.Name = plr.Name .. '_ESP'
            ESPholder.Parent = COREGUI

            repeat task.wait(0.1) until plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid") -- Reduced wait time

            for _, part in pairs(plr.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    local adornment = Instance.new("BoxHandleAdornment")
                    adornment.Name = plr.Name
                    adornment.Parent = ESPholder
                    adornment.Adornee = part
                    adornment.AlwaysOnTop = true
                    adornment.ZIndex = 5 -- Adjusted ZIndex
                    adornment.Size = part.Size
                    adornment.Transparency = espTransparency
                    adornment.Color = plr.TeamColor -- Or a custom color if needed
                end
            end


            if plr.Character and plr.Character:FindFirstChild("Head") then
                local billboardGui = Instance.new("BillboardGui")
                local textLabel = Instance.new("TextLabel")

                billboardGui.Adornee = plr.Character.Head
                billboardGui.Name = plr.Name
                billboardGui.Parent = ESPholder
                billboardGui.Size = UDim2.new(0, 100, 0, 50) -- Adjusted size
                billboardGui.StudsOffset = Vector3.new(0, 1, 0)
                billboardGui.AlwaysOnTop = true

                textLabel.Parent = billboardGui
                textLabel.BackgroundTransparency = 1
                textLabel.Size = UDim2.new(1, 0, 1, 0) -- Fill billboardGui
                textLabel.Font = Enum.Font.SourceSans
                textLabel.TextSize = 14 -- Adjusted text size
                textLabel.TextColor3 = Color3.new(1, 1, 1)
                textLabel.TextStrokeTransparency = 0
                textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
                textLabel.ZIndex = 10

                local espLoopFunc
                local charAddedConnection
                local teamChangedConnection

                local function updateText()
                    if ESPholder and plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid") and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                        local distance = math.floor((getRoot(Players.LocalPlayer.Character).Position - getRoot(plr.Character).Position).magnitude)
                        textLabel.Text = string.format("Name: %s | Health: %d | Dist: %d", plr.Name, plr.Character.Humanoid.Health, distance)
                    else
                      ESPholder:Destroy()
                      if espLoopFunc then espLoopFunc:Disconnect() end
                      if charAddedConnection then charAddedConnection:Disconnect() end
                      if teamChangedConnection then teamChangedConnection:Disconnect() end
                    end
                end


                espLoopFunc = RunService.RenderStepped:Connect(updateText)

                charAddedConnection = plr.CharacterAdded:Connect(function(newChar)
                  if ESPenabled then
                    ESPholder:Destroy()
                    ESP(plr)
                  end
                end)

                teamChangedConnection = plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
                  if ESPenabled then
                    ESPholder:Destroy()
                    ESP(plr)
                  end
                end)
            end
        end
    end)
end


-- Example usage (toggle with a key)
local ESPenabled = false
local contextActionService = game:GetService("ContextActionService")

local function toggleESP()
    ESPenabled = not ESPenabled
    if ESPenabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                ESP(player)
            end
        end
    else
        for i, v in pairs(COREGUI:GetChildren()) do
            if string.find(v.Name, "_ESP") then
                v:Destroy()
            end
        end
    end
end

contextActionService:BindAction("ToggleESP", toggleESP, false, Enum.KeyCode.E) -- Toggle with 'E' key

-- Initial ESP setup for players already in the game
for _, player in pairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        ESP(player)
    end
end

-- Handle players joining later
Players.PlayerAdded:Connect(function(player)
    if ESPenabled then
        ESP(player)
    end
end)