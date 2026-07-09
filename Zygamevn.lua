-- Zygame Hub | Ultimate Final Version
-- Tối ưu hóa: Fast Attack, ESP Players, Movement, Teleport
local _ENV = (getgenv or getrenv or getfenv)()

-- 1. Load Rayfield UI
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)
if not success then return end

-- 2. Variables
_G.FastAttack = false
_G.AutoClick = false
_G.ESPEnabled = false
_G.AttackSpeed = 0.05
_G.WalkSpeed = 16
_G.JumpPower = 50
_G.LockSpeed = false
local savedPosition = nil

-- 3. Logic: Fast Attack (Optimized)
task.spawn(function()
    while task.wait(_G.AttackSpeed) do 
        if _G.FastAttack then
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local tool = char and char:FindFirstChildOfClass("Tool")
                if tool then
                    local remote = tool:FindFirstChild("Attack") or tool:FindFirstChild("ServerClick")
                    if remote and remote:IsA("RemoteEvent") then remote:FireServer()
                    else tool:Activate() end
                end
            end)
        end
    end
end)

-- 4. Logic: ESP System
local function createESP(player)
    local box = Drawing.new("Square")
    box.Visible = false; box.Color = Color3.fromRGB(255, 0, 0); box.Thickness = 1; box.Filled = false
    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.ESPEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then box.Visible = true; box.Position = Vector2.new(pos.X - 25, pos.Y - 50); box.Size = Vector2.new(50, 100)
            else box.Visible = false end
        else box.Visible = false end
    end)
    player.AncestryChanged:Connect(function() if not player:IsDescendantOf(game.Players) then box:Remove() end end)
end
for _, p in pairs(game.Players:GetPlayers()) do if p ~= game.Players.LocalPlayer then createESP(p) end end
game.Players.PlayerAdded:Connect(createESP)

-- 5. Logic: Global Updates (Movement & Misc)
game:GetService("RunService").RenderStepped:Connect(function()
    -- Movement Lock
    if _G.LockSpeed then
        pcall(function()
            local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then
                if hum.WalkSpeed ~= _G.WalkSpeed then hum.WalkSpeed = _G.WalkSpeed end
                if hum.JumpPower ~= _G.JumpPower then hum.JumpPower = _G.JumpPower end
            end
        end)
    end
    -- Auto Click
    if _G.AutoClick then
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.01)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end
end)

-- 6. GUI Setup
local Window = Rayfield:CreateWindow({Name = "Zygame Hub | Ultimate", LoadingTitle = "Loading...", KeySystem = true, KeySettings = {Title = "Key System", Note = "Key: zygamevn", Key = {"zygamevn"}}})

local MainTab = Window:CreateTab("Main", "sword")
MainTab:CreateToggle({Name = "Fast Attack", Callback = function(v) _G.FastAttack = v end})
MainTab:CreateToggle({Name = "Auto Click", Callback = function(v) _G.AutoClick = v end})

local MoveTab = Window:CreateTab("Movement", "move")
MoveTab:CreateToggle({Name = "Lock Speed & Jump", Callback = function(v) _G.LockSpeed = v end})
MoveTab:CreateSlider({Name = "WalkSpeed", Range = {16, 300}, CurrentValue = 16, Callback = function(v) _G.WalkSpeed = v end})
MoveTab:CreateSlider({Name = "JumpPower", Range = {50, 500}, CurrentValue = 50, Callback = function(v) _G.JumpPower = v end})

local VTPTab = Window:CreateTab("Visuals & TP", "map")
VTPTab:CreateToggle({Name = "Enable ESP Players", Callback = function(v) _G.ESPEnabled = v end})
VTPTab:CreateButton({Name = "Save Position", Callback = function() savedPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame; Rayfield:Notify({Title = "TP", Content = "Saved!", Duration = 2}) end})
VTPTab:CreateButton({Name = "Teleport to Saved", Callback = function() if savedPosition then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedPosition end end})

local SettingsTab = Window:CreateTab("Settings", "settings")
SettingsTab:CreateSlider({Name = "Attack Delay", Range = {0.01, 0.5}, Increment = 0.01, CurrentValue = 0.05, Callback = function(v) _G.AttackSpeed = v end})
SettingsTab:CreateButton({Name = "Unlock FPS", Callback = function() setfpscap(999) end})

Rayfield:Notify({Title = "Zygame Hub", Content = "Ultimate Loaded!", Duration = 5})

