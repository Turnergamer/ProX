local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local COREGUI = game:GetService("CoreGui")

local ESPenabled = false

local function createESP(plr)
    if not plr.Character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = plr.Name .. "_ESP"
    highlight.FillTransparency = 1 -- Fully transparent fill
    highlight.OutlineTransparency = 0 -- Fully visible outline
    highlight.OutlineColor = plr.TeamColor.Color
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
        highlight.OutlineColor = plr.TeamColor.Color
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

ContextActionService:BindAction("ToggleESP", toggleESP, false, Enum.KeyCode.E)

-- Initialize ESP for existing players
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
