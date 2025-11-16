-- Hehe Hub - Gen Z UI, Tabs, Bounce-In, Buttons & Toggles

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HeheHubUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.IgnoreGuiInset = true

local FRAME_W, FRAME_H = 430, 375

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, FRAME_W, 0, FRAME_H)
mainFrame.Position = UDim2.new(0.5, -FRAME_W/2, 0, -FRAME_H-60)
mainFrame.BackgroundColor3 = Color3.fromRGB(110, 140, 255)
mainFrame.BackgroundTransparency = 0.03
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 20)
frameCorner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Hehe Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 32
title.TextColor3 = Color3.fromRGB(40,40,60)

-- Tab buttons
local tabNames = {"Main", "ESP", "Misc", "Credits"}
local tabButtons = {}
local tabHeight = 36
for i,name in ipairs(tabNames) do
local btn = Instance.new("TextButton")
btn.Parent = mainFrame
btn.Size = UDim2.new(0, 90, 0, tabHeight)
btn.Position = UDim2.new(0, ((i-1)*96)+12, 0, 52)
btn.Text = name
btn.BackgroundColor3 = Color3.fromRGB(140, 170, 255)
btn.TextColor3 = Color3.fromRGB(30,30,70)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.Name = "Tab_"..name
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 14)
btnCorner.Parent = btn
tabButtons[name] = btn
end

-- Tabs content containers
local tabContents = {}
for i,name in ipairs(tabNames) do
local content = Instance.new("Frame")
content.Parent = mainFrame
content.Size = UDim2.new(1,-28,1,-108)
content.Position = UDim2.new(0,14,0,95)
content.BackgroundTransparency = 1
content.Visible = (i==1) -- Only first tab visible at start
tabContents[name] = content
end

-- === Main Tab ===
local buttonSample = Instance.new("TextButton")
buttonSample.Parent = tabContents["Main"]
buttonSample.Size = UDim2.new(0.6, 0, 0, 40)
buttonSample.Position = UDim2.new(0.2,0,0,16)
buttonSample.BackgroundColor3 = Color3.fromRGB(150,225,175)
buttonSample.Text = "Auto Steal"
buttonSample.Font = Enum.Font.GothamBold
buttonSample.TextSize = 20
buttonSample.TextColor3 = Color3.fromRGB(38,38,80)
local btnCornerS = Instance.new("UICorner")
btnCornerS.CornerRadius = UDim.new(0, 10)
btnCornerS.Parent = buttonSample
buttonSample.MouseButton1Click:Connect(function()
print("Auto Steal Activated!")
end)

local toggleESP = Instance.new("TextButton")
toggleESP.Parent = tabContents["Main"]
toggleESP.Size = UDim2.new(0.6, 0, 0, 40)
toggleESP.Position = UDim2.new(0.2,0,0,68)
toggleESP.BackgroundColor3 = Color3.fromRGB(235, 188, 153)
toggleESP.Text = "ESP: OFF"
toggleESP.Font = Enum.Font.GothamBold
toggleESP.TextSize = 20
toggleESP.TextColor3 = Color3.fromRGB(36,36,80)
toggleESP.Name = "ToggleESP"
local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 10)
espCorner.Parent = toggleESP
local ESPEnabled = false
toggleESP.MouseButton1Click:Connect(function()
ESPEnabled = not ESPEnabled
toggleESP.Text = "ESP: " .. (ESPEnabled and "ON" or "OFF")
end)

-- === ESP Tab ===
local btn_a = Instance.new("TextButton")
btn_a.Parent = tabContents["ESP"]
btn_a.Size = UDim2.new(0.7, 0, 0, 40)
btn_a.Position = UDim2.new(0.15,0,0,22)
btn_a.BackgroundColor3 = Color3.fromRGB(100,220,230)
btn_a.Text = "Aimbot"
btn_a.Font = Enum.Font.GothamBold
btn_a.TextSize = 20
btn_a.TextColor3 = Color3.fromRGB(40,55,100)
local aCorner = Instance.new("UICorner")
aCorner.CornerRadius = UDim.new(0, 12)
aCorner.Parent = btn_a
btn_a.MouseButton1Click:Connect(function()
print("Aimbot feature activated!")
end)

local btn_b = Instance.new("TextButton")
btn_b.Parent = tabContents["ESP"]
btn_b.Size = UDim2.new(0.7, 0, 0, 40)
btn_b.Position = UDim2.new(0.15,0,0,74)
btn_b.BackgroundColor3 = Color3.fromRGB(220,220,130)
btn_b.Text = "Anti-Ragdoll"
btn_b.Font = Enum.Font.GothamBold
btn_b.TextSize = 20
btn_b.TextColor3 = Color3.fromRGB(60,30,20)
local bCorner = Instance.new("UICorner")
bCorner.CornerRadius = UDim.new(0, 12)
bCorner.Parent = btn_b
btn_b.MouseButton1Click:Connect(function()
print("Anti-Ragdoll toggled!")
end)

-- === Misc Tab ===
local miscToggle = Instance.new("TextButton")
miscToggle.Parent = tabContents["Misc"]
miscToggle.Size = UDim2.new(0.55, 0, 0, 38)
miscToggle.Position = UDim2.new(0.225,0,0,18)
miscToggle.BackgroundColor3 = Color3.fromRGB(190,235,220)
miscToggle.Text = "Fly: OFF"
miscToggle.Font = Enum.Font.GothamBold
miscToggle.TextSize = 19
miscToggle.TextColor3 = Color3.fromRGB(40,55,60)
miscToggle.Name = "FlyToggle"
local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 10)
flyCorner.Parent = miscToggle
local FlyEnabled = false
miscToggle.MouseButton1Click:Connect(function()
FlyEnabled = not FlyEnabled
miscToggle.Text = "Fly: " .. (FlyEnabled and "ON" or "OFF")
end)

local btn_god = Instance.new("TextButton")
btn_god.Parent = tabContents["Misc"]
btn_god.Size = UDim2.new(0.55, 0, 0, 38)
btn_god.Position = UDim2.new(0.225,0,0,68)
btn_god.BackgroundColor3 = Color3.fromRGB(225,210,190)
btn_god.Text = "Godmode"
btn_god.Font = Enum.Font.GothamBold
btn_god.TextSize = 19
btn_god.TextColor3 = Color3.fromRGB(60,40,40)
local godCorner = Instance.new("UICorner")
godCorner.CornerRadius = UDim.new(0, 10)
godCorner.Parent = btn_god
btn_god.MouseButton1Click:Connect(function()
print("Godmode Activated")
end)

-- === Credits Tab ===
local creditsText = Instance.new("TextLabel")
creditsText.Parent = tabContents["Credits"]
creditsText.Size = UDim2.new(1,0,0,54)
creditsText.Position = UDim2.new(0,0,0,20)
creditsText.BackgroundTransparency = 1
creditsText.Text = "Hehe Hub\nBy Miggysalad"
creditsText.Font = Enum.Font.GothamBold
creditsText.TextSize = 21
creditsText.TextColor3 = Color3.fromRGB(40,40,60)

-- Tab switching logic
for tabName, btn in pairs(tabButtons) do
btn.MouseButton1Click:Connect(function()
for name,content in pairs(tabContents) do
content.Visible = (name == tabName)
end
end)
end

-- Bounce-in entrance
local function bounceIn(frame)
local dur = 0.45
local overshoot = 26
local centerY = 0.5

local goal1 = {Position = UDim2.new(0.5, -FRAME_W/2, centerY, overshoot)}  
local tween1 = TweenService:Create(frame, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal1)  
local goal2 = {Position = UDim2.new(0.5, -FRAME_W/2, centerY, -overshoot/2)}  
local tween2 = TweenService:Create(frame, TweenInfo.new(dur/2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), goal2)  
local goal3 = {Position = UDim2.new(0.5, -FRAME_W/2, centerY, 0)}  
local tween3 = TweenService:Create(frame, TweenInfo.new(dur/2.2, Enum.EasingStyle.Quad), goal3)  

tween1:Play()  
tween1.Completed:Wait()  
tween2:Play()  
tween2.Completed:Wait()  
tween3:Play()

end

spawn(function()
bounceIn(mainFrame)
end)

-- Toggle open/close with RightShift
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightShift then
mainFrame.Visible = not mainFrame.Visible
end
end)

-- Draggable window
local dragging, dragInput, dragStart, startPos
mainFrame.Active = true
mainFrame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = mainFrame.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
mainFrame.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement then
dragInput = input
end
end)
UserInputService.InputChanged:Connect(function(input)
if input == dragInput and dragging then
local delta = input.Position - dragStart
mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
end
end)

print("Hehe Hub loaded! Tabs and buttons are ready!")
