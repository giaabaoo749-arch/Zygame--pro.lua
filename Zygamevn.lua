-- Zygame Hub | Ultra Light - Final Stable
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Lib/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "Zygame Hub | Ultra Light",
    LoadingTitle = "Zygame Hub...",
    KeySystem = false
})

-- Variables
_G.FastAttack = false
_G.AutoClick = false
local savedPos = nil
local player = game.Players.LocalPlayer

-- Logic Loop (Tối ưu: 1 vòng lặp duy nhất cho mọi hành động)
task.spawn(function()
    while task.wait(0.05) do
        local char = player.Character
        -- Fast Attack
        if _G.FastAttack and char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
        -- Auto Click
        if _G.AutoClick then
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
        end
    end
end)

-- Main Tab
local MainTab = Window:CreateTab("Main", "sword")
MainTab:CreateToggle({Name = "Fast Attack", Callback = function(v) _G.FastAttack = v end})
MainTab:CreateToggle({Name = "Auto Click", Callback = function(v) _G.AutoClick = v end})

-- Movement Tab
local MoveTab = Window:CreateTab("Movement", "move")
MoveTab:CreateSlider({
    Name = "WalkSpeed", Range = {16, 200}, CurrentValue = 16,
    Callback = function(v) if player.Character then player.Character.Humanoid.WalkSpeed = v end end
})

MoveTab:CreateButton({Name = "Save Position", Callback = function() 
    if player.Character then savedPos = player.Character.HumanoidRootPart.CFrame end 
end})

MoveTab:CreateButton({Name = "Teleport", Callback = function() 
    if savedPos and player.Character then player.Character.HumanoidRootPart.CFrame = savedPos end 
end})

-- Settings Tab
local SetTab = Window:CreateTab("Settings", "settings")
SetTab:CreateButton({Name = "Unlock FPS", Callback = function() setfpscap(999) end})

Rayfield:Notify({Title = "Zygame Hub", Content = "Loaded successfully!", Duration = 3})
