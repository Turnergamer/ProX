-- LocalScript under StarterPlayer -> StarterPlayerScripts

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local highlightColor = Color3.fromRGB(8, 146, 208)  -- New outline color (Blue)

-- Function to create a smooth outline for the character's hitbox
local function createSmoothOutline(character)
    -- Ensure the character is fully loaded
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    -- Create an outline part around the whole character (using a "frame" style outline)
    local outlinePart = Instance.new("Part")
    outlinePart.Size = Vector3.new(5, 10, 5)  -- Size to cover the character (can adjust)
    outlinePart.CFrame = character.HumanoidRootPart.CFrame
    outlinePart.Anchored = true
    outlinePart.CanCollide = false
    outlinePart.Transparency = 0.5  -- Slight transparency
    outlinePart.Color = highlightColor  -- Use the new color here
    outlinePart.Material = Enum.Material.SmoothPlastic  -- Smooth material for a better look
    outlinePart.Parent = workspace

    -- Use a SurfaceGui to add a glowing outline effect around the character
    local surfaceGui = Instance.new("SurfaceGui")
    surfaceGui.Parent = outlinePart
    surfaceGui.Face = Enum.NormalId.Front  -- Applying to the front face of the outline
    surfaceGui.AlwaysOnTop = true

    -- Create a frame with glowing effect around the character's hitbox
    local glowFrame = Instance.new("Frame")
    glowFrame.Size = UDim2.new(1, 0, 1, 0)  -- Make it cover the whole part
    glowFrame.BackgroundColor3 = highlightColor  -- Use the new color here
    glowFrame.BackgroundTransparency = 0.5
    glowFrame.BorderSizePixel = 0
    glowFrame.Parent = surfaceGui

    -- Adjust the size and position of the outline as needed
    outlinePart.Size = Vector3.new(5, character.Humanoid.HipWidth + 6, 5)  -- Adjust for character hitbox
    outlinePart.CFrame = character.HumanoidRootPart.CFrame
end

-- Function to handle character spawning and applying outlines
local function onCharacterAdded(character)
    -- Wait for the character to be fully loaded
    character:WaitForChild("HumanoidRootPart")
    createSmoothOutline(character)

    -- Cleanup the outline when the character dies
    character:WaitForChild("Humanoid").Died:Connect(function()
        -- Remove the outline part when character dies
        local outlinePart = workspace:FindFirstChild(character.Name.."_Outline")
        if outlinePart then
            outlinePart:Destroy()
        end
    end)
end

-- Handle player respawn
if player.Character then
    onCharacterAdded(player.Character)
else
    player.CharacterAdded:Connect(onCharacterAdded)
end
