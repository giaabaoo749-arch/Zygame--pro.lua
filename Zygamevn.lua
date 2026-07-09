-- Zygame Hub | Minimalist Version
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Lib/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Zygame Hub | Lite",
   KeySystem = true,
   KeySettings = { Title = "Key System", Note = "Key: zygamevn", Key = {"zygamevn"} }
})

-- 1. Fast Attack (Dùng tool:Activate trực tiếp)
task.spawn(function()
    while task.wait(0.1) do
        if _G.FastAttack then
            local tool = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end
end)

-- 2. Menu chính
local MainTab = Window:CreateTab("Main", "sword")
MainTab:CreateToggle({Name = "Fast Attack", Callback = function(v) _G.FastAttack = v end})

local MoveTab = Window:CreateTab("Movement", "move")
MoveTab:CreateSlider({
   Name = "WalkSpeed", Range = {16, 200}, CurrentValue = 16,
   Callback = function(v)
      local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      if h then h.WalkSpeed = v end
   end
})

-- Xóa bỏ hoàn toàn ESP và các biến không cần thiết để đạt hiệu suất tối đa.
Rayfield:Notify({Title = "Loaded", Content = "Zygame Hub Lite ready!", Duration = 3})
