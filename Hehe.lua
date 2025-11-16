-- Hehe Hub - Steal a Brainrot Hub Style GUI (all tabs and buttons included)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HeheHubUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.IgnoreGuiInset = true

local FRAME_W, FRAME_H = 600, 370
local SIDEBAR_W = 115

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, FRAME_W, 0, FRAME_H)
mainFrame.Position = UDim2.new(0.5, -FRAME_W/2, 0.5, -FRAME_H/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(32,34,38)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui
mainFrame.Active = true
mainFrame.Draggable = true

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Parent = mainFrame
titleBar.Size = UDim2.new(1,0,0,34)
titleBar.Position = UDim2.new(0,0,0,0)
titleBar.BackgroundColor3 = Color3.fromRGB(24,26,30)
titleBar.BorderSizePixel = 0
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0,12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Parent = titleBar
titleLabel.Size = UDim2.new(1,0,1,0)
titleLabel.Position = UDim2.new(0,0,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Hehe Hub"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 22
titleLabel.TextColor3 = Color3.fromRGB(194,194,236)

-- Sidebar Tabs
local tabNames = {"Main", "Stealer", "Helper", "Player", "Finder", "Server", "Discord"}
local sidebarButtons = {}
local sidebarFrame = Instance.new("Frame")
sidebarFrame.Parent = mainFrame
sidebarFrame.Size = UDim2.new(0, SIDEBAR_W, 1, -34)
sidebarFrame.Position = UDim2.new(0,0,0,34)
sidebarFrame.BackgroundColor3 = Color3.fromRGB(27,29,33)
sidebarFrame.BorderSizePixel = 0
local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0,12)
sidebarCorner.Parent = sidebarFrame

local tabContents = {}
for i,name in ipairs(tabNames) do
local btn = Instance.new("TextButton")
btn.Parent = sidebarFrame
btn.Size = UDim2.new(1,-24,0,34)
btn.Position = UDim2.new(0,12,0,(i-1)*42+12)
btn.BackgroundColor3 = i==1 and Color3.fromRGB(40,43,54) or Color3.fromRGB(27,29,33)
btn.Text = name
btn.TextColor3 = i==1 and Color3.fromRGB(188,200,255) or Color3.fromRGB(115,120,150)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 19
btn.Name = "Sidebar_"..name
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 9)
btnCorner.Parent = btn
sidebarButtons[name] = btn

local content = Instance.new("Frame")  
content.Parent = mainFrame  
content.Size = UDim2.new(0, FRAME_W-SIDEBAR_W-24, 1,-60)  
content.Position = UDim2.new(0, SIDEBAR_W+12, 0, 48)  
content.BackgroundTransparency = 1  
content.Visible = (i==1) -- Only first tab visible by default  
tabContents[name] = content

end

-- Sidebar tab switching logic
for thisName,thisBtn in pairs(sidebarButtons) do
thisBtn.MouseButton1Click:Connect(function()
for tab,content in pairs(tabContents) do
content.Visible = (tab == thisName)
sidebarButtons[tab].BackgroundColor3 = tab==thisName and Color3.fromRGB(40,43,54) or Color3.fromRGB(27,29,33)
sidebarButtons[tab].TextColor3 = tab==thisName and Color3.fromRGB(188,200,255) or Color3.fromRGB(115,120,150)
end
end)
end


---

-- Main Tab (Farm Section from Image 1)

local mainTab = tabContents["Main"]
local farmLabel = Instance.new("TextLabel")
farmLabel.Parent = mainTab
farmLabel.Size = UDim2.new(1,0,0,26)
farmLabel.Position = UDim2.new(0,0,0,0)
farmLabel.BackgroundTransparency = 1
farmLabel.Text = "Farm"
farmLabel.Font = Enum.Font.GothamBold
farmLabel.TextSize = 21
farmLabel.TextColor3 = Color3.fromRGB(188,200,255)
farmLabel.TextXAlignment = Enum.TextXAlignment.Left

local mainYOffset = 38
function addToggle(parent, yOffset, txt, state)
local btn = Instance.new("TextButton")
btn.Parent = parent
btn.Size = UDim2.new(0.44,0,0,26)
btn.Position = UDim2.new(0,0,0,yOffset)
btn.Text = txt
btn.BackgroundColor3 = Color3.fromRGB(44,48,58)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 17
btn.TextColor3 = Color3.fromRGB(160,170,255)
local btnUICorner = Instance.new("UICorner")
btnUICorner.CornerRadius = UDim.new(0,7)
btnUICorner.Parent = btn

local toggleCircle = Instance.new("Frame")  
toggleCircle.Parent = btn  
toggleCircle.Size = UDim2.new(0,28,0,16)  
toggleCircle.Position = UDim2.new(1,-32,0.5,-8)  
toggleCircle.BackgroundColor3 = Color3.fromRGB(64,70,110)  
local togUIC = Instance.new("UICorner")  
togUIC.CornerRadius = UDim.new(0,8)  
togUIC.Parent = toggleCircle  

local isOn = state  
local innerDot = Instance.new("Frame")  
innerDot.Parent = toggleCircle  
innerDot.Size = UDim2.new(0.55,0,0.9,0)  
innerDot.Position = UDim2.new(isOn and 0.45 or 0.05,0,0.05,0)  
innerDot.BackgroundColor3 = isOn and Color3.fromRGB(70,206,130) or Color3.fromRGB(39,46,60)  
innerDot.BorderSizePixel = 0  
local dotCorner = Instance.new("UICorner")  
dotCorner.CornerRadius = UDim.new(0,7)  
dotCorner.Parent = innerDot  

btn.MouseButton1Click:Connect(function()  
    isOn = not isOn  
    innerDot.Position = UDim2.new(isOn and 0.45 or 0.05,0,0.05,0)  
    innerDot.BackgroundColor3 = isOn and Color3.fromRGB(70,206,130) or Color3.fromRGB(39,46,60)  
end)  
return btn

end

addToggle(mainTab,mainYOffset,"Auto buy Brainrot",false)
addToggle(mainTab,mainYOffset+38,"Auto Purchase from Dealer",false)
addToggle(mainTab,mainYOffset+76,"Anti AFK",true)
addToggle(mainTab,mainYOffset+114,"Auto Lock Base",false)
addToggle(mainTab,mainYOffset+152,"Auto Collect",false)

-- Example input for Min money per sec to buy (simple TextBox)
local minMoneyBox = Instance.new("TextBox")
minMoneyBox.Parent = mainTab
minMoneyBox.Size = UDim2.new(0.44,0,0,24)
minMoneyBox.Position = UDim2.new(0,0,0,mainYOffset+190)
minMoneyBox.BackgroundColor3 = Color3.fromRGB(44,48,58)
minMoneyBox.Font = Enum.Font.Gotham
minMoneyBox.TextSize = 15
minMoneyBox.TextColor3 = Color3.fromRGB(160,170,255)
minMoneyBox.PlaceholderText = "Min money per sec to buy..."
local minMoneyCorner = Instance.new("UICorner")
minMoneyCorner.CornerRadius = UDim.new(0,7)
minMoneyCorner.Parent = minMoneyBox

-- Example Dropdown (dealer item)
local dealerMenu = Instance.new("Frame")
dealerMenu.Parent = mainTab
dealerMenu.Size = UDim2.new(0.44,0,0,24)
dealerMenu.Position = UDim2.new(0,0,0,mainYOffset+220)
dealerMenu.BackgroundColor3 = Color3.fromRGB(44,48,58)
dealerMenu.BorderSizePixel = 0
local dealerCorner = Instance.new("UICorner")
dealerCorner.CornerRadius = UDim.new(0,7)
dealerCorner.Parent = dealerMenu
local dropLabel = Instance.new("TextLabel")
dropLabel.Parent = dealerMenu
dropLabel.Size = UDim2.new(1,0,1,0)
dropLabel.Position = UDim2.new(0,0,0,0)
dropLabel.BackgroundTransparency = 1
dropLabel.Text = "Select Brainrot Dealer item(s)..."
dropLabel.Font = Enum.Font.Gotham
dropLabel.TextSize = 15
dropLabel.TextColor3 = Color3.fromRGB(160,170,255)
dropLabel.TextXAlignment = Enum.TextXAlignment.Left


---

-- Helper Tab (Image 3 ESP Group)

local helperTab = tabContents["Helper"]

addToggle(helperTab,0,"Remove Bee Launcher effect",false)

local espBox = Instance.new("Frame")
espBox.Parent = helperTab
espBox.Size = UDim2.new(0.52,0,0,170)
espBox.Position = UDim2.new(0,0,0,40)
espBox.BackgroundColor3 = Color3.fromRGB(44,48,58)
espBox.BorderSizePixel = 0
local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0,7)
boxCorner.Parent = espBox

local espTitle = Instance.new("TextLabel")
espTitle.Parent = espBox
espTitle.Size = UDim2.new(1,0,0,24)
espTitle.Position = UDim2.new(0,0,0,0)
espTitle.BackgroundTransparency = 1
espTitle.Text = "ESP"
espTitle.Font = Enum.Font.GothamBold
espTitle.TextSize = 16
espTitle.TextColor3 = Color3.fromRGB(160,170,255)
espTitle.TextXAlignment = Enum.TextXAlignment.Left

local helperYOffset = 32
local espOptions = {
{txt="X Ray",          state=true,  offset=helperYOffset},
{txt="Your Base ESP",  state=false, offset=helperYOffset+28},
{txt="Highest Value Brainrot ESP", state=true, offset=helperYOffset+56},
{txt="Timer ESP",      state=true,  offset=helperYOffset+84},
{txt="Player ESP",     state=true,  offset=helperYOffset+112}
}
for _,opt in ipairs(espOptions) do
addToggle(espBox, opt.offset, opt.txt, opt.state)
end


---

-- Player Tab (Image 2)

local playerTab = tabContents["Player"]
addToggle(playerTab,0,"Speed boost UI (3 rebirth req., Q keybind)",true)
addToggle(playerTab,42,"Infinity Jump",true)
addToggle(playerTab,84,"Chilli Booster UI",false)


---

-- Remaining Tabs

for _,tab in ipairs({"Stealer","Finder","Server","Discord"}) do
local label = Instance.new("TextLabel")
label.Parent = tabContents[tab]
label.Size = UDim2.new(1,0,0,26)
label.Position = UDim2.new(0,0,0,0)
label.BackgroundTransparency = 1
label.Text = tab.." coming soon!"
label.Font = Enum.Font.GothamBold
label.TextSize = 19
label.TextColor3 = Color3.fromRGB(160,170,255)
label.TextXAlignment = Enum.TextXAlignment.Left
end

-- Bounce-in entrance animation
local function bounceIn(frame)
local dur = 0.46
local overshoot = 42
local centerY = 0.5
local goal1 = {Position = UDim2.new(0.5, -FRAME_W/2, centerY, -overshoot)}
local tween1 = TweenService:Create(frame, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal1)
local goal2 = {Position = UDim2.new(0.5, -FRAME_W/2, centerY, overshoot/3)}
local tween2 = TweenService:Create(frame, TweenInfo.new(dur/2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), goal2)
local goal3 = {Position = UDim2.new(0.5, -FRAME_W/2, centerY, 0)}
local tween3 = TweenService:Create(frame, TweenInfo.new(dur/2.1, Enum.EasingStyle.Quad), goal3)

tween1:Play()  
tween1.Completed:Wait()  
tween2:Play()  
tween2.Completed:Wait()  
tween3:Play()

end
spawn(function() bounceIn(mainFrame) end)

-- RightShift to toggle UI
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightShift then
mainFrame.Visible = not mainFrame.Visible
end
end)

print("Hehe Hub loaded! All tabs, toggles, ESP (visual switches) match Steal a Brainrot screenshots.")
