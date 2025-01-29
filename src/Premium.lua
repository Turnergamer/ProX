local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

---args for commands
local dropargs = {
    [1] = "DropItem"
}

--- Target user ID (Player who will be able to trigger the commands)
local TargetUserId = 5722641035

-- Function to teleport to a player's position
local function teleportToPlayer(localPlayer, targetPlayer)
    if localPlayer and targetPlayer and targetPlayer.Character then
        -- Wait for the player's HumanoidRootPart to be loaded
        local targetHumanoidRootPart = targetPlayer.Character:WaitForChild("HumanoidRootPart", 5)
        local localHumanoidRootPart = localPlayer.Character:WaitForChild("HumanoidRootPart", 5)

        if targetHumanoidRootPart and localHumanoidRootPart then
            -- Teleport the local player to the target player's position
            localHumanoidRootPart.CFrame = targetHumanoidRootPart.CFrame
        else
            warn("HumanoidRootPart not found for one of the players!")
        end
    else
        warn("One or both characters are missing or not loaded!")
    end
end

-- Function to store the current position of the local player
local function getPlayerPosition(localPlayer)
    local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        return humanoidRootPart.CFrame
    else
        warn("HumanoidRootPart not found!")
        return nil
    end
end

-- Command mapping table to easily add more commands
local commandActions = {
    ["tp"] = function(sender)
        teleportToPlayer(LocalPlayer, sender)
    end,
    ["giveall"] = function(sender)
        print("giveall triggered")
        teleportToPlayer(LocalPlayer, sender)
    end,
    ["drop"] = function(sender)
        -- Store the current position of the LocalPlayer before dropping the item
        local originalPosition = getPlayerPosition(LocalPlayer)
        
        -- Drop item by firing the RemoteEvent
        teleportToPlayer(LocalPlayer, sender)
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(dropargs))
        print("DROP triggered")

        -- Teleport the player back to the original position after the drop
        if originalPosition then
            wait(1)  -- Optional: Add a delay if necessary to simulate a return after the drop
            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = originalPosition
            print("Returned to original position")
        end
    end,
    ["kick"] = function(sender)
        -- Kick the local player with a custom message
        LocalPlayer:Kick("You have been kicked by a premium user.")
        print("KICK triggered")
    end
}

-- Monitor chat messages for commands
TextChatService.OnIncomingMessage = function(message)
    local sender = Players:GetPlayerByUserId(message.TextSource.UserId)

    if sender then
        -- Check if the sender matches the target user ID and message matches a command
        if sender.UserId == TargetUserId then
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
