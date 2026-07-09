-- Zygame Hub | Minimalist Version (No Key System)
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Lib/Rayfield/main/source'))()
end)

if not success then
    warn("Rayfield failed to load. Check your internet or Executor.")
    return
end

local Window = Rayfield:CreateWindow({
    Name = "Zygame Hub | Lite",
    LoadingTitle = "Initializing...",
    KeySystem = false
})

-- Biến Fast Attack
_G.FastAttack = false

-- Logic Fast Attack (Cực nhẹ)
task.spawn(function()
    while task.wait(0.1) do
        if _G.FastAttack then
            local tool = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end
end)

-- Tạo tab
local MainTab = Window:CreateTab("Main", "sword")
MainTab:CreateToggle({
    Name = "Fast Attack",
    Callback = function(v) _G.FastAttack = v end
})

local MoveTab = Window:CreateTab("Movement", "move")
MoveTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    CurrentValue = 16,
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h.WalkSpeed = v end
    end
})

Rayfield:Notify({Title = "Zygame Hub", Content = "Loaded successfully!", Duration = 3})
