local ids = tostring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/keys/keys", true))

local KEYS = {}
-- Convert the comma-separated keys into a table
for key in string.gmatch(ids, "%S+") do
    table.insert(KEYS, key)
end


local PREMIUMIDS = tostring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/keys/premkeys", true))

local PREMIUMKEYS = {}
-- Convert the comma-separated keys into a table
for premkey in string.gmatch(PREMIUMIDS, "%S+") do
    table.insert(PREMIUMKEYS, premkey)
end

local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local button = Instance.new("TextButton")

-- Parent the GUI to the Player's ScreenGui
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Configure the Frame
frame.Parent = screenGui
frame.Size = UDim2.new(0, 600, 0, 400) -- Increased size
frame.Position = UDim2.new(0.2, 0, 0.15, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 15)
frameCorner.Parent = frame

-- Title Label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.Position = UDim2.new(-0.42, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ProX"
TitleLabel.TextColor3 = Color3.fromRGB(8, 146, 208)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.ArialBold
TitleLabel.Parent = frame

-- Key Input Box
local keyInputBox = Instance.new("TextBox")
keyInputBox.Size = UDim2.new(0.6, 0, 0.1, 0) -- 60% width and 10% height of the frame
keyInputBox.Position = UDim2.new(0.1, 0, 0.3, 0) -- Positioned slightly below the title
keyInputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
keyInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInputBox.ClearTextOnFocus = true
keyInputBox.PlaceholderText = "Enter Key Here"
keyInputBox.TextScaled = true
keyInputBox.Font = Enum.Font.Arial
keyInputBox.Parent = frame
keyInputBox.Text = "Enter Key Here"
keyInputBox.ClearTextOnFocus = true
keyInputBox.TextScaled = true  -- Disable TextScaled to use TextSize
keyInputBox.TextSize = 24 
local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0, 10)
keyBoxCorner.Parent = keyInputBox

-- Enter Button
local enterButton = Instance.new("TextButton")
enterButton.Size = UDim2.new(0.2, 0, 0.1, 0) -- 30% width and 10% height of the frame
enterButton.Position = UDim2.new(0.7, 0, 0.3, 0) -- Positioned below the input box
enterButton.BackgroundColor3 = Color3.fromRGB(8, 146, 208)
enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
enterButton.Text = "Enter"
enterButton.TextScaled = true
enterButton.Font = Enum.Font.ArialBold
enterButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = enterButton

-- Button functionality (can be customized)
enterButton.MouseButton1Click:Connect(function()
    local key = keyInputBox.Text
    -- Check if the entered key exists in the KEYS table
    local validKey = false
    for _, storedKey in ipairs(KEYS) do
        if storedKey == key then
            validKey = true
            break
        end
    end
    local premkey = keyInputBox.Text
    -- Check if the entered key exists in the KEYS table
    local premvalidKey = false
    for _, premstoredKey in ipairs(PREMIUMKEYS) do
        if premstoredKey == premkey then
            premvalidKey = true
            break
        end
    end
    if premvalidKey then
        print("Key is valid: " .. key)
        -- You can add any action here when the key is valid
        keyInputBox.Text = "Key Accepted"
        keyInputBox.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green color for success
        wait(1) -- Optional delay before destroying
        screenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/main.lua", true))()
    else
        print("Invalid key: " .. key)
        -- You can add any action here when the key is invalid
        keyInputBox.Text = "Invalid Key"
        keyInputBox.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red color for error
    
    -- Display feedback to the user
    if validKey then
        print("Key is valid: " .. key)
        -- You can add any action here when the key is valid
        keyInputBox.Text = "Key Accepted"
        keyInputBox.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green color for success
        wait(1) -- Optional delay before destroying
        screenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/main.lua", true))()
    else
        print("Invalid key: " .. key)
        -- You can add any action here when the key is invalid
        keyInputBox.Text = "Invalid Key"
        keyInputBox.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red color for error
    end
end)
