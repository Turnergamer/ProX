-- Configuration
local espEnabled = true
local boxEnabled = true
local nameEnabled = true
local healthEnabled = true
local tracerEnabled = true

-- Colors
local boxColor = Color3.fromRGB(255, 0, 0) -- Red
local tracerColor = Color3.fromRGB(0, 0, 255) -- Blue
local friendColor = Color3.fromRGB(0, 255, 0) -- Green (Example for friend detection)

-- Functions

local function drawBox(player, color)
    local head = player.Character:FindFirstChild("Head")
    if not head then return end

    local screenPosition = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
    if not screenPosition then return end

    local size = head.Size
    local x = screenPosition.X - size.X / 2
    local y = screenPosition.Y - size.Y
    local width = size.X
    local height = size.Y * 1.5 -- Adjust height as needed

    local frame = Instance.new("Frame")
    frame.Parent = game.Players.LocalPlayer.PlayerGui
    frame.Name = "ESPBox"
    frame.BackgroundColor3 = color
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new(0, x, 0, y)
    frame.Size = UDim2.new(0, width, 0, height)
    frame.ZIndex = 5 -- Ensure it's on top
    return frame -- return the frame so we can destroy it later
end

local function drawName(player, color)
    local head = player.Character:FindFirstChild("Head")
    if not head then return end

    local screenPosition = workspace.CurrentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0)) -- Offset above head
    if not screenPosition then return end

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = game.Players.LocalPlayer.PlayerGui
    textLabel.Name = "ESPName"
    textLabel.Text = player.Name
    textLabel.TextColor3 = color
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 14
    textLabel.Position = UDim2.new(0, screenPosition.X - 50, 0, screenPosition.Y) -- Adjust offset as needed
    textLabel.Size = UDim2.new(0, 100, 0, 20) -- Adjust size as needed
    textLabel.ZIndex = 5
    return textLabel
end

local function drawHealth(player, color)
    local head = player.Character:FindFirstChild("Head")
    if not head then return end

    local screenPosition = workspace.CurrentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.5, 0)) -- Offset above head
    if not screenPosition then return end

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = game.Players.LocalPlayer.PlayerGui
    textLabel.Name = "ESPHealth"
    textLabel.Text = math.floor(player.Character.Humanoid.Health)
    textLabel.TextColor3 = color
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 14
    textLabel.Position = UDim2.new(0, screenPosition.X - 25, 0, screenPosition.Y) -- Adjust offset as needed
    textLabel.Size = UDim2.new(0, 50, 0, 20) -- Adjust size as needed
    textLabel.ZIndex = 5
    return textLabel
end


local function drawTracer(player, color)
    local head = player.Character:FindFirstChild("Head")
    if not head then return end

    local screenPosition = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
    if not screenPosition then return end

    local line = Instance.new("Part")
    line.Parent = workspace.CurrentCamera
    line.Name = "ESPTracer"
    line.Anchored = true
    line.CanCollide = false
    line.Transparency = 0.5
    line.Material = Enum.Material.Neon
    line.Color = color

    local distance = (head.Position - workspace.CurrentCamera.CFrame.p).Magnitude
    line.Size = Vector3.new(0.1, 0.1, distance) -- Thin line
    line.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, head.Position) * CFrame.new(0, 0, -distance/2)
    return line
end

local function clearESP(player)
    for _, obj in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if obj.Name == "ESPBox" and obj:FindFirstAncestorWhichIsA("ScreenGui") then obj:Destroy() end
        if obj.Name == "ESPName"and obj:FindFirstAncestorWhichIsA("ScreenGui") then obj:Destroy() end
        if obj.Name == "ESPHealth"and obj:FindFirstAncestorWhichIsA("ScreenGui") then obj:Destroy() end
    end
    for _, obj in pairs(workspace.CurrentCamera:GetChildren()) do
         if obj.Name == "ESPTracer" then obj:Destroy() end
    end
end


-- Main Loop
game:GetService("RunService").RenderStepped:Connect(function()
    if not espEnabled then return end

    for _, player in pairs(game.Players:GetPlayers()) do
        if player == game.Players.LocalPlayer or not player.Character or not player.Character:FindFirstChild("Humanoid") then continue end

       clearESP(player) -- Clear previous ESP elements

        local color = boxColor -- Default color
        if player:GetAttribute("IsFriend") then color = friendColor end -- Example friend check

        if boxEnabled then drawBox(player, color) end
        if nameEnabled then drawName(player, color) end
        if healthEnabled then drawHealth(player, color) end
        if tracerEnabled then drawTracer(player, tracerColor) end
    end
end)

-- Toggle (Example: Press 'E' to toggle)
local contextActionService = game:GetService("ContextActionService")
contextActionService:BindAction("ToggleESP", function()
    espEnabled = not espEnabled
    if not espEnabled then
       for _, player in pairs(game.Players:GetPlayers()) do
           clearESP(player)
       end
    end
end, false, Enum.KeyCode.E)


print("ESP Loaded")