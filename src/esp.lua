-- LocalScript under StarterPlayer -> StarterPlayerScripts

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local highlightColor = Color3.fromRGB(255, 0, 0)  -- Red outline color

-- Function to apply outline effect to character's hitbox
local function applyOutlineToCharacter(character)
    -- Ensure the character is loaded
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    -- Loop through each part of the character
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            -- Check if the part is not already highlighted
            local existingHighlight = part:FindFirstChildOfClass("Highlight")
            if not existingHighlight then
                -- Create a new highlight object for the part
                local highlight = Instance.new("Highlight")
                highlight.Parent = part
                highlight.FillTransparency = 1  -- Make the part fully transparent
                highlight.OutlineTransparency = 0  -- Make the outline visible
                highlight.OutlineColor = highlightColor  -- Set the outline color
                highlight.OutlineThickness = 0.1  -- Thickness of the outline
            end
        end
    end
end

-- Apply outlines when the character is loaded
local function onCharacterAdded(character)
    -- Wait for the character to be fully loaded
    character:WaitForChild("HumanoidRootPart")
    applyOutlineToCharacter(character)

    -- Listen for when the character respawns
    character:WaitForChild("Humanoid").Died:Connect(function()
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                -- Remove any highlight effects after the character dies
                local highlight = part:FindFirstChildOfClass("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end)
end

-- Handle the player's character spawning and respawning
if player.Character then
    onCharacterAdded(player.Character)
else
    player.CharacterAdded:Connect(onCharacterAdded)
end
