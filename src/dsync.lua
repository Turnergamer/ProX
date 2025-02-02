getgenv().animpos = 1.755
getgenv().underground = -3.6

local enabled = false
local runserv = game:GetService("RunService")
local lplr = game:GetService("Players").LocalPlayer
local mouse = lplr:GetMouse()
local animation = Instance.new("Animation")
animation.AnimationId = "http://www.roblox.com/asset/?id=15693621070"
local danceTrack

-- Check if _G.DsyncCheck is true, and enable or disable the feature accordingly
if _G.DsyncCheck then
    -- Enable dsync (like the previous behavior)
    pcall(function()
        if enabled == false then
            enabled = true
            danceTrack = lplr.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(animation)
            danceTrack.Looped = false
            danceTrack:Play(.1, 1, 0)
            print("Dsync is enabled!")
        end
    end)
else
    -- Disable dsync if _G.DsyncCheck is false
    if enabled then
        enabled = false
        if danceTrack then
            danceTrack:Stop()
            danceTrack:Destroy()
        end
        print("Dsync is disabled!")
    end
end

local dysenc = {}
local temp = 1
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
