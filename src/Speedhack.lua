local tpwalking = false  -- Start with tpwalking off

game:GetService("RunService").Heartbeat:Connect(function(delta)
    local chr = game.Players.LocalPlayer.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

    if hum and hum.MoveDirection.Magnitude > 0 then
        if tpwalking then
            local tpValue = 5  -- Always use 5 as the teleport distance
            chr:TranslateBy(hum.MoveDirection * tpValue * delta * 10)  -- Apply teleportation
        end
    end

    -- Toggle tpwalking on and off each time the script runs
    tpwalking = not tpwalking
end)
