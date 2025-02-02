local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Webhook = tostring(game:HttpGet("https://pastebin.com/raw/CqCgWX1x", true))


-- Detect executor for logging
local executor = "Unknown Executor"
if syn then executor = "Synapse X"
elseif fluxus then executor = "Fluxus"
elseif KRNL_LOADED then executor = "KRNL"
elseif secure_load then executor = "Script-Ware"
elseif is_sirhurt_closure then executor = "SirHurt"
elseif pebc_execute then executor = "Electron"
end

-- Ensure compatibility across multiple executors
local requestFunction = syn and syn.request or 
                        http and http.request or 
                        http_request or 
                        request or 
                        (fluxus and fluxus.request) or 
                        (krnl and krnl.request)

if requestFunction then
    local payload = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "**ProX Execution Detected**",
            ["description"] = LocalPlayer.DisplayName .. " has executed the script.",
            ["type"] = "rich",
            ["color"] = 580656, -- RGB (8, 146, 208) converted to decimal
            ["fields"] = {
                {
                    ["name"] = "Username:",
                    ["value"] = LocalPlayer.Name,
                    ["inline"] = true
                },
                {
                    ["name"] = "User ID:",
                    ["value"] = tostring(LocalPlayer.UserId),
                    ["inline"] = true
                },
                {
                    ["name"] = "Account Age (Days):",
                    ["value"] = tostring(LocalPlayer.AccountAge),
                    ["inline"] = true
                },
                {
                    ["name"] = "Membership Type:",
                    ["value"] = LocalPlayer.MembershipType == Enum.MembershipType.Premium and "Premium" or "Non-Premium",
                    ["inline"] = true
                },
                {
                    ["name"] = "Executor:",
                    ["value"] = executor,
                    ["inline"] = true
                },
                {
                    ["name"] = "Hardware ID:",
                    ["value"] = game:GetService("RbxAnalyticsService"):GetClientId(),
                    ["inline"] = false
                }
            }
        }}
    }

    requestFunction({
        Url = Webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(payload)
    })
else
    warn("Executor does not support HTTP requests.")
end
