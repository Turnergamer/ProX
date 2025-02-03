getgenv().animpos = 1.755
getgenv().underground = -3.6

local enabled = false
local runserv = game:GetService("RunService")
local lplr = game:GetService("Players").LocalPlayer
local animation = Instance.new("Animation")
animation.AnimationId = "http://www.roblox.com/asset/?id=15693621070"
local danceTrack
local dysenc = {}
local temp = 1

_G.DsyncCheck = _G.DsyncCheck or false  -- Default to false if not set

spawn(function()
    while true do
        if _G.DsyncCheck then
            pcall(function()
                if not enabled then
                    enabled = true
                    danceTrack = lplr.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(animation)
                    danceTrack.Looped = false
                    danceTrack:Play(.1, 1, 0)
                end
            end)
        else
            if enabled then
                enabled = false
                if danceTrack then
                    danceTrack:Stop()
                    danceTrack:Destroy()
                end
            end
        end
        wait(0.5) -- Adjust timing to optimize performance
    end
end)

runserv.Heartbeat:Connect(function()
    temp = temp + 1
    if enabled and lplr.Character and lplr.Character.HumanoidRootPart then
        danceTrack.TimePosition = animpos
        dysenc[1] = lplr.Character.HumanoidRootPart.CFrame
        dysenc[2] = lplr.Character.HumanoidRootPart.AssemblyLinearVelocity
        local SpoofThis = lplr.Character.HumanoidRootPart.CFrame
        SpoofThis = SpoofThis + Vector3.new(0, getgenv().underground, 0)
        lplr.Character.HumanoidRootPart.CFrame = SpoofThis
        runserv.RenderStepped:Wait()
        if lplr.Character and lplr.Character.HumanoidRootPart then
            lplr.Character.HumanoidRootPart.CFrame = dysenc[1]
            lplr.Character.HumanoidRootPart.AssemblyLinearVelocity = dysenc[2]
        end
    end
end)
