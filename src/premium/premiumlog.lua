local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Webhook = tostring(game:HttpGet("https://pastebin.com/raw/43uth6Zh", true))

-- Detect executor for logging
local executor = "Unknown Executor"
if syn then executor = "Synapse X"
elseif fluxus then executor = "Fluxus"
elseif KRNL_LOADED then executor = "KRNL"
elseif secure_load then executor = "Script-Ware"
elseif is_sirhurt_closure then executor = "SirHurt"
elseif pebc_execute then executor = "Electron"
elseif vape then executor = "Vape V3" -- Example, add more as needed
elseif Sentinel then executor = "Sentinel" -- Example
elseif evon then executor = "Evon" -- Example
elseif owlhub then executor = "Owl Hub" -- Example
elseif protosmasher then executor = "Protosmasher" -- Example
elseif comet then executor = "Comet" -- Example
elseif trigon then executor = "Trigon" -- Example
elseif codex then executor = "Codex" -- Example
elseif infiniteyield then executor = "Infinite Yield" -- Example (Although this is a framework, not strictly an executor)
end


-- Function to send the webhook (handles different request methods)
local function sendWebhook(payload)
    local success = false
    local attempts = 0
    local maxAttempts = 3 -- Try multiple times in case of errors

    while not success and attempts < maxAttempts do
        attempts += 1
        pcall(function() -- Use pcall to handle potential errors
            if syn and syn.request then
                syn.request({
                    Url = Webhook,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = HttpService:JSONEncode(payload)
                })
                success = true
            elseif fluxus and fluxus.request then
                fluxus.request({
                    Url = Webhook,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = HttpService:JSONEncode(payload)
                })
                success = true
            elseif krnl and krnl.request then -- KRNL's request function may need adjustments
                krnl.request({
                    url = Webhook, -- Note the lowercase 'url'
                    method = "POST",
                    headers = {["Content-Type"] = "application/json"},
                    body = HttpService:JSONEncode(payload)
                })
                success = true
            elseif http and http.request then
                http.request({
                    url = Webhook,
                    method = "POST",
                    headers = {["Content-Type"] = "application/json"},
                    body = HttpService:JSONEncode(payload)
                })
                success = true
            elseif http_request then -- Generic http_request (less common)
                http_request({
                    url = Webhook,
                    method = "POST",
                    headers = {["Content-Type"] = "application/json"},
                    body = HttpService:JSONEncode(payload)
                })
                success = true
            elseif request then -- Another generic request
                request({
                    url = Webhook,
                    method = "POST",
                    headers = {["Content-Type"] = "application/json"},
                    body = HttpService:JSONEncode(payload)
                })
                success = true
            else
                warn("No compatible request function found. Trying HttpService directly.")
                HttpService:PostAsync(Webhook, HttpService:JSONEncode(payload)) -- Fallback to HttpService
                success = true -- Assume success, though this may not always be the case
            end
        end)

        if not success then
            wait(1) -- Wait before retrying
        end
    end

    if not success then
        warn("Failed to send webhook after multiple attempts.")
    end
end


-- Create the payload
local payload = {
    ["content"] = "",
    ["embeds"] = {{
        ["title"] = "**ProX Premium Execution Detected**",
        ["description"] = LocalPlayer.DisplayName.. " has executed the script.",
        ["type"] = "rich",
        ["color"] = 580656,
        ["fields"] = {
            {["name"] = "Username:", ["value"] = LocalPlayer.Name, ["inline"] = true},
            {["name"] = "User ID:", ["value"] = tostring(LocalPlayer.UserId), ["inline"] = true},
            {["name"] = "Account Age (Days):", ["value"] = tostring(LocalPlayer.AccountAge), ["inline"] = true},
            {["name"] = "Membership Type:", ["value"] = LocalPlayer.MembershipType == Enum.MembershipType.Premium and "Premium" or "Non-Premium", ["inline"] = true},
            {["name"] = "Executor:", ["value"] = executor, ["inline"] = true},
            {["name"] = "Hardware ID:", ["value"] = game:GetService("RbxAnalyticsService"):GetClientId(), ["inline"] = false}
        }
    }}
}

sendWebhook(payload) -- Send the webhook using the unified function