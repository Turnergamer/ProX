local HttpService = game:GetService("HttpService")
local url = "https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/Version"

-- Function to fetch and check the version
local function checkVersion()
    -- Fetch the raw data from the URL
    local response
    local success, err = pcall(function()
        response = HttpService:GetAsync(url)
    end)

    if not success then
        warn("Failed to fetch version data: " .. err)
        return
    end

    -- Convert the response to a number (assuming the response is a number in string format)
    local versionNumber = tonumber(response)

    if versionNumber == nil then
        warn("Version data is not a valid number.")
        return
    end

    -- Check if the version is 1
    if versionNumber ~= 1 then
        -- If version is not 1, kick the player
        game.Players.LocalPlayer:Kick("Your version is not valid. Please update.")
    else
        print("Version is valid.")
    end
end

-- Call the function to check the version
checkVersion()
