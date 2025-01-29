local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local COREGUI = game:GetService("CoreGui")

local ESPenabled = false

local function createESP(plr)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = plr.Name .. "_ESP_Billboard"
    billboard.Adornee = plr.Character and plr.Character:FindFirstChild("Head")
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = COREGUI

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboard
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 14
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = 0

    local function updateText()
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            local armor = plr:FindFirstChild("Data") and plr.Data:FindFirstChild("Armor") and plr.Data.Armor.Value or 0
            textLabel.Text = string.format("%s | Health: %d | Armor: %d", plr.Name, humanoid.Health, armor)
        else
            textLabel.Text = plr.Name
        end
    end

    RunService.RenderStepped:Connect(updateText)
    if not plr.Character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = plr.Name .. "_ESP"
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = Color3.fromRGB(8, 146, 208)
    highlight.Parent = COREGUI

    local function updateHighlight()
        if plr.Character then
            highlight.Adornee = plr.Character
        else
            highlight.Adornee = nil
        end
    end
    
    updateHighlight()
    
    plr.CharacterAdded:Connect(function()
        if ESPenabled then
            updateHighlight()
        else
            highlight:Destroy()
        end
    end)
    
    plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
        highlight.OutlineColor = Color3.fromRGB(8, 146, 208)
    end)
end

local function toggleESP()
    ESPenabled = not ESPenabled
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            local existingESP = COREGUI:FindFirstChild(player.Name .. "_ESP")
            if ESPenabled then
                if not existingESP then
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
