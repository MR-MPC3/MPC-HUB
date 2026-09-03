-------------------------------------------------
-- 1. SERVICES CƠ BẢN
-------------------------------------------------
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

-------------------------------------------------
-- 2. ANTI-TAMPER / ANTI-SKID (TẠM THỜI ĐANG TẮT)
-------------------------------------------------
--[[
spawn(function()
    while task.wait() do
        function print() end
        function warn() end
        function error() end
        debug.traceback = function() return "Traceback blocked" end
        debug.info = function() return "Info blocked" end

        local meta = getrawmetatable(game)
        if meta and not meta.__metatable then
            setreadonly(meta, false)
            local oldIndex = meta.__index
            local oldNewIndex = meta.__newindex
            meta.__index = function(metaObj, val4)
                if val4 == "debug" or val4 == "getrawmetatable" then error("Anti Skid: Tampering detected!") end
                return oldIndex(metaObj, val4)
            end
            meta.__newindex = function(metaObj2, val5, metaVal)
                if val5 == "debug" or val5 == "getrawmetatable" then error("Anti Skid: Tampering detected!") end
                return oldNewIndex(metaObj2, val5, metaVal)
            end
            setreadonly(meta, true)
        end

        local function checkEnvTamper()
            local envDangerList = {"_G", "debug", "getgenv", "getrawmetatable", "setfenv", "loadstring", "hookfunction"}
            for _, item in ipairs(envDangerList) do
                local pcallOk, pcallResult = pcall(function() return _G[item] end)
                if pcallOk and pcallResult then error("Anti Skid: Environment tampering detected!") end
            end
        end

        local function checkHookTamper()
            local hookDangerList = {getrawmetatable, setreadonly, getgenv, debug.getinfo, debug.getregistry}
            for _, item in ipairs(hookDangerList) do
                if item then error("Anti Skid: Hook tampering detected!") end
            end
        end

        local temp1 = game:FindService("HttpService")
        if temp1 then
            temp1.RequestAsync = function() error("HTTP Requests Blocked") end
            temp1.GetAsync = function() error("HTTP Get Blocked") end
            temp1.PostAsync = function() error("HTTP Post Blocked") end
        end

        function collectgarbage() error("GC Blocked") end
        os.time = function() error("OS Time Blocked") end

        pcall(checkEnvTamper)
        pcall(checkHookTamper)
    end
end)
]]

-------------------------------------------------
-- 3. LOAD FLUENT UI LIBRARY
-------------------------------------------------
local success, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MR-MPC3/Fluent/master/main.lua"))()
end)

assert(success and Fluent, "[Min Gaming] Không thể tải Fluent UI! Hãy kiểm tra lại kết nối mạng hoặc Executor.")

local Window = Fluent:CreateWindow({
    Title = "Min Gaming",
    SubTitle = "",
    TabWidth = 160,
    Theme = "Light",
    Acrylic = false,
    Size = UDim2.fromOffset(500, 320),
    MinimizeKey = Enum.KeyCode.End
})

-------------------------------------------------
-- 4. MOBILE MINIMIZE / RESTORE BUTTON
-------------------------------------------------
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

local Dragging, DragStart, StartPosition, DraggedFar = false, nil, nil, false

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
        MinButton.Position = UDim2.new(
            StartPosition.X.Scale, StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y
        )
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

-------------------------------------------------
-- 5. TẠO CÁC TAB CHÍNH
-------------------------------------------------
local TabDefinitions = {
    {"Home",     "Thông Tin",   "info"},
    {"Main",     "Cày",         "sword"},
    {"Sea",      "Sự Kiện",     "waves"},
    {"ITM",      "Vật Phẩm",    "package"},
    {"Setting",  "Cài Đặt",     "settings"},
    {"Status",   "Máy Chủ",     "server"},
    {"Stats",    "Chỉ Số",      "bar-chart-2"},
    {"Player",   "Người Chơi",  "user"},
    {"Teleport", "Dịch Chuyển", "map-pin"},
    {"Fruit",    "Trái",        "apple"},
    {"Raid",     "Tập Kích",    "swords"},
    {"Race",     "Tộc",         "shield"},
    {"Shop",     "Cửa Hàng",    "shopping-cart"},
    {"Misc",     "Khác",        "layers"}
}

local Tabs = {}
for _, tab in ipairs(TabDefinitions) do
    local ok, result = pcall(Window.AddTab, Window, {Title = tab[2], Icon = tab[3]})
    if not ok or not result then
        result = Window:AddTab({Title = tab[2]})
    end
    Tabs[tab[1]] = result
end

-------------------------------------------------
-- 6. PLAYER & SEA DETECTION
-------------------------------------------------
local PlaceId = game.PlaceId
local Options = Fluent.Options

-------------------------------------------------
-- 7. PERSISTENT CONFIG SYSTEM
-------------------------------------------------
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
    if IsResettingConfig or typeof(writefile) ~= "function" then return end
    pcall(function()
        EnsureConfigFolder()
        local data = {}
        for idx, opt in pairs(Options) do
            if opt and opt.Value ~= nil then data[idx] = DeepCopy(opt.Value) end
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
    if typeof(readfile) ~= "function" or typeof(isfile) ~= "function" or not isfile(CONFIG_FILE) then return end
    local ok, content = pcall(readfile, CONFIG_FILE)
    if not ok or type(content) ~= "string" or content == "" then return end
    local ok2, data = pcall(function() return HttpService:JSONEncode(content) end)
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
        if opt and opt.Value ~= nil then DefaultConfig[idx] = DeepCopy(opt.Value) end
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

-------------------------------------------------
-- 8. MAP / SEA
-------------------------------------------------
local MAP_SEAS = {
    [85211729168715] = 1,
    [79091703265657] = 2,
    [100117331123089] = 3
}

local currentSea = MAP_SEAS[PlaceId]
if not currentSea then
    plr:Kick("PlaceId không hợp lệ")
    return
end

local Sea1 = (currentSea == 1)
local Sea2 = (currentSea == 2)
local Sea3 = (currentSea == 3)

-------------------------------------------------
-- 9. DATA TABLES / HELPERS / BUILDUI
-------------------------------------------------
function BuildUI()
    -- Menu trống: chưa gắn chức năng phát triển sau 
end

-------------------------------------------------
-- 10. KHỞI CHẠY
-------------------------------------------------
BuildUI()
CaptureDefaults()
WrapOptionsForAutoSave()
LoadConfig()

Fluent:Notify({
    Title = "Min Gaming",
    Content = "Tải Xong - Sẵn sàng sử dụng!",
    Duration = 10
})

-- discord.gg/25ms
