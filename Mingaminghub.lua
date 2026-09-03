local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local LocalizationService = game:GetService("LocalizationService")
local VirtualUser = game:GetService("VirtualUser")

local ParentGui = (gethui and gethui()) or CoreGui
local plr = Players.LocalPlayer
local RS = ReplicatedStorage

pcall(function()
    local oldLoader = ParentGui:FindFirstChild("Core")
    if oldLoader then oldLoader:Destroy() end
end)

local LoaderTitle = "Đăng Ký Kênh Min Gaming"
local LoaderColors = {
    Main = Color3.fromRGB(0, 0, 0),
    Topic = Color3.fromRGB(200, 200, 200),
    Title = Color3.fromRGB(255, 255, 255),
    LoaderBackground = Color3.fromRGB(40, 40, 40),
    LoaderSplash = Color3.fromRGB(3, 252, 3)
}

local function TweenObject(object, duration, goals)
    if not object then return end
    local tween = TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goals)
    tween:Play()
    return tween
end

local function CreateObject(className, props)
    local instance = Instance.new(className)
    for property, value in pairs(props) do
        if property ~= "Parent" then instance[property] = value end
    end
    instance.Parent = props.Parent
    return instance
end

local function AddUICorner(radius, parentObj)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parentObj
end

local LoaderGui = CreateObject("ScreenGui", {
    Name = "Core", Parent = ParentGui, ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999999, ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

local MainFrame = CreateObject("Frame", {
    Name = "Main", Parent = LoaderGui, BackgroundColor3 = LoaderColors.Main, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(0, 0, 0, 0)
})
AddUICorner(12, MainFrame)

local UserImage = CreateObject("ImageLabel", {
    Name = "UserImage", Parent = MainFrame, BackgroundTransparency = 1, Image = "rbxassetid://13717478897", Position = UDim2.new(0, 15, 0, 10), Size = UDim2.new(0, 50, 0, 50)
})
AddUICorner(25, UserImage)

local UserNameLabel = CreateObject("TextLabel", {
    Name = "UserName", Parent = MainFrame, BackgroundTransparency = 1, Text = "Youtube: Min Gaming", Position = UDim2.new(0, 75, 0, 10), Size = UDim2.new(0, 200, 0, 50), Font = Enum.Font.GothamBold, TextColor3 = LoaderColors.Title, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left
})

local TopicLabel = CreateObject("TextLabel", {
    Name = "Top", Parent = MainFrame, TextTransparency = 1, BackgroundTransparency = 1, Position = UDim2.new(0, 30, 0, 70), Size = UDim2.new(0, 301, 0, 20), Font = Enum.Font.Gotham, Text = "Loader", TextColor3 = LoaderColors.Topic, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left
})

local TitleLabel = CreateObject("TextLabel", {
    Name = "Title", Parent = MainFrame, TextTransparency = 1, BackgroundTransparency = 1, Position = UDim2.new(0, 30, 0, 90), Size = UDim2.new(0, 301, 0, 46), Font = Enum.Font.Gotham, RichText = true, Text = "<b>" .. LoaderTitle .. "</b>", TextColor3 = LoaderColors.Title, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left
})

local ProgressBG = CreateObject("Frame", {
    Name = "BG", Parent = MainFrame, AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = LoaderColors.LoaderBackground, BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, 70), Size = UDim2.new(0.85, 0, 0, 24)
})
AddUICorner(8, ProgressBG)

local ProgressBar = CreateObject("Frame", {
    Name = "Progress", Parent = ProgressBG, BackgroundColor3 = LoaderColors.LoaderSplash, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(0, 0, 0, 24)
})
AddUICorner(8, ProgressBar)

local StepLabel = CreateObject("TextLabel", {
    Name = "StepLabel", Parent = MainFrame, BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 1, -25), Size = UDim2.new(1, -20, 0, 20), Font = Enum.Font.Gotham, Text = "", TextColor3 = LoaderColors.Topic, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Center, AnchorPoint = Vector2.new(0.5, 0.5)
})

local CurrentProgress = 0
local function UpdatePercentage(percent)
    percent = math.clamp(math.floor(percent), 0, 100)
    if percent < CurrentProgress then return end
    CurrentProgress = percent
    TweenObject(ProgressBar, 0.25, {Size = UDim2.new(percent / 100, 0, 0, 24)})
    task.wait()
end

TweenObject(MainFrame, 0.25, {Size = UDim2.new(0, 346, 0, 121)})
task.wait(0.25)

TweenObject(TopicLabel, 0.35, {TextTransparency = 0})
TweenObject(TitleLabel, 0.35, {TextTransparency = 0})
TweenObject(ProgressBG, 0.35, {BackgroundTransparency = 0})
TweenObject(ProgressBar, 0.35, {BackgroundTransparency = 0})

UpdatePercentage(5)
UpdatePercentage(10)

local success, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MR-MPC3/Fluent/master/main.lua"))()
end)

if not success or not Fluent then
    if LoaderGui then LoaderGui:Destroy() end
    error("[Min Gaming] Không thể tải Fluent UI! Hãy kiểm tra lại kết nối mạng hoặc Executor.")
end

UpdatePercentage(40)

local Window = Fluent:CreateWindow({
    Title = "Min Gaming",
    SubTitle = "",
    TabWidth = 160,
    Theme = "Light",
    Acrylic = false,
    Size = UDim2.fromOffset(500, 320),
    MinimizeKey = Enum.KeyCode.End
})

UpdatePercentage(50)

pcall(function()
    local oldMinGui = ParentGui:FindFirstChild("MinGamingToggle")
    if oldMinGui then oldMinGui:Destroy() end
end)

local MinGui = Instance.new("ScreenGui")
MinGui.Name = "MinGamingToggle"
MinGui.ResetOnSpawn = false
MinGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MinGui.Parent = ParentGui

local MinButton = Instance.new("ImageButton")
MinButton.Name = "MinButton"
MinButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinButton.BorderSizePixel = 0
MinButton.Position = UDim2.fromOffset(20, 100)
MinButton.Size = UDim2.fromOffset(50, 50)
MinButton.Image = "rbxassetid://13717478897"
MinButton.AutoButtonColor = false
MinButton.Parent = MinGui

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 12)
MinCorner.Parent = MinButton

local Dragging = false
local DragStart = nil
local StartPosition = nil
local DraggedFar = false

MinButton.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DraggedFar = false
        DragStart = Input.Position
        StartPosition = MinButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if not Dragging then return end
    if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
        local Delta = Input.Position - DragStart
        if Delta.Magnitude > 5 then DraggedFar = true end
        MinButton.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

MinButton.Activated:Connect(function()
    if DraggedFar then
        DraggedFar = false
        return
    end
    Window:Minimize()
end)

UpdatePercentage(55)

local TabDefinitions = {
    {"Home", "Thông Tin", "info"},
    {"Main", "Cày", "sword"},
    {"Sea", "Sự Kiện", "waves"},
    {"ITM", "Vật Phẩm", "package"},
    {"Setting", "Cài Đặt", "settings"},
    {"Status", "Máy Chủ", "server"},
    {"Stats", "Chỉ Số", "bar-chart-2"},
    {"Player", "Người Chơi", "user"},
    {"Teleport", "Dịch Chuyển", "map-pin"},
    {"Fruit", "Trái", "apple"},
    {"Raid", "Tập Kích", "swords"},
    {"Race", "Tộc", "shield"},
    {"Shop", "Cửa Hàng", "shopping-cart"},
    {"Misc", "Khác", "layers"}
}

local Tabs = {}
local TotalTabs = #TabDefinitions

for index, tab in ipairs(TabDefinitions) do
    local ok, result = pcall(Window.AddTab, Window, {Title = tab[2], Icon = tab[3]})
    if not ok or not result then
        result = Window:AddTab({Title = tab[2]})
    end
    Tabs[tab[1]] = result
    local progress = 55 + math.floor((index / TotalTabs) * 15)
    UpdatePercentage(progress)
end

local PlaceId = game.PlaceId
local Options = Fluent.Options
UpdatePercentage(72)

local CONFIG_FOLDER = "MinGamingHub"
local CONFIG_FILE = CONFIG_FOLDER .. "/DU_LIEU_TK_" .. tostring(plr.Name) .. ".json"
local IsResettingConfig = false
local DefaultConfig = {}
local savePending = false
local saveGeneration = 0

local function DeepCopy(value)
    if type(value) ~= "table" then return value end
    local result = {}
    for k, v in pairs(value) do result[k] = DeepCopy(v) end
    return result
end

local function EnsureConfigFolder()
    if typeof(isfolder) == "function" and typeof(makefolder) == "function" then
        if not isfolder(CONFIG_FOLDER) then pcall(makefolder, CONFIG_FOLDER) end
    end
end

local function WriteConfig(data)
    if typeof(writefile) ~= "function" then return end
    pcall(function()
        EnsureConfigFolder()
        writefile(CONFIG_FILE, HttpService:JSONEncode(data))
    end)
end

local function SaveConfig()
    if IsResettingConfig then return end
    if typeof(writefile) ~= "function" then return end
    pcall(function()
        EnsureConfigFolder()
        local data = {}
        for idx, opt in pairs(Options) do
            if opt and opt.Value ~= nil then
                data[idx] = DeepCopy(opt.Value)
            end
        end
        WriteConfig(data)
    end)
end

local function QueueSaveConfig()
    if IsResettingConfig or savePending then return end
    savePending = true
    saveGeneration = saveGeneration + 1
    local generation = saveGeneration
    task.delay(0.75, function()
        if generation ~= saveGeneration then return end
        savePending = false
        if not IsResettingConfig then SaveConfig() end
    end)
end

local function LoadConfig()
    if typeof(readfile) ~= "function" or typeof(isfile) ~= "function" then return end
    if not isfile(CONFIG_FILE) then return end
    local ok, content = pcall(readfile, CONFIG_FILE)
    if not ok or type(content) ~= "string" or content == "" then return end
    local ok2, data = pcall(function() return HttpService:JSONDecode(content) end)
    if not ok2 or type(data) ~= "table" then return end
    for idx, value in pairs(data) do
        local opt = Options[idx]
        if opt and type(opt.SetValue) == "function" then
            pcall(function() opt:SetValue(value) end)
        end
    end
end

local function CaptureDefaults()
    for idx, opt in pairs(Options) do
        if opt and opt.Value ~= nil then
            DefaultConfig[idx] = DeepCopy(opt.Value)
        end
    end
end

local function ValuesEqual(a, b)
    if type(a) ~= type(b) then return false end
    if type(a) ~= "table" then return a == b end
    for k, v in pairs(a) do
        if not ValuesEqual(v, b[k]) then return false end
    end
    for k in pairs(b) do
        if a[k] == nil then return false end
    end
    return true
end

local function ResetAllToDefault()
    if IsResettingConfig then return end
    IsResettingConfig = true
    saveGeneration = saveGeneration + 1
    savePending = false
    task.spawn(function()
        local changed = 0
        for idx, defaultValue in pairs(DefaultConfig) do
            local opt = Options[idx]
            if opt and opt.Value ~= nil and type(opt.SetValue) == "function" and not ValuesEqual(opt.Value, defaultValue) then
                pcall(function() opt:SetValue(DeepCopy(defaultValue)) end)
                changed = changed + 1
                if changed % 6 == 0 then task.wait() end
            end
        end
        WriteConfig(DeepCopy(DefaultConfig))
        IsResettingConfig = false
        Fluent:Notify({Title = "Min Gaming", Content = "Đã khôi phục thiết lập mặc định!", Duration = 3})
    end)
end

local function WrapOptionsForAutoSave()
    for idx, opt in pairs(Options) do
        if opt and type(opt.SetValue) == "function" and not opt.__MinGamingWrapped then
            local originalSetValue = opt.SetValue
            opt.SetValue = function(self, value, ...)
                originalSetValue(self, value, ...)
                if not IsResettingConfig then QueueSaveConfig() end
            end
            opt.__MinGamingWrapped = true
        end
    end
end

UpdatePercentage(78)

local MAP_SEAS = {
    [85211729168715] = 1,
    [79091703265657] = 2,
    [100117331123089] = 3
}

local currentSea = MAP_SEAS[PlaceId]
if not currentSea then
    if LoaderGui then LoaderGui:Destroy() end
    plr:Kick("PlaceId không hợp lệ")
    return
end

local Sea1 = currentSea == 1
local Sea2 = currentSea == 2
local Sea3 = currentSea == 3

UpdatePercentage(82)

function BuildUI()
end

BuildUI()
UpdatePercentage(88)

CaptureDefaults()
UpdatePercentage(92)

WrapOptionsForAutoSave()
UpdatePercentage(95)

LoadConfig()
UpdatePercentage(98)

UpdatePercentage(100)
task.wait(0.35)

Fluent:Notify({
    Title = "Min Gaming",
    Content = "Tải Xong - Sẵn sàng sử dụng!",
    Duration = 10
})

TweenObject(TopicLabel, 0.4, {TextTransparency = 1})
TweenObject(TitleLabel, 0.4, {TextTransparency = 1})
TweenObject(ProgressBG, 0.4, {BackgroundTransparency = 1})
TweenObject(ProgressBar, 0.4, {BackgroundTransparency = 1})

task.wait(0.45)

TweenObject(MainFrame, 0.25, {Size = UDim2.new(0, 0, 0, 0)})
task.wait(0.25)

if LoaderGui and LoaderGui.Parent then
    LoaderGui:Destroy()
end
