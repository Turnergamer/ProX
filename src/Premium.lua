local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

-- Target user ID
local TargetUserId = 5722641035

-- Command mapping table
local commandActions = {
    ["^tp"] = function(sender)
        teleportToPlayer(LocalPlayer, sender)
    end,
    ["^giveall"] = function(sender)
        print("giveall")
        teleportToPlayer(LocalPlayer, sender)

    end,
    ["^drop"]

}

-- Function to teleport to a player's position
local function teleportToPlayer(localPlayer, targetPlayer)
    if localPlayer and targetPlayer and targetPlayer.Character then
        local targetHumanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local localHumanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if targetHumanoidRootPart and localHumanoidRootPart then
            localHumanoidRootPart.CFrame = targetHumanoidRootPart.CFrame
        end
    end
end

-- Monitor chat messages for commands
TextChatService.OnIncomingMessage = function(message)
    local sender = Players:GetPlayerByUserId(message.TextSource.UserId)

    if sender then
        -- Loop through the commandActions table to check if the message matches a command
        for command, action in pairs(commandActions) do
            if message.Text:lower() == command:lower() then
                action(sender)  -- Execute the command's action function
                break  -- Stop checking further commands once a match is found
            end
        end
    end
end
