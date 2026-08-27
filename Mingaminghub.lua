--------------------------------------
-- LOADER UI
--------------------------------------
local cloneref=cloneref or function(o)return o end
local TweenService=cloneref(game:GetService("TweenService"))
local UserInputService=cloneref(game:GetService("UserInputService"))
local CoreGui=cloneref(game:GetService("CoreGui"))
local ParentGui=(gethui and gethui()) or CoreGui

local LoaderConfig={
    Title=shared.LoaderTitle or "Đăng Ký Kênh Min Gaming",
    Keyframes=shared.LoaderKeyFrames or {
        [1]={1,10},
        [2]={2,30},
        [3]={3,60},
        [4]={2,100}
    },
    StepTexts={
        [1]="Đang kiểm tra dữ liệu...",
        [2]="Đang nạp thư viện UI...",
        [3]="Đang kết nối Server...",
        [4]="Thành công!"
    },
    Colors={
        Main=Color3.fromRGB(0,0,0),
        Topic=Color3.fromRGB(200,200,200),
        Title=Color3.fromRGB(255,255,255),
        ProgressBG=Color3.fromRGB(40,40,40),
        ProgressBar=Color3.fromRGB(3,252,3)
    }
}

-- CLEANUP CŨ

local OldLoader=ParentGui:FindFirstChild("MPC_HUB_LOADER")
if OldLoader then OldLoader:Destroy() end

-- HELPERS

local ActiveTweens={}

local function Tween(object,duration,goals,easingStyle,easingDirection)
    if not object or not object.Parent then return end
    local oldTween=ActiveTweens[object]
    if oldTween then
        pcall(function()oldTween:Cancel()end)
        ActiveTweens[object]=nil
    end
    local tween=TweenService:Create(object,TweenInfo.new(
        duration,
        easingStyle or Enum.EasingStyle.Quad,
        easingDirection or Enum.EasingDirection.Out
    ),goals)
    ActiveTweens[object]=tween
    tween.Completed:Connect(function()
        if ActiveTweens[object]==tween then
            ActiveTweens[object]=nil
        end
    end)
    tween:Play()
    return tween
end

local function Create(className,props,cornerRadius)
    local object=Instance.new(className)
    for property,value in pairs(props) do
        if property~="Parent" then
            object[property]=value
        end
    end
    if cornerRadius then
        local corner=Instance.new("UICorner")
        corner.CornerRadius=UDim.new(0,cornerRadius)
        corner.Parent=object
    end
    object.Parent=props.Parent
    return object
end

-- UI

local LoaderGui=Create("ScreenGui",{
    Name="MPC_HUB_LOADER",
    Parent=ParentGui,
    ResetOnSpawn=false,
    IgnoreGuiInset=true,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling
})

local MainFrame=Create("CanvasGroup",{
    Name="Main",
    Parent=LoaderGui,
    BackgroundColor3=LoaderConfig.Colors.Main,
    BorderSizePixel=0,
    ClipsDescendants=true,
    AnchorPoint=Vector2.new(.5,.5),
    Position=UDim2.fromScale(.5,.5),
    Size=UDim2.fromOffset(0,0),
    GroupTransparency=1
},12)

Create("ImageLabel",{
    Name="UserImage",
    Parent=MainFrame,
    BackgroundTransparency=1,
    Image="rbxassetid://13717478897",
    Position=UDim2.fromOffset(15,10),
    Size=UDim2.fromOffset(50,50)
},25)

Create("TextLabel",{
    Name="UserName",
    Parent=MainFrame,
    BackgroundTransparency=1,
    Text="Youtube: Min Gaming",
    Position=UDim2.fromOffset(75,10),
    Size=UDim2.fromOffset(200,50),
    Font=Enum.Font.GothamBold,
    TextColor3=LoaderConfig.Colors.Title,
    TextSize=14,
    TextXAlignment=Enum.TextXAlignment.Left
})

Create("TextLabel",{
    Name="Top",
    Parent=MainFrame,
    BackgroundTransparency=1,
    Position=UDim2.fromOffset(30,70),
    Size=UDim2.fromOffset(301,20),
    Font=Enum.Font.Gotham,
    Text="Loader",
    TextColor3=LoaderConfig.Colors.Topic,
    TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left
})

Create("TextLabel",{
    Name="Title",
    Parent=MainFrame,
    BackgroundTransparency=1,
    Position=UDim2.fromOffset(30,90),
    Size=UDim2.fromOffset(301,46),
    Font=Enum.Font.Gotham,
    RichText=true,
    Text="<b>"..LoaderConfig.Title.."</b>",
    TextColor3=LoaderConfig.Colors.Title,
    TextSize=14,
    TextXAlignment=Enum.TextXAlignment.Left
})

local ProgressBG=Create("Frame",{
    Name="BG",
    Parent=MainFrame,
    AnchorPoint=Vector2.new(.5,0),
    BackgroundColor3=LoaderConfig.Colors.ProgressBG,
    BorderSizePixel=0,
    Position=UDim2.new(.5,0,0,70),
    Size=UDim2.new(.85,0,0,24)
},8)

local ProgressBar=Create("Frame",{
    Name="Progress",
    Parent=ProgressBG,
    BackgroundColor3=LoaderConfig.Colors.ProgressBar,
    BorderSizePixel=0,
    Size=UDim2.new(0,0,0,24)
},8)

local StepLabel=Create("TextLabel",{
    Name="StepLabel",
    Parent=MainFrame,
    BackgroundTransparency=1,
    Position=UDim2.new(.5,0,1,-25),
    Size=UDim2.new(1,-20,0,20),
    AnchorPoint=Vector2.new(.5,.5),
    Font=Enum.Font.Gotham,
    Text="",
    TextColor3=LoaderConfig.Colors.Topic,
    TextSize=14,
    TextXAlignment=Enum.TextXAlignment.Center
})

-- LOADING

local function UpdatePercentage(percent,step)
    percent=math.clamp(tonumber(percent) or 0,0,100)
    Tween(ProgressBar,.45,{
        Size=UDim2.new(percent/100,0,0,24)
    },Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
    StepLabel.Text=LoaderConfig.StepTexts[step] or ""
end

local OpenTween=Tween(MainFrame,.35,{
    Size=UDim2.fromOffset(346,121),
    GroupTransparency=0
},Enum.EasingStyle.Back,Enum.EasingDirection.Out)

if OpenTween then OpenTween.Completed:Wait() end
task.wait(.15)

for step,keyframe in ipairs(LoaderConfig.Keyframes) do
    task.wait(keyframe[1])
    UpdatePercentage(keyframe[2],step)
end

task.wait(.4)

-- CLOSE

local CloseTween=Tween(MainFrame,.3,{
    Size=UDim2.fromOffset(0,0),
    GroupTransparency=1
},Enum.EasingStyle.Quart,Enum.EasingDirection.In)

if CloseTween then CloseTween.Completed:Wait() end

-- CLEANUP

for object,tween in pairs(ActiveTweens) do
    pcall(function()tween:Cancel()end)
    ActiveTweens[object]=nil
end

if LoaderGui then LoaderGui:Destroy() end

-- spawn(function()
--     while wait() do
--         function print()
--         end
--         function warn()
--         end
--         function error()
--         end
--         debug.traceback = function()
--             return "Traceback blocked";
--         end;
--         debug.info = function()
--             return "Info blocked";
--         end;
--         local meta = getrawmetatable(game);
--         if (meta and not meta.__metatable) then
--             setreadonly(meta, false);
--             local oldIndex = meta.__index;
--             local oldNewIndex = meta.__newindex;
--             meta.__index = function(metaObj, val4)
--                 if ((val4 == "debug") or (val4 == "getrawmetatable")) then
--                     error("Anti Skid: Tampering detected!");
--                 end
--                 return oldIndex(metaObj, val4);
--             end;
--             meta.__newindex = function(metaObj2, val5, metaVal)
--                 if ((val5 == "debug") or (val5 == "getrawmetatable")) then
--                     error("Anti Skid: Tampering detected!");
--                 end
--                 return oldNewIndex(metaObj2, val5, metaVal);
--             end;
--             setreadonly(meta, true);
--         end
--         local function checkEnvTamper()
--             local envDangerList = {
--                 "_G",
--                 "debug",
--                 "getgenv",
--                 "getrawmetatable",
--                 "setfenv",
--                 "loadstring",
--                 "hookfunction"
--             };
--             for _, item in ipairs(envDangerList) do
--                 local pcallOk, pcallResult = pcall(function()
--                     return _G[envItem];
--                 end);
--                 if (pcallOk and pcallResult) then
--                     error("Anti Skid: Environment tampering detected!");
--                 end
--             end
--         end
--         local function checkHookTamper()
--             local hookDangerList = {
--                 getrawmetatable,
--                 setreadonly,
--                 getgenv,
--                 debug.getinfo,
--                 debug.getregistry
--             };
--             for _, item in ipairs(hookDangerList) do
--                 if hookItem then
--                     error("Anti Skid: Hook tampering detected!");
--                 end
--             end
--         end
--         local temp1 = game:FindService("HttpService");
--         if temp1 then
--             temp1.RequestAsync = function()
--                 error("HTTP Requests Blocked");
--             end;
--             temp1.GetAsync = function()
--                 error("HTTP Get Blocked");
--             end;
--             temp1.PostAsync = function()
--                 error("HTTP Post Blocked");
--             end;
--         end
--         function collectgarbage()
--             error("GC Blocked");
--         end
--         os.time = function()
--             error("OS Time Blocked");
--         end;
--         pcall(checkEnvTamper);
--         pcall(checkHookTamper);
--     end
-- end);

---------------------------------
-- TẢI FLUENT UI
---------------------------------
local success,Fluent=pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MR-MPC3/Fluent/master/main.lua"))()
end)
assert(success and Fluent,"[Min Gaming] Không thể tải Fluent UI! Hãy kiểm tra lại kết nối mạng hoặc Executor.")

local Window=Fluent:CreateWindow({
    Title="Min Gaming",
    SubTitle="",
    TabWidth=160,
    Theme="Light",
    Acrylic=false,
    Size=UDim2.fromOffset(500,320),
    MinimizeKey=Enum.KeyCode.End
})

---------------------------------
-- MINIMIZE / TOGGLE BUTTON
---------------------------------
local OldMinGui=ParentGui:FindFirstChild("MinGamingToggle")
if OldMinGui then OldMinGui:Destroy() end

local MinGui=Instance.new("ScreenGui")
MinGui.Name="MinGamingToggle"
MinGui.ResetOnSpawn=false
MinGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
MinGui.Parent=ParentGui

local MinButton=Instance.new("ImageButton")
MinButton.Name="MinButton"
MinButton.BackgroundColor3=Color3.fromRGB(0,0,0)
MinButton.BorderSizePixel=0
MinButton.Position=UDim2.fromOffset(20,100)
MinButton.Size=UDim2.fromOffset(50,50)
MinButton.Image="rbxassetid://13717478897"
MinButton.AutoButtonColor=false
MinButton.Parent=MinGui

local MinCorner=Instance.new("UICorner")
MinCorner.CornerRadius=UDim.new(0,12)
MinCorner.Parent=MinButton

---------------------------------
-- DRAG
---------------------------------
local Dragging=false
local DragStart
local StartPosition
local DraggedFar=false

MinButton.InputBegan:Connect(function(Input)
    local InputType=Input.UserInputType
    if InputType==Enum.UserInputType.MouseButton1 or InputType==Enum.UserInputType.Touch then
        Dragging=true
        DraggedFar=false
        DragStart=Input.Position
        StartPosition=MinButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if not Dragging then return end
    local InputType=Input.UserInputType
    if InputType~=Enum.UserInputType.MouseMovement and InputType~=Enum.UserInputType.Touch then return end
    local Delta=Input.Position-DragStart
    if Delta.Magnitude>5 then DraggedFar=true end
    MinButton.Position=UDim2.new(
        StartPosition.X.Scale,StartPosition.X.Offset+Delta.X,
        StartPosition.Y.Scale,StartPosition.Y.Offset+Delta.Y
    )
end)

UserInputService.InputEnded:Connect(function(Input)
    local InputType=Input.UserInputType
    if InputType==Enum.UserInputType.MouseButton1 or InputType==Enum.UserInputType.Touch then
        Dragging=false
    end
end)

---------------------------------
-- CLICK TOGGLE
---------------------------------
MinButton.Activated:Connect(function()
    if not DraggedFar then Window:Minimize() end
end)

---------------------------------
-- CÁC TAB CHÍNH
---------------------------------
assert(Window, "Không tìm thấy Window! Hãy kiểm tra phần khởi tạo Fluent UI.")

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

for _, info in ipairs(TabDefinitions) do
    Tabs[info[1]] = Window:AddTab({
        Title = info[2],
        Icon = info[3]
    })
end

----------------------------------------------------------------
-- LOGIC VÀ HOẠT ĐỘNG 
----------------------------------------------------------------
--Khai báo Service & Player
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer
local PlaceId = game.PlaceId

-- Khai báo Fluent Safe (Tránh crash nếu Fluent chưa nạp)
local Options = (Fluent and Fluent.Options) or {}

--Danh sách PlaceId hợp lệ mới nhất mã 14 số
local MAP_SEAS = {
    
    [85211729168715] = 1,
    [79091703265657] = 2,
    [100117331123089] = 3
}

--Xác định Sea
local currentSea = MAP_SEAS[PlaceId]

if not currentSea then
    plr:Kick("[Min Gaming] PlaceId không hợp lệ! Vui lòng vào đúng Blox Fruits (Sea 1, 2, 3).")
    return
end

--Đồng bộ biến cho cả Local Script lẫn các Script khác (Giữ tính năng cũ 100%)
local Sea1 = (currentSea == 1)
local Sea2 = (currentSea == 2)
local Sea3 = (currentSea == 3)

-- Đồng bộ lên getgenv() để các file script phụ/chức năng khác gọi được mà không bị lỗi undefined
getgenv().Sea1 = Sea1
getgenv().Sea2 = Sea2
getgenv().Sea3 = Sea3
getgenv().Options = Options
