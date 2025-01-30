local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TeleportEnabled = false  -- Initially set to false
local safePosition = Vector3.new(166, -0, -956)
local startTeleportPosition = Vector3.new(-609, 6, -12)
local stopPosition = Vector3.new(-632, 6, -12)  -- Updated the stop position

print("Script loaded successfully")

-- Function to teleport to a position
local function teleportToPosition(position)
    if LocalPlayer and LocalPlayer.Character then
        LocalPlayer.Character:MoveTo(position)
        print("Teleported to position:", position)
    end
end

-- Function to handle special interaction with Gunner Jayce
local function handleGunnerJayce(prompt)
    wait(1)
    teleportToPosition(prompt.Parent.Position) -- Teleport to the NPC again
    wait(1)
    fireproximityprompt(prompt)
    print("Interacting with Gunner Jayce")
    wait(2)
    local args = {
        [1] = "DialogueChoice",
        [2] = "Let me see."
    }
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    print("Fired DialogueChoice for Gunner Jayce")
    fireproximityprompt(prompt)
    teleportToPosition(safePosition)
    wait(20)
end

-- Function to handle special interaction with The Leader
local function handleTheLeader(prompt)
    wait(1)
    teleportToPosition(prompt.Parent.Position) -- Teleport to the NPC again
    wait(1)
    fireproximityprompt(prompt)
    print("Interacting with The Leader")
    wait(2)
    local args = {
        [1] = "DialogueChoice",
        [2] = "Any tips?"
    }
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    print("Fired DialogueChoice for The Leader - Any tips?")
    wait(2)
    args = {
        [1] = "DialogueChoice",
        [2] = "Trade?"
    }
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    print("Fired DialogueChoice for The Leader - Trade?")
    wait(1)
    fireproximityprompt(prompt)
    wait(1)
    teleportToPosition(safePosition)
    wait(15)
end

-- Function to claim storage
local function claimStorage()
    teleportToPosition(startTeleportPosition)
    wait(10)  -- Updated to wait 10 seconds
    local args = {
        [1] = "ClaimStorage",
        [2] = workspace.Storages.Room
    }
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    print("Claimed storage")
end

-- Function to repeatedly equip the item in the second slot every 15 seconds
local function loopEquipSecondSlotItem()
    while TeleportEnabled do
        if LocalPlayer and LocalPlayer.Backpack then
            local backpackItems = LocalPlayer.Backpack:GetChildren()
            if #backpackItems >= 2 then
                local secondSlotItem = backpackItems[2]  -- Get the second item in the backpack
                if secondSlotItem and secondSlotItem:IsA("Tool") then
                    LocalPlayer.Character.Humanoid:EquipTool(secondSlotItem)
                    print("Equipped second slot item:", secondSlotItem.Name)
                end
            end
        end
        wait(15)  -- Loop every 15 seconds
    end
end

-- Function to execute the list of actions in sequence, with a 1-second delay between each
local function executeStoreBankActions()
    while TeleportEnabled do
        local actions = {
            {"StoreBank", "Eight", "10"},
            {"StoreBank", "Four", "10"},
            {"StoreBank", "Five", "10"},
            {"StoreBank", "Six", "10"},
            {"StoreBank", "Thirteen", "10"},
            {"StoreBank", "Fourteen", "10"},
            {"StoreBank", "Eleven", "10"},
            {"StoreBank", "Nine", "10"},
            {"StoreBank", "Ten", "10"},
            {"StoreBank", "Twelve", "1"},
            {"StoreBank", "Two", "1"}
        }

        for _, args in ipairs(actions) do
            print("Firing server with args:", args[1], args[2], args[3])  -- Debug print statement
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            wait(1)  -- Wait 1 second before executing the next action
        end
    end
end

-- Function to handle special interaction with Coleman
local function handleColeman(prompt)
    wait(1)
    teleportToPosition(prompt.Parent.Position) -- Teleport to the NPC again
    wait(1)
    fireproximityprompt(prompt)
    print("Interacting with Coleman")
    wait(1)
    local args = {
        [1] = "DialogueChoice",
        [2] = "Yes!"
    }
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    print("Fired DialogueChoice for Coleman")
    wait(1)
    fireproximityprompt(prompt)
    wait(1)
    teleportToPosition(safePosition)
    wait(15)
end

-- Function to handle special interaction with Teuchi
local function handleTeuchi(prompt)
    wait(1)
    teleportToPosition(prompt.Parent.Position) -- Teleport to the NPC again
    wait(1)
    fireproximityprompt(prompt)
    print("Interacting with Teuchi")
    wait(1)
    local args = {
        [1] = "DialogueChoice",
        [2] = "Sure!"
    }
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    print("Fired DialogueChoice for Teuchi")
    wait(1)
    fireproximityprompt(prompt)
    wait(1)
    teleportToPosition(safePosition)
    wait(15)
end

-- Function to handle special interaction with Priest Jonathan
local function handlePriestJonathan(prompt)
    wait(1)
    teleportToPosition(prompt.Parent.Position) -- Teleport to the NPC again
    wait(1)
    fireproximityprompt(prompt)
    print("Interacting with Priest Jonathan")
    wait(1)
    local args = {
        [1] = "DialogueChoice",
        [2] = "Yes!"
    }
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    print("Fired DialogueChoice for Priest Jonathan")
    wait(1)
    fireproximityprompt(prompt)
    wait(1)
    teleportToPosition(safePosition)
    wait(15)
end

-- Function to check clock time and teleport to the safe zone if it's 1140
local function checkClockTimeAndTeleport()
    while TeleportEnabled do
        local clockTime = game.Lighting.ClockTime
        if clockTime == 1140 then
            teleportToPosition(safePosition)
            print("Teleporting to safe zone at 1140")
            wait(90)  -- Wait 90 seconds in the safe zone
        end
        wait(1)
    end
end

-- Start checking clock time in a separate thread
spawn(checkClockTimeAndTeleport)

-- Function to fire the ProximityPrompt and check for specific prompts
local function fireProximityPrompt()
    for _, prompt in ipairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            if prompt.ActionText == "Open" and prompt.ObjectText == "Storage Door" then
                fireproximityprompt(prompt)
                print("Fired ProximityPrompt for Storage Door")
            elseif prompt.ActionText == "Interact" then
                local objectText = prompt.ObjectText
                if objectText == "Gunner Jayce" then
                    teleportToPosition(prompt.Parent.Position)
                    wait(1)
                    teleportToPosition(prompt.Parent.Position) -- Teleport to the NPC again
                    wait(1)
                    handleGunnerJayce(prompt)
                    return true  -- Exit the loop after handling Gunner Jayce
                elseif objectText == "Coleman" or objectText == "Priest Jonathan" or objectText == "The Leader" then
                    teleportToPosition(prompt.Parent.Position)
                    wait(1)
                    teleportToPosition(prompt.Parent.Position) -- Teleport to the NPC again
                    wait(1)
                    if objectText == "The Leader" then
                        handleTheLeader(prompt)
                    elseif objectText == "Coleman" then
                        handleColeman(prompt)
                    elseif objectText == "Priest Jonathan" then
                        handlePriestJonathan(prompt)
                    end
                    return true  -- Exit the loop after finding the NPC
                elseif objectText == "Teuchi" then
                    teleportToPosition(prompt.Parent.Position)
                    wait(1)
                    teleportToPosition(prompt.Parent.Position) -- Teleport to the NPC again
                    wait(1)
                    handleTeuchi(prompt)
                    return true  -- Exit the loop after handling Teuchi
                end
            end
        end
    end
    return false  -- If no specified "Interact" ProximityPrompt was found
end

-- Create buttons for starting/stopping teleportation
local function createButtons()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local teleportButton = Instance.new("TextButton", screenGui)
    teleportButton.Size = UDim2.new(0, 200, 0, 50)
    teleportButton.Position = UDim2.new(1, -210, 0, 60)  -- Position the button appropriately
    teleportButton.Text = "Start Teleportation"
    teleportButton.BackgroundColor3 = Color3.fromRGB(0, 255, 128)  -- Make the button stand out
    teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
    teleportButton.BorderSizePixel = 2  -- Add a border for better visibility
    teleportButton.BorderColor3 = Color3.fromRGB(255, 255, 255)  -- White border

    print("Button created")

    -- Connect the teleport button press event to start/stop teleportation
    teleportButton.MouseButton1Click:Connect(function()
        TeleportEnabled = not TeleportEnabled
        if TeleportEnabled then
            teleportButton.Text = "Stop Teleportation"
            print("Teleportation started")
            spawn(mainLoop)  -- Start teleportation
            spawn(loopEquipSecondSlotItem)  -- Start equipping the second slot item
            spawn(executeStoreBankActions)  -- Start executing store bank actions
        else
            teleportButton.Text = "Start Teleportation"
            print("Teleportation stopped")
            teleportToPosition(Vector3.new(-632, 6, -12))  -- Teleport to the specified position when stopped
        end
    end)
end

-- Create the buttons
createButtons()

-- Function to execute teleport sets
local function executeTeleportSet(positions)
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return false
    end

    local lastHealth = humanoid.Health

    -- Function to check for damage
    local function checkForDamage()
        local currentHealth = humanoid.Health
        if currentHealth < lastHealth then
            teleportToPosition(safePosition)  -- Teleport to the safe zone
            print("Health dropped, teleporting to safe zone")
            wait(90)  -- Wait 90 seconds
            lastHealth = humanoid.Health  -- Update last health
            return true
        end
        lastHealth = currentHealth  -- Update last health
        return false
    end

    for _, pos in ipairs(positions) do
        if not TeleportEnabled then 
            return false 
        end

        if checkForDamage() then
            return false
        end

        -- First teleport
        teleportToPosition(pos)
        print("Teleported to position:", pos)
        wait(0.1)  -- Quick wait before next teleport

        -- Second teleport
        teleportToPosition(pos)
        print("Teleported again to position:", pos)
        wait(0.5)  -- Extra wait before next teleport
        wait(0.5)  -- Additional wait to make it a total of 1 second before the next teleport
        if fireProximityPrompt() then
            wait(1)  -- Wait 1 second after finding NPC
            return true
        end
        wait(0.1)  -- 0.1-second wait before next teleport
    end

    return true
end

-- Main function to execute all teleports
local function executeTeleports()
    claimStorage()  -- Claim storage at the start
    local primaryPositions = {
        Vector3.new(-571, 6, -52),
        Vector3.new(-428, 6, -25),
        Vector3.new(-309, 6, -25),
        Vector3.new(-357, 6, -129),
        Vector3.new(-524, 6, -129),
        Vector3.new(-548, 6, -206),
        Vector3.new(-84, 6, -206),
        Vector3.new(83, 6, -206),
        Vector3.new(-84, 6, -129),
        Vector3.new(83, 6, 52),
        Vector3.new(83, 6, 129),
        Vector3.new(-83, 6, 129),
        Vector3.new(-83, 6, 206),
        Vector3.new(357, 6, 206),
        Vector3.new(476, 6, 207),
        Vector3.new(356, 6, -52),
        Vector3.new(523, 6, -51),
        Vector3.new(523, 6, -130),
        Vector3.new(356, 6, -206),
        Vector3.new(523, 6, -206)
    }

    local secondaryPositions = {
        Vector3.new(594, 5, 203),
        Vector3.new(286, 5, 202),
        Vector3.new(521, 6, -52),
        Vector3.new(355, 6, -51),
        Vector3.new(358, 6, -130),
        Vector3.new(593, 5, -203),
        Vector3.new(310, 6, -206)
    }

    local tertiaryPositions = {
        Vector3.new(153, 5, -204),
        Vector3.new(-153, 5, -203),
        Vector3.new(85, 6, -129),
        Vector3.new(83, 6, 53),
        Vector3.new(-84, 6, 53),
        Vector3.new(-82, 6, 130),
        Vector3.new(85, 6, 129),
        Vector3.new(130, 6, 206),
        Vector3.new(-153, 5, 201)
    }

    local fourthPositions = {
        Vector3.new(-610, 6, -65),
        Vector3.new(-522, 6, -25),
        Vector3.new(-356, 6, -53),
        Vector3.new(-270, 6, -13),
        Vector3.new(-271, 6, 89),
        Vector3.new(-170, 6, 65),
        Vector3.new(-171, 6, -89),
        Vector3.new(-82, 6, -26),
        Vector3.new(130, 6, -24),
        Vector3.new(171, 6, -87),
        Vector3.new(171, 6, 90),
        Vector3.new(271, 6, 68),
        Vector3.new(355, 6, 24),
        Vector3.new(522, 6, 52),
        Vector3.new(610, 6, -10),
        Vector3.new(610, 6, -89)
    }

    while TeleportEnabled do
        if not executeTeleportSet(primaryPositions) then return end
        if not executeTeleportSet(secondaryPositions) then return end
        if not executeTeleportSet(tertiaryPositions) then return end
        if not executeTeleportSet(fourthPositions) then return end
        teleportToPosition(safePosition)
        wait(40)  -- Wait 40 seconds in the safe zone
    end
end

-- Main execution loop
local function mainLoop()
    while true do
        if TeleportEnabled then
            executeTeleports()  -- Perform teleport actions

            -- Ensure actions are executed every 10 seconds
            wait(10)
        else
            wait(1)  -- Wait 1 second before checking again
        end
    end
end

-- Start the main loop
spawn(mainLoop)
