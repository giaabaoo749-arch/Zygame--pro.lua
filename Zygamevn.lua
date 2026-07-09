-- Zygame Hub | Stability Fix
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Lib/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Zygame Hub | Stable",
   LoadingTitle = "Loading Engine...",
   KeySystem = true,
   KeySettings = { Title = "Key System", Note = "Key: zygamevn", Key = {"zygamevn"} }
})

-- Biến lưu trạng thái
_G.FastAttack = false
_G.ESP = false

-- 1. Logic Fast Attack (Cực ổn định)
task.spawn(function()
    while task.wait(0.05) do
        if _G.FastAttack then
            pcall(function()
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChildOfClass("Tool") then
                    player.Character:FindFirstChildOfClass("Tool"):Activate()
                end
            end)
        end
    end
end)

-- 2. Logic ESP (Nhìn xuyên tường - Cực nhẹ)
game:GetService("RunService").RenderStepped:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local esp = player.Character:FindFirstChild("Highlight")
            if _G.ESP then
                if not esp then
                    esp = Instance.new("Highlight", player.Character)
                    esp.FillTransparency = 0.5
                    esp.OutlineTransparency = 0
                end
            else
                if esp then esp:Destroy() end
            end
        end
    end
end)

-- 3. Tạo Menu
local MainTab = Window:CreateTab("Main", "sword")
MainTab:CreateToggle({
   Name = "Fast Attack",
   Callback = function(v) _G.FastAttack = v end
})

local VisualTab = Window:CreateTab("Visuals", "eye")
VisualTab:CreateToggle({
   Name = "ESP Players (Highlight)",
   Callback = function(v) _G.ESP = v end
})

local MoveTab = Window:CreateTab("Movement", "move")
MoveTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)
      local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      if hum then hum.WalkSpeed = v end
   end
})

Rayfield:Notify({Title = "Success", Content = "Zygame Hub Loaded!", Duration = 5})
