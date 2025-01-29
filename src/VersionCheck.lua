local version = tonumber(game:HttpGet("https://raw.githubusercontent.com/Turnergamer/ProX/refs/heads/main/src/Version", true))
print(version)
if version ~= 1 then
    game.Players.LocalPlayer:Kick("Your version is not valid. Please update.")
else
    print("Version is valid.")
end
