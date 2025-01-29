-- LocalScript under StarterPlayer -> StarterPlayerScripts

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local camera = game.Workspace.CurrentCamera
local highlightColor = Color3.fromRGB(255, 0, 0) -- Red color for the chams effect

-- Function to apply chams to the character
local function applyChamsToCharacter(character)
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            -- Create a new part with the same size and position
            local chamPart = Instance.new("Part")
            chamPart.Size = part.Size
            chamPart.Position = part.Position
            chamPart.Anchored = true
            chamPart.CanCollide = false
            chamPart.Transparency = 0.5 -- Transparency to see through walls
            chamPart.Color = highlightColor
            chamPart.Parent = workspace

            -- Match the cham part to the part's position and rotation
            chamPart.CFrame = part.CFrame
            chamPart.Name = "Cham_"..part.Name

            -- Destroy cham part when part is removed
            part.AncestryChanged:Connect(function(_, parent)
                if not parent then
                    chamPart:Destroy()
                end
            end)
        end
    end
end

-- Apply chams when the character spawns
character:WaitForChild("HumanoidRootPart")
applyChamsToCharacter(character)

-- Reapply chams if the player respawns
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    applyChamsToCharacter(character)
end)
