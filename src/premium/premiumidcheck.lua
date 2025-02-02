local Premiumids = tostring(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/premium/premiumids", true))
local PREMIUMKEYS = {}

-- Convert space-separated premium keys into a table
for premkey in string.gmatch(Premiumids, "%d+") do
    table.insert(PREMIUMKEYS, premkey)
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if LocalPlayer then
    local userId = tostring(LocalPlayer.UserId)
    local isPremium = false

    for _, id in ipairs(PREMIUMKEYS) do
        if id == userId then
            isPremium = true
            break
        end
    end

    if not isPremium then
        LocalPlayer:Kick("You are not on the premium list!")
    end
end
