----------------------------------------------------------------
-- code phần khung giao diện (UI Framework), và chống sao chép code 
----------------------------------------------------------------
-- discord.gg/25ms


shared.LoaderTitle = "Đăng Ký Kênh Min Gaming";
shared.LoaderKeyFrames = {
    [1] = {
        1,
        10
    },
    [2] = {
        2,
        30
    },
    [3] = {
        3,
        60
    },
    [4] = {
        2,
        100
    }
};
local LoaderConfig = {
    LoaderData = {
        Name = shared.LoaderTitle or "A Loader",
        Colors = shared.LoaderColors or {
            Main = Color3.fromRGB(0, 0, 0),
            Topic = Color3.fromRGB(200, 200, 200),
            Title = Color3.fromRGB(255, 255, 255),
            LoaderBackground = Color3.fromRGB(40, 40, 40),
            LoaderSplash = Color3.fromRGB(3, 252, 3)
        }
    },
    Keyframes = shared.LoaderKeyFrames or {
        [1] = {
            1,
            10
        },
        [2] = {
            2,
            30
        },
        [3] = {
            3,
            60
        },
        [4] = {
            2,
            100
        }
    }
};
local LoaderStepTexts = {
    [1] = "Đang kiểm tra dữ liệu...",
    [2] = "Đang nạp thư viện UI...",
    [3] = "Đang kết nối Server...",
    [4] = "Thành công!"
};
function TweenObject(object, duration, goals)
    game.TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), goals):Play();
end
function CreateObject(className, props)
    local instance = Instance.new(className);
    local parent;
    for propName, propValue in pairs(props) do
        if (propName ~= "Parent") then
            instance[propName] = propValue;
        else
            parent = propValue;
        end
    end
    instance.Parent = parent;
    return instance;
end
local function AddUICorner(radius, parentObj)
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, radius);
    corner.Parent = parentObj;
end
local LoaderGui = CreateObject("ScreenGui", {
    Name = "Core",
    Parent = game.CoreGui
});
local MainFrame = CreateObject("Frame", {
    Name = "Main",
    Parent = LoaderGui,
    BackgroundColor3 = LoaderConfig.LoaderData.Colors.Main,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, 0, 0, 0)
});
AddUICorner(12, MainFrame);
local UserImage = CreateObject("ImageLabel", {
    Name = "UserImage",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Image = "rbxassetid://13717478897",
    Position = UDim2.new(0, 15, 0, 10),
    Size = UDim2.new(0, 50, 0, 50)
});
AddUICorner(25, UserImage);
local UserNameLabel = CreateObject("TextLabel", {
    Name = "UserName",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Text = "Youtube: Min Gaming",
    Position = UDim2.new(0, 75, 0, 10),
    Size = UDim2.new(0, 200, 0, 50),
    Font = Enum.Font.GothamBold,
    TextColor3 = LoaderConfig.LoaderData.Colors.Title,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
});
local TopicLabel = CreateObject("TextLabel", {
    Name = "Top",
    TextTransparency = 1,
    Parent = MainFrame,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 30, 0, 70),
    Size = UDim2.new(0, 301, 0, 20),
    Font = Enum.Font.Gotham,
    Text = "Loader",
    TextColor3 = LoaderConfig.LoaderData.Colors.Topic,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left
});
local TitleLabel = CreateObject("TextLabel", {
    Name = "Title",
    Parent = MainFrame,
    TextTransparency = 1,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 30, 0, 90),
    Size = UDim2.new(0, 301, 0, 46),
    Font = Enum.Font.Gotham,
    RichText = true,
    Text = "<b>" .. LoaderConfig.LoaderData.Name .. "</b>",
    TextColor3 = LoaderConfig.LoaderData.Colors.Title,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
});
local ProgressBG = CreateObject("Frame", {
    Name = "BG",
    Parent = MainFrame,
    AnchorPoint = Vector2.new(0.5, 0),
    BackgroundTransparency = 1,
    BackgroundColor3 = LoaderConfig.LoaderData.Colors.LoaderBackground,
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 0, 70),
    Size = UDim2.new(0.8500000238418579, 0, 0, 24)
});
AddUICorner(8, ProgressBG);
local ProgressBar = CreateObject("Frame", {
    Name = "Progress",
    Parent = ProgressBG,
    BackgroundColor3 = LoaderConfig.LoaderData.Colors.LoaderSplash,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(0, 0, 0, 24)
});
AddUICorner(8, ProgressBar);
local StepLabel = CreateObject("TextLabel", {
    Name = "StepLabel",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 1, - 25),
    Size = UDim2.new(1, - 20, 0, 20),
    Font = Enum.Font.Gotham,
    Text = "",
    TextColor3 = LoaderConfig.LoaderData.Colors.Topic,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0.5)
});
function UpdateStepText(stepIndex)
    StepLabel.Text = LoaderStepTexts[stepIndex] or "" ;
end
function UpdatePercentage(percent, stepIndex)
    TweenObject(ProgressBar, 0.5, {
        Size = UDim2.new(percent / 100, 0, 0, 24)
    });
    UpdateStepText(stepIndex);
end
TweenObject(MainFrame, 0.25, {
    Size = UDim2.new(0, 346, 0, 121)
});
wait();
TweenObject(TopicLabel, 0.5, {
    TextTransparency = 0
});
TweenObject(TitleLabel, 0.5, {
    TextTransparency = 0
});
TweenObject(ProgressBG, 0.5, {
    BackgroundTransparency = 0
});
TweenObject(ProgressBar, 0.5, {
    BackgroundTransparency = 0
});
for step, keyframe in pairs(LoaderConfig.Keyframes) do
    wait(keyframe[1]);
    UpdatePercentage(keyframe[2], step);
end
UpdatePercentage(100, 4);
TweenObject(TopicLabel, 0.5, {
    TextTransparency = 1
});
TweenObject(TitleLabel, 0.5, {
    TextTransparency = 1
});
TweenObject(ProgressBG, 0.5, {
    BackgroundTransparency = 1
});
TweenObject(ProgressBar, 0.5, {
    BackgroundTransparency = 1
});
wait(0.5);
TweenObject(MainFrame, 0.25, {
    Size = UDim2.new(0, 0, 0, 0)
});
wait(0.25);
LoaderGui:Destroy();
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
--         local v420 = getrawmetatable(game);
--         if (v420 and not v420.__metatable) then
--             setreadonly(v420, false);
--             local v658 = v420.__index;
--             local v659 = v420.__newindex;
--             v420.__index = function(v759, v760)
--                 if ((v760 == "debug") or (v760 == "getrawmetatable")) then
--                     error("Anti Skid: Tampering detected!");
--                 end
--                 return v658(v759, v760);
--             end;
--             v420.__newindex = function(v761, v762, v763)
--                 if ((v762 == "debug") or (v762 == "getrawmetatable")) then
--                     error("Anti Skid: Tampering detected!");
--                 end
--                 return v659(v761, v762, v763);
--             end;
--             setreadonly(v420, true);
--         end
--         local function v421()
--             local v568 = {
--                 "_G",
--                 "debug",
--                 "getgenv",
--                 "getrawmetatable",
--                 "setfenv",
--                 "loadstring",
--                 "hookfunction"
--             };
--             for v662, v663 in ipairs(v568) do
--                 local v664, v665 = pcall(function()
--                     return _G[v663];
--                 end);
--                 if (v664 and v665) then
--                     error("Anti Skid: Environment tampering detected!");
--                 end
--             end
--         end
--         local function v422()
--             local v569 = {
--                 getrawmetatable,
--                 setreadonly,
--                 getgenv,
--                 debug.getinfo,
--                 debug.getregistry
--             };
--             for v666, v667 in ipairs(v569) do
--                 if v667 then
--                     error("Anti Skid: Hook tampering detected!");
--                 end
--             end
--         end
--         local v423 = game:FindService("HttpService");
--         if v423 then
--             v423.RequestAsync = function()
--                 error("HTTP Requests Blocked");
--             end;
--             v423.GetAsync = function()
--                 error("HTTP Get Blocked");
--             end;
--             v423.PostAsync = function()
--                 error("HTTP Post Blocked");
--             end;
--         end
--         function collectgarbage()
--             error("GC Blocked");
--         end
--         os.time = function()
--             error("OS Time Blocked");
--         end;
--         pcall(v421);
--         pcall(v422);
--     end
-- end);
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/MR-MPC3/Fluent/master/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Min Gaming",
    SubTitle = "",
    TabWidth = 160,
    Theme = "Light",
    Acrylic = false,
    Size = UDim2.fromOffset(500, 320),
    MinimizeKey = Enum.KeyCode.End
})

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local MinGui = Instance.new("ScreenGui")
MinGui.Name = "MinGamingToggle"
MinGui.ResetOnSpawn = false
MinGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MinGui.Parent = CoreGui

local MinButton = Instance.new("ImageButton")
MinButton.Name = "MinButton"
MinButton.Parent = MinGui
MinButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinButton.BorderSizePixel = 0
MinButton.Position = UDim2.fromOffset(20, 100)
MinButton.Size = UDim2.fromOffset(50, 50)
MinButton.Image = "http://www.roblox.com/asset/?id=13717478897"
MinButton.AutoButtonColor = false

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 12)
MinCorner.Parent = MinButton

-- Kéo nút bằng chuột hoặc cảm ứng
local Dragging = false
local DragStart
local StartPosition
local DragInput

MinButton.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = MinButton.Position
        DragInput = Input

        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

MinButton.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch then
        DragInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and Input == DragInput then
        local Delta = Input.Position - DragStart

        MinButton.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

MinButton.Activated:Connect(function()
    Window:Minimize()
end)

local Tabs = {
    Home = Window:AddTab({
        Title = "Thông Tin"
    }),
    Main = Window:AddTab({
        Title = "Cày"
    }),
    Sea = Window:AddTab({
        Title = "Sự Kiện"
    }),
    ITM = Window:AddTab({
        Title = "Vật Phẩm"
    }),
    Setting = Window:AddTab({
        Title = "Cài Đặt"
    }),
    Status = Window:AddTab({
        Title = "Máy Chủ"
    }),
    Stats = Window:AddTab({
        Title = "Chỉ Số"
    }),
    Player = Window:AddTab({
        Title = "Người Chơi"
    }),
    Teleport = Window:AddTab({
        Title = "Dịch Chuyển"
    }),
    Fruit = Window:AddTab({
        Title = "Trái"
    }),
    Raid = Window:AddTab({
        Title = "Tập Kích"
    }),
    Race = Window:AddTab({
        Title = "Tộc"
    }),
    Shop = Window:AddTab({
        Title = "Cửa Hàng"
    }),
    Misc = Window:AddTab({
        Title = "Khác"
    })
};
----------------------------------------------------------------
-- code khởi đầu cho toàn bộ logic và hoạt động của Blox Fruits.
----------------------------------------------------------------
local Options = Fluent.Options;
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local plr = Players.LocalPlayer
local PlaceId = game.PlaceId

-- Xác định Sea
local Sea1, Sea2, Sea3 = false, false, false
if PlaceId == 85211729168715 then
    Sea1 = true
elseif PlaceId == 79091703265657 then
    Sea2 = true
elseif PlaceId == 100117331123089 then
    Sea3 = true
else
    plr:Kick("❌ Error : A[12]Blox Fruits ❌ (ID lạ: " .. tostring(PlaceId) .. ")")
end

----------------------------------------------------------------
-- BẢNG DỮ LIỆU QUEST (dễ sửa / thêm bãi)
----------------------------------------------------------------
local QuestData = {
    Sea1 = {
        {Min = 1,   Max = 9,   Mon = "Bandit",            Quest = "BanditQuest1",   QLv = 1, QCF = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875), MonCF = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)},
        {Min = 10,  Max = 14,  Mon = "Monkey",            Quest = "JungleQuest",    QLv = 1, QCF = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102), MonCF = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)},
        {Min = 15,  Max = 29,  Mon = "Gorilla",           Quest = "JungleQuest",    QLv = 2, QCF = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102), MonCF = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)},
        {Min = 30,  Max = 39,  Mon = "Pirate",            Quest = "BuggyQuest1",    QLv = 1, QCF = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188), MonCF = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)},
        {Min = 40,  Max = 59,  Mon = "Brute",             Quest = "BuggyQuest1",    QLv = 2, QCF = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188), MonCF = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)},
        {Min = 60,  Max = 74,  Mon = "Desert Bandit",     Quest = "DesertQuest",    QLv = 1, QCF = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625), MonCF = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)},
        {Min = 75,  Max = 89,  Mon = "Desert Officer",    Quest = "DesertQuest",    QLv = 2, QCF = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625), MonCF = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)},
        {Min = 90,  Max = 99,  Mon = "Snow Bandit",       Quest = "SnowQuest",      QLv = 1, QCF = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156), MonCF = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)},
        {Min = 100, Max = 119, Mon = "Snowman",           Quest = "SnowQuest",      QLv = 2, QCF = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156), MonCF = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)},
        {Min = 120, Max = 149, Mon = "Chief Petty Officer", Quest = "MarineQuest2", QLv = 1, QCF = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313), MonCF = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)},
        {Min = 150, Max = 174, Mon = "Sky Bandit",        Quest = "SkyQuest",       QLv = 1, QCF = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438), MonCF = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)},
        {Min = 175, Max = 189, Mon = "Dark Master",       Quest = "SkyQuest",       QLv = 2, QCF = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438), MonCF = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)},
        {Min = 190, Max = 209, Mon = "Prisoner",          Quest = "PrisonerQuest",  QLv = 1, QCF = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118), MonCF = CFrame.new(4937.31885, 0.332031399, 649.574524, 0.694649816, 0, -0.719348073, 0, 1, 0, 0.719348073, 0, 0.694649816)},
        {Min = 210, Max = 249, Mon = "Dangerous Prisoner", Quest = "PrisonerQuest", QLv = 2, QCF = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118), MonCF = CFrame.new(5099.6626, 0.351562679, 1055.7583, 0.898906827, 0, -0.438139856, 0, 1, 0, 0.438139856, 0, 0.898906827)},
        {Min = 250, Max = 274, Mon = "Toga Warrior",      Quest = "ColosseumQuest", QLv = 1, QCF = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188), MonCF = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)},
        {Min = 275, Max = 299, Mon = "Gladiator",         Quest = "ColosseumQuest", QLv = 2, QCF = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188), MonCF = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)},
        {Min = 300, Max = 324, Mon = "Military Soldier",  Quest = "MagmaQuest",     QLv = 1, QCF = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625), MonCF = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)},
        {Min = 325, Max = 374, Mon = "Military Spy",      Quest = "MagmaQuest",     QLv = 2, QCF = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625), MonCF = CFrame.new(-5787.00293, 75.8262634, 8651.69922, 0.838590562, 0, -0.544762194, 0, 1, 0, 0.544762194, 0, 0.838590562)},
        {Min = 375, Max = 399, Mon = "Fishman Warrior",   Quest = "FishmanQuest",   QLv = 1, QCF = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734), MonCF = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703), Entrance = Vector3.new(61163.8515625, 11.6796875, 1819.7841796875)},
        {Min = 400, Max = 449, Mon = "Fishman Commando",  Quest = "FishmanQuest",   QLv = 2, QCF = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734), MonCF = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141), Entrance = Vector3.new(61163.8515625, 11.6796875, 1819.7841796875)},
        {Min = 450, Max = 474, Mon = "God's Guard",       Quest = "SkyExp1Quest",   QLv = 1, QCF = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234), MonCF = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922), Entrance = Vector3.new(-4607.82275, 872.54248, -1667.55688)},
        {Min = 475, Max = 524, Mon = "Shanda",            Quest = "SkyExp1Quest",   QLv = 2, QCF = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703), MonCF = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773), Entrance = Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047)},
        {Min = 525, Max = 549, Mon = "Royal Squad",       Quest = "SkyExp2Quest",   QLv = 1, QCF = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125), MonCF = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)},
        {Min = 550, Max = 624, Mon = "Royal Soldier",     Quest = "SkyExp2Quest",   QLv = 2, QCF = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125), MonCF = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)},
        {Min = 625, Max = 649, Mon = "Galley Pirate",     Quest = "FountainQuest",  QLv = 1, QCF = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875), MonCF = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)},
        {Min = 650, Max = 9999, Mon = "Galley Captain",   Quest = "FountainQuest",  QLv = 2, QCF = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875), MonCF = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)},
    },

    Sea2 = {
        {Min = 700,  Max = 724,  Mon = "Raider",            Quest = "Area1Quest",       QLv = 1, QCF = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531), MonCF = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)},
        {Min = 725,  Max = 774,  Mon = "Mercenary",         Quest = "Area1Quest",       QLv = 2, QCF = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531), MonCF = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)},
        {Min = 775,  Max = 799,  Mon = "Swan Pirate",       Quest = "Area2Quest",       QLv = 1, QCF = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125), MonCF = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)},
        {Min = 800,  Max = 874,  Mon = "Factory Staff",     Quest = "Area2Quest",       QLv = 2, QCF = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125), MonCF = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)},
        {Min = 875,  Max = 899,  Mon = "Marine Lieutenant", Quest = "MarineQuest3",     QLv = 1, QCF = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531), MonCF = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)},
        {Min = 900,  Max = 949,  Mon = "Marine Captain",    Quest = "MarineQuest3",     QLv = 2, QCF = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531), MonCF = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)},
        {Min = 950,  Max = 974,  Mon = "Zombie",            Quest = "ZombieQuest",      QLv = 1, QCF = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281), MonCF = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)},
        {Min = 975,  Max = 999,  Mon = "Vampire",           Quest = "ZombieQuest",      QLv = 2, QCF = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281), MonCF = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)},
        {Min = 1000, Max = 1049, Mon = "Snow Trooper",      Quest = "SnowMountainQuest", QLv = 1, QCF = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875), MonCF = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)},
        {Min = 1050, Max = 1099, Mon = "Winter Warrior",    Quest = "SnowMountainQuest", QLv = 2, QCF = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875), MonCF = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)},
        {Min = 1100, Max = 1124, Mon = "Lab Subordinate",   Quest = "IceSideQuest",     QLv = 1, QCF = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188), MonCF = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)},
        {Min = 1125, Max = 1174, Mon = "Horned Warrior",    Quest = "IceSideQuest",     QLv = 2, QCF = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188), MonCF = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)},
        {Min = 1175, Max = 1199, Mon = "Magma Ninja",       Quest = "FireSideQuest",    QLv = 1, QCF = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813), MonCF = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)},
        {Min = 1200, Max = 1249, Mon = "Lava Pirate",       Quest = "FireSideQuest",    QLv = 2, QCF = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813), MonCF = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)},
        {Min = 1250, Max = 1274, Mon = "Ship Deckhand",     Quest = "ShipQuest1",       QLv = 1, QCF = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625), MonCF = CFrame.new(921.12365722656, 125.9839553833, 33088.328125), Entrance = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)},
        {Min = 1275, Max = 1299, Mon = "Ship Engineer",     Quest = "ShipQuest1",       QLv = 2, QCF = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625), MonCF = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125), Entrance = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)},
        {Min = 1300, Max = 1324, Mon = "Ship Steward",      Quest = "ShipQuest2",       QLv = 1, QCF = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875), MonCF = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875), Entrance = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)},
        {Min = 1325, Max = 1349, Mon = "Ship Officer",      Quest = "ShipQuest2",       QLv = 2, QCF = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875), MonCF = CFrame.new(955.38458251953, 181.08335876465, 33331.890625), Entrance = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)},
        {Min = 1350, Max = 1374, Mon = "Arctic Warrior",    Quest = "FrostQuest",       QLv = 1, QCF = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375), MonCF = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375), Entrance = Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)},
        {Min = 1375, Max = 1424, Mon = "Snow Lurker",       Quest = "FrostQuest",       QLv = 2, QCF = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375), MonCF = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)},
        {Min = 1425, Max = 1449, Mon = "Sea Soldier",       Quest = "ForgottenQuest",   QLv = 1, QCF = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063), MonCF = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)},
        {Min = 1450, Max = 9999, Mon = "Water Fighter",     Quest = "ForgottenQuest",   QLv = 2, QCF = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063), MonCF = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)},
    },

    Sea3 = {
        {Min = 1500, Max = 1524, Mon = "Pirate Millionaire",   Quest = "PiratePortQuest",    QLv = 1, QCF = CFrame.new(-450.1046447753906, 107.68145751953125, 5950.72607421875), MonCF = CFrame.new(-193.99227905273438, 56.12502670288086, 5755.7880859375)},
        {Min = 1525, Max = 1574, Mon = "Pistol Billionaire",   Quest = "PiratePortQuest",    QLv = 2, QCF = CFrame.new(-450.1046447753906, 107.68145751953125, 5950.72607421875), MonCF = CFrame.new(-188.14462280273438, 84.49613189697266, 6337.0419921875)},
        {Min = 1575, Max = 1599, Mon = "Dragon Crew Warrior",  Quest = "DragonCrewQuest",    QLv = 1, QCF = CFrame.new(6735.11083984375, 126.99046325683594, -711.0979614257812), MonCF = CFrame.new(6615.2333984375, 50.847679138183594, -978.93408203125)},
        {Min = 1600, Max = 1624, Mon = "Dragon Crew Archer",   Quest = "DragonCrewQuest",    QLv = 2, QCF = CFrame.new(6735.11083984375, 126.99046325683594, -711.0979614257812), MonCF = CFrame.new(6818.58935546875, 483.718994140625, 512.726806640625)},
        {Min = 1625, Max = 1649, Mon = "Hydra Enforcer",       Quest = "VenomCrewQuest",     QLv = 1, QCF = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422), MonCF = CFrame.new(4547.115234375, 1001.60205078125, 334.1954650878906)},
        {Min = 1650, Max = 1699, Mon = "Venomous Assailant",   Quest = "VenomCrewQuest",     QLv = 2, QCF = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422), MonCF = CFrame.new(4637.88525390625, 1077.85595703125, 882.4183959960938)},
        {Min = 1700, Max = 1724, Mon = "Marine Commodore",     Quest = "MarineTreeIsland",   QLv = 1, QCF = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813), MonCF = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)},
        {Min = 1725, Max = 1774, Mon = "Marine Rear Admiral",  Quest = "MarineTreeIsland",   QLv = 2, QCF = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813), MonCF = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)},
        {Min = 1775, Max = 1799, Mon = "Fishman Raider",       Quest = "DeepForestIsland3",  QLv = 1, QCF = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625), MonCF = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)},
        {Min = 1800, Max = 1824, Mon = "Fishman Captain",      Quest = "DeepForestIsland3",  QLv = 2, QCF = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875), MonCF = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)},
        {Min = 1825, Max = 1849, Mon = "Forest Pirate",        Quest = "DeepForestIsland",   QLv = 1, QCF = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938), MonCF = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)},
        {Min = 1850, Max = 1899, Mon = "Mythological Pirate",  Quest = "DeepForestIsland",   QLv = 2, QCF = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938), MonCF = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)},
        {Min = 1900, Max = 1924, Mon = "Jungle Pirate",        Quest = "DeepForestIsland2",  QLv = 1, QCF = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375), MonCF = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)},
        {Min = 1925, Max = 1974, Mon = "Musketeer Pirate",     Quest = "DeepForestIsland2",  QLv = 2, QCF = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375), MonCF = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)},
        {Min = 1975, Max = 1999, Mon = "Reborn Skeleton",      Quest = "HauntedQuest1",      QLv = 1, QCF = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.5295423e-8, -0.999978542, 2.0492047e-8, 1, 4.5162068e-8, 0.999978542, -2.0195568e-8, -0.00655503059), MonCF = CFrame.new(-8761.77148, 183.431747, 6168.33301, 0.978073597, -0.000013950732, -0.208259016, -0.0000010807393, 1, -0.00007206303, 0.208259016, 0.00007070804, 0.978073597)},
        {Min = 2000, Max = 2024, Mon = "Living Zombie",        Quest = "HauntedQuest1",      QLv = 2, QCF = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.5295423e-8, -0.999978542, 2.0492047e-8, 1, 4.5162068e-8, 0.999978542, -2.0195568e-8, -0.00655503059), MonCF = CFrame.new(-10103.7529, 238.565979, 6179.75977, 0.999474227, 2.7754714e-8, 0.0324240364, -2.5800633e-8, 1, -6.068485e-8, -0.0324240364, 5.981639e-8, 0.999474227)},
        {Min = 2025, Max = 2049, Mon = "Demonic Soul",         Quest = "HauntedQuest2",      QLv = 1, QCF = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313), MonCF = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)},
        {Min = 2050, Max = 2074, Mon = "Posessed Mummy",       Quest = "HauntedQuest2",      QLv = 2, QCF = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313), MonCF = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)},
        {Min = 2075, Max = 2099, Mon = "Peanut Scout",         Quest = "NutsIslandQuest",    QLv = 1, QCF = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664), MonCF = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)},
        {Min = 2100, Max = 2124, Mon = "Peanut President",     Quest = "NutsIslandQuest",    QLv = 2, QCF = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664), MonCF = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)},
        {Min = 2125, Max = 2149, Mon = "Ice Cream Chef",       Quest = "IceCreamIslandQuest", QLv = 1, QCF = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664), MonCF = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, 0, -0.997525156, 0, 1, 0, 0.997525275, 0, -0.0703101456)},
        {Min = 2150, Max = 2199, Mon = "Ice Cream Commander",  Quest = "IceCreamIslandQuest", QLv = 2, QCF = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664), MonCF = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, 0, -0.997525156, 0, 1, 0, 0.997525275, 0, -0.0703101456)},
        {Min = 2200, Max = 2224, Mon = "Cookie Crafter",       Quest = "CakeQuest1",         QLv = 1, QCF = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909), MonCF = CFrame.new(-2321.71216, 36.699482, -12216.7871, -0.780074954, 0, 0.625686109, 0, 1, 0, -0.625686109, 0, -0.780074954)},
        {Min = 2225, Max = 2249, Mon = "Cake Guard",           Quest = "CakeQuest1",         QLv = 2, QCF = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909), MonCF = CFrame.new(-1418.11011, 36.6718941, -12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0, -0.997700036, 0, 0.0677844882)},
        {Min = 2250, Max = 2274, Mon = "Baking Staff",         Quest = "CakeQuest2",         QLv = 1, QCF = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, 0, -0.308980465, 0, 1, 0, 0.308980465, 0, 0.951068401), MonCF = CFrame.new(-1980.43848, 36.6716766, -12983.8418, -0.254443765, 0, -0.967087567, 0, 1, 0, 0.967087567, 0, -0.254443765)},
        {Min = 2275, Max = 2299, Mon = "Head Baker",           Quest = "CakeQuest2",         QLv = 2, QCF = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, 0, -0.308980465, 0, 1, 0, 0.308980465, 0, 0.951068401), MonCF = CFrame.new(-2251.5791, 52.2714615, -13033.3965, -0.991971016, 0, -0.126466095, 0, 1, 0, 0.126466095, 0, -0.991971016)},
        {Min = 2300, Max = 2324, Mon = "Cocoa Warrior",        Quest = "ChocQuest1",         QLv = 1, QCF = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1), MonCF = CFrame.new(167.978516, 26.2254658, -12238.874, -0.939700961, 0, 0.341998369, 0, 1, 0, -0.341998369, 0, -0.939700961)},
        {Min = 2325, Max = 2349, Mon = "Chocolate Bar Battler", Quest = "ChocQuest1",        QLv = 2, QCF = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1), MonCF = CFrame.new(701.312073, 25.5824986, -12708.2148, -0.342042685, 0, -0.939684391, 0, 1, 0, 0.939684391, 0, -0.342042685)},
        {Min = 2350, Max = 2374, Mon = "Sweet Thief",          Quest = "ChocQuest2",         QLv = 1, QCF = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, 0.422592998), MonCF = CFrame.new(-140.258301, 25.5824986, -12652.3115, 0.173624337, 0, -0.984811902, 0, 1, 0, 0.984811902, 0, 0.173624337)},
        {Min = 2375, Max = 2399, Mon = "Candy Rebel",          Quest = "ChocQuest2",         QLv = 2, QCF = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, 0.422592998), MonCF = CFrame.new(47.9231453, 25.5824986, -13029.2402, -0.819156051, 0, -0.573571265, 0, 1, 0, 0.573571265, 0, -0.819156051)},
        {Min = 2400, Max = 2424, Mon = "Candy Pirate",         Quest = "CandyQuest1",        QLv = 1, QCF = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574, 0, -0.156446099), MonCF = CFrame.new(-1437.56348, 17.1481285, -14385.6934, 0.173624337, 0, -0.984811902, 0, 1, 0, 0.984811902, 0, 0.173624337)},
        {Min = 2425, Max = 2449, Mon = "Snow Demon",           Quest = "CandyQuest1",        QLv = 2, QCF = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574, 0, -0.156446099), MonCF = CFrame.new(-916.222656, 17.1481285, -14638.8125, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)},
        {Min = 2450, Max = 2474, Mon = "Isle Outlaw",          Quest = "TikiQuest1",         QLv = 1, QCF = CFrame.new(-16549.890625, 55.68635559082031, -179.91360473632812), MonCF = CFrame.new(-16162.8193359375, 11.6863374710083, -96.45481872558594)},
        {Min = 2475, Max = 2499, Mon = "Island Boy",           Quest = "TikiQuest1",         QLv = 2, QCF = CFrame.new(-16549.890625, 55.68635559082031, -179.91360473632812), MonCF = CFrame.new(-16357.3125, 20.632822036743164, 1005.64892578125)},
        {Min = 2500, Max = 2524, Mon = "Sun-kissed Warrior",   Quest = "TikiQuest2",         QLv = 1, QCF = CFrame.new(-16541.021484375, 54.77081298828125, 1051.461181640625), MonCF = CFrame.new(-16357.3125, 20.632822036743164, 1005.64892578125)},
        {Min = 2525, Max = 2549, Mon = "Isle Champion",        Quest = "TikiQuest2",         QLv = 2, QCF = CFrame.new(-16541.021484375, 54.77081298828125, 1051.461181640625), MonCF = CFrame.new(-16848.94140625, 21.68633460998535, 1041.4490966796875)},
        {Min = 2550, Max = 2574, Mon = "Serpent Hunter",       Quest = "TikiQuest3",         QLv = 1, QCF = CFrame.new(-16665.19140625, 104.59640502929688, 1579.6943359375), MonCF = CFrame.new(-16621.4140625, 121.40631103515625, 1290.6881103515625)},
        {Min = 2575, Max = 9999, Mon = "Skull Slayer",         Quest = "TikiQuest3",         QLv = 2, QCF = CFrame.new(-16665.19140625, 104.59640502929688, 1579.6943359375), MonCF = CFrame.new(-16811.5703125, 84.625244140625, 1542.235107421875)},
    }
}

----------------------------------------------------------------
-- Hàm CheckLevel (Đầy đủ an toàn & Viết gọn)
----------------------------------------------------------------
function CheckLevel()
    local myLevel = plr.Data.Level.Value
    local currentSea = Sea1 and "Sea1" or Sea2 and "Sea2" or Sea3 and "Sea3"
    if not currentSea or not QuestData[currentSea] then return end

    for _, data in ipairs(QuestData[currentSea]) do
        if (myLevel >= data.Min and myLevel <= data.Max) or (SelectMonster == data.Mon) then
            Ms        = data.Mon
            NameMon   = data.Mon
            NameQuest = data.Quest
            QuestLv   = data.QLv
            CFrameQ   = data.QCF
            CFrameMon = data.MonCF

            -- Bypass Cổng an toàn
            if _G.AutoLevel and data.Entrance then
                local rootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local dist = (CFrameMon.Position - rootPart.Position).Magnitude
                    local threshold = (currentSea == "Sea2" and data.Entrance.Y > 100) and 20000 or 3000

                    if dist > threshold then
                        pcall(function()
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", data.Entrance)
                        end)
                    end
                end
            end
            break
        end
    end
end

----------------------------------------------------------------
-- tableMon & AreaList (giữ nguyên logic cũ)
----------------------------------------------------------------
if Sea1 then
    tableMon = {"Bandit","Monkey","Gorilla","Pirate","Brute","Desert Bandit","Desert Officer","Snow Bandit","Snowman","Chief Petty Officer","Sky Bandit","Dark Master","Prisoner","Dangerous Prisoner","Toga Warrior","Gladiator","Military Soldier","Military Spy","Fishman Warrior","Fishman Commando","God's Guard","Shanda","Royal Squad","Royal Soldier","Galley Pirate","Galley Captain"}
    AreaList = {"Jungle","Buggy","Desert","Snow","Marine","Sky","Prison","Colosseum","Magma","Fishman","Sky Island","Fountain"}
elseif Sea2 then
    tableMon = {"Raider","Mercenary","Swan Pirate","Factory Staff","Marine Lieutenant","Marine Captain","Zombie","Vampire","Snow Trooper","Winter Warrior","Lab Subordinate","Horned Warrior","Magma Ninja","Lava Pirate","Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior","Snow Lurker","Sea Soldier","Water Fighter"}
    AreaList = {"Area 1","Area 2","Zombie","Marine","Snow Mountain","Ice fire","Ship","Frost","Forgotten"}
elseif Sea3 then
    tableMon = {"Pirate Millionaire","Pistol Billionaire","Dragon Crew Warrior","Dragon Crew Archer","Hydra Enforcer","Venomous Assailant","Marine Commodore","Marine Rear Admiral","Fishman Raider","Fishman Captain","Forest Pirate","Mythological Pirate","Jungle Pirate","Musketeer Pirate","Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy","Peanut Scout","Peanut President","Ice Cream Chef","Ice Cream Commander","Cookie Crafter","Cake Guard","Baking Staff","Head Baker","Cocoa Warrior","Chocolate Bar Battler","Sweet Thief","Candy Rebel","Candy Pirate","Snow Demon","Isle Outlaw","Island Boy","Sun-kissed Warrior","Isle Champion","Serpent Hunter","Skull Slayer"}
    AreaList = {"Pirate Port","Amazon","Marine Tree","Deep Forest","Haunted Castle","Nut Island","Ice Cream Island","Cake Island","Choco Island","Candy Island","Tiki Outpost"}
end
----------------------------------------------------------------
-- boss
----------------------------------------------------------------
local BossData = {
    -- ========== Sea 1 ==========
    ["The Gorilla King"] = {
        NameQuestBoss = "JungleQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$2,000\n7,000 Exp.",
        CFrameQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102),
        CFrameBoss = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
    },
    ["Bobby"] = {
        NameQuestBoss = "BuggyQuest1",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$8,000\n35,000 Exp.",
        CFrameQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188),
        CFrameBoss = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
    },
    ["The Saw"] = {
        CFrameBoss = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
    },
    ["Yeti"] = {
        NameQuestBoss = "SnowQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$10,000\n180,000 Exp.",
        CFrameQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156),
        CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
    },
    ["Mob Leader"] = {
        CFrameBoss = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
    },
    ["Vice Admiral"] = {
        NameQuestBoss = "MarineQuest2",
        QuestLvBoss = 2,
        RewardBoss = "Reward:\n$10,000\n180,000 Exp.",
        CFrameQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625),
        CFrameBoss = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
    },
    ["Saber Expert"] = {
        CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
    },
    ["Warden"] = {
        NameQuestBoss = "ImpelQuest",
        QuestLvBoss = 1,
        RewardBoss = "Reward:\n$6,000\n850,000 Exp.",
        CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635),
        CFrameBoss = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -0.000004499464, 0.975376427, -0.000019541258, 1, 0.000009031621, -0.975376427, -0.000021051976, 0.220546961)
    },
    ["Chief Warden"] = {
        NameQuestBoss = "ImpelQuest",
        QuestLvBoss = 2,
        RewardBoss = "Reward:\n$10,000\n1,000,000 Exp.",
        CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635),
        CFrameBoss = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -0.000028042234, -0.939682961, 0.00181045406, 0.342041939)
    },
    ["Swan"] = {
        NameQuestBoss = "ImpelQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$15,000\n1,600,000 Exp.",
        CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635),
        CFrameBoss = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
    },
    ["Magma Admiral"] = {
        NameQuestBoss = "MagmaQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$15,000\n2,800,000 Exp.",
        CFrameQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875),
        CFrameBoss = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
    },
    ["Fishman Lord"] = {
        NameQuestBoss = "FishmanQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$15,000\n4,000,000 Exp.",
        CFrameQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734),
        CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
    },
    ["Wysper"] = {
        NameQuestBoss = "SkyExp1Quest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$15,000\n4,800,000 Exp.",
        CFrameQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094),
        CFrameBoss = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
    },
    ["Thunder God"] = {
        NameQuestBoss = "SkyExp2Quest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$20,000\n5,800,000 Exp.",
        CFrameQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125),
        CFrameBoss = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
    },
    ["Cyborg"] = {
        NameQuestBoss = "FountainQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$20,000\n7,500,000 Exp.",
        CFrameQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875),
        CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
    },
    ["Ice Admiral"] = {
        CFrameBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
    },
    ["Greybeard"] = {
        CFrameBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
    },

    -- ========== Sea 2 ==========
    ["Diamond"] = {
        NameQuestBoss = "Area1Quest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$25,000\n9,000,000 Exp.",
        CFrameQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375),
        CFrameBoss = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
    },
    ["Jeremy"] = {
        NameQuestBoss = "Area2Quest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$25,000\n11,500,000 Exp.",
        CFrameQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063),
        CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
    },
    ["Fajita"] = {
        NameQuestBoss = "MarineQuest3",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$25,000\n15,000,000 Exp.",
        CFrameQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031),
        CFrameBoss = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
    },
    ["Don Swan"] = {
        CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
    },
    ["Smoke Admiral"] = {
        NameQuestBoss = "IceSideQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$20,000\n25,000,000 Exp.",
        CFrameQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813),
        CFrameBoss = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
    },
    ["Awakened Ice Admiral"] = {
        NameQuestBoss = "FrostQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$20,000\n36,000,000 Exp.",
        CFrameQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813),
        CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
    },
    ["Tide Keeper"] = {
        NameQuestBoss = "ForgottenQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$12,500\n38,000,000 Exp.",
        CFrameQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625),
        CFrameBoss = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
    },
    ["Darkbeard"] = {
        CFrameBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531) -- đã sửa từ CFrameMon
    },
    ["Cursed Captain"] = {
        CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
    },
    ["Order"] = {
        CFrameBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
    },

    -- ========== Sea 3 ==========
    ["Stone"] = {
        NameQuestBoss = "PiratePortQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$25,000\n40,000,000 Exp.",
        CFrameQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625),
        CFrameBoss = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
    },
    ["Hydra Leader"] = {
        NameQuestBoss = "VenomCrewQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$30,000\n52,000,000 Exp.",
        CFrameQBoss = CFrame.new(5445.9541015625, 601.62945556641, 751.43792724609),
        CFrameBoss = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875)
    },
    ["Kilo Admiral"] = {
        NameQuestBoss = "MarineTreeIsland",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$35,000\n56,000,000 Exp.",
        CFrameQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938),
        CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
    },
    ["Captain Elephant"] = {
        NameQuestBoss = "DeepForestIsland",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$40,000\n67,000,000 Exp.",
        CFrameQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875),
        CFrameBoss = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
    },
    ["Beautiful Pirate"] = {
        NameQuestBoss = "DeepForestIsland2",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$50,000\n70,000,000 Exp.",
        CFrameQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375),
        CFrameBoss = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
    },
    ["Cake Queen"] = {
        NameQuestBoss = "IceCreamIslandQuest",
        QuestLvBoss = 3,
        RewardBoss = "Reward:\n$30,000\n112,500,000 Exp.",
        CFrameQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664),
        CFrameBoss = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
    },
    ["Longma"] = {
        CFrameBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
    },
    ["Soul Reaper"] = {
        CFrameBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
    },
    ["rip_indra True Form"] = {
        CFrameBoss = CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625)
    }
}

function CheckBossQuest()
    -- Reset sạch để tránh dính data cũ
    BossMon = nil
    NameBoss = nil
    NameQuestBoss = nil
    QuestLvBoss = nil
    RewardBoss = nil
    CFrameQBoss = nil
    CFrameBoss = nil

    if not SelectBoss or SelectBoss == "" then return end

    local data = BossData[SelectBoss]
    if data then
        BossMon = SelectBoss
        NameBoss = SelectBoss
        NameQuestBoss = data.NameQuestBoss
        QuestLvBoss = data.QuestLvBoss
        RewardBoss = data.RewardBoss
        CFrameQBoss = data.CFrameQBoss
        CFrameBoss = data.CFrameBoss
    end
end
----------------------------------------------------------------
-- Material
----------------------------------------------------------------
local MaterialData = {
    -- ========== Flat (không phụ thuộc Sea) ==========
    ["Radioactive Material"] = {
        MMon = "Factory Staff",
        MPos = CFrame.new(295, 73, -56),
        TargetSea = 2
    },
    ["Mystic Droplet"] = {
        MMon = "Water Fighter",
        MPos = CFrame.new(-3385, 239, -10542),
        TargetSea = 2
    },
    ["Angel Wings"] = {
        MMon = "God's Guard",
        MPos = CFrame.new(-4698, 845, -1912),
        Entrance = Vector3.new(-7859.09814, 5544.19043, -381.476196),
        Distance = 5000,
        TargetSea = 1
    },
    ["Demonic Wisp"] = {
        MMon = "Demonic Soul",
        MPos = CFrame.new(-9507, 172, 6158),
        TargetSea = 3
    },
    ["Vampire Fang"] = {
        MMon = "Vampire",
        MPos = CFrame.new(-6033, 7, -1317),
        TargetSea = 2
    },
    ["Conjured Cocoa"] = {
        MMon = "Chocolate Bar Battler",
        MPos = CFrame.new(620.63446, 78.93644, -12581.36914),
        TargetSea = 3
    },
    ["Dragon Scale"] = {
        MMon = "Dragon Crew Archer",
        MPos = CFrame.new(6827.91455, 609.41271, 252.3538),
        TargetSea = 3
    },
    ["Gunpowder"] = {
        MMon = "Pistol Billionaire",
        MPos = CFrame.new(-469, 74, 5904),
        TargetSea = 3
    },
    ["Mini Tusk"] = {
        MMon = "Mythological Pirate",
        MPos = CFrame.new(-13540, 332, -10440),
        TargetSea = 3
    },

    -- ========== Có chia theo Sea ==========
    ["Magma Ore"] = {
        Sea1 = { MMon = "Military Spy", MPos = CFrame.new(-5815, 84, 8820) },
        Sea2 = { MMon = "Magma Ninja", MPos = CFrame.new(-5428, 78, -5959) }
    },
    ["Leather"] = {
        Sea1 = { MMon = "Brute", MPos = CFrame.new(-1145, 15, 4350) },
        Sea2 = { MMon = "Marine Captain", MPos = CFrame.new(-2010.50598, 73.00115, -3326.62085) },
        Sea3 = { MMon = "Jungle Pirate", MPos = CFrame.new(-11975.78515, 331.7734, -10620.03027) }
    },
    ["Scrap Metal"] = {
        Sea1 = { MMon = "Brute", MPos = CFrame.new(-1145, 15, 4350) },
        Sea2 = { MMon = "Swan Pirate", MPos = CFrame.new(878, 122, 1235) },
        Sea3 = { MMon = "Jungle Pirate", MPos = CFrame.new(-12107, 332, -10549) }
    },
    ["Fish Tail"] = {
        Sea1 = {
            MMon = "Fishman Warrior",
            MPos = CFrame.new(61123, 19, 1569),
            Entrance = Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875),
            Distance = 17000
        },
        Sea3 = {
            MMon = "Fishman Raider",
            MPos = CFrame.new(-10993, 332, -8940)
        }
    }
}

-- Hàm hỗ trợ dịch chuyển Sea (Travel Sea)
local function TravelToSea(targetSeaNumber)
    local commF = game:GetService("ReplicatedStorage").Remotes.CommF_
    if targetSeaNumber == 1 then
        commF:InvokeServer("TravelMain")
    elseif targetSeaNumber == 2 then
        commF:InvokeServer("TravelDressrosa")
    elseif targetSeaNumber == 3 then
        commF:InvokeServer("TravelZou")
    end
end

-- Biến chống spam đổi Sea
local lastTravelTime = 0

function MaterialMon()
    -- Reset sạch
    MMon = nil
    MPos = nil

    if not SelectMaterial or SelectMaterial == "" then return end

    local matInfo = MaterialData[SelectMaterial]
    if not matInfo then return end

    -- Xác định Sea hiện tại dạng số (1, 2, 3)
    local currentSeaNum = Sea1 and 1 or Sea2 and 2 or Sea3 and 3
    local currentSeaKey = "Sea" .. tostring(currentSeaNum)

    -- Lấy dữ liệu nguyên liệu theo Sea hiện tại
    local data = matInfo[currentSeaKey] or (matInfo.MMon and matInfo)

    -- NẾU SEA HIỆN TẠI KHÔNG CÓ NGUYÊN LIỆU NÀY
    if not (data and data.MMon and data.MPos) then
        -- Tìm Sea nào có chứa nguyên liệu này
        local targetSea = nil

        if matInfo.TargetSea then
            targetSea = matInfo.TargetSea
        else
            if matInfo.Sea1 then targetSea = 1
            elseif matInfo.Sea2 then targetSea = 2
            elseif matInfo.Sea3 then targetSea = 3
            end
        end

        -- Nếu tìm thấy Sea phù hợp và khác Sea hiện tại, thực hiện chuyển Sea với bộ đếm thời gian
        if targetSea and targetSea ~= currentSeaNum then
            if tick() - lastTravelTime > 5 then -- Chống spam 5 giây (an toàn và mượt mà)
                lastTravelTime = tick()
                TravelToSea(targetSea)
            end
        end
        return
    end

    -- Nếu Sea hiện tại có nguyên liệu, tiến hành gán dữ liệu bình thường
    MMon = data.MMon
    MPos = data.MPos

    -- Xử lý Entrance an toàn
    if data.Entrance and data.Distance then
        local char = game.Players.LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local dist = (root.Position - data.Entrance).Magnitude
            if dist >= data.Distance then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", data.Entrance)
            end
        end
    end
end
function UpdatePlayerChams()
    for _, player in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if not isnil(player.Character) then
                if ESPPlayer then
                    if (not isnil(player.Character.Head) and not player.Character.Head:FindFirstChild("NameEsp" .. Number)) then
                        local billboard = Instance.new("BillboardGui", player.Character.Head);
                        v1146.Name = "NameEsp" .. Number ;
                        v1146.ExtentsOffset = Vector3.new(0, 1, 0);
                        v1146.Size = UDim2.new(1, 200, 1, 30);
                        v1146.Adornee = player.Character.Head;
                        v1146.AlwaysOnTop = true;
                        local textLabel = Instance.new("TextLabel", v1146);
                        v1153.Font = Enum.Font.GothamSemibold;
                        v1153.FontSize = "Size10";
                        v1153.TextWrapped = true;
                        v1153.Text = player.Name .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude / 3) .. " Distance" ;
                        v1153.Size = UDim2.new(1, 0, 1, 0);
                        v1153.TextYAlignment = "Top";
                        v1153.BackgroundTransparency = 1;
                        v1153.TextStrokeTransparency = 0.5;
                        if (player.Team == game.Players.LocalPlayer.Team) then
                            v1153.TextColor3 = Color3.new(0, 0, 254);
                        else
                            v1153.TextColor3 = Color3.new(255, 0, 0);
                        end
                    else
                        player.Character.Head["NameEsp" .. Number ].TextLabel.Text = player.Name .. " | " .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v20((player.Character.Humanoid.Health * 100) / player.Character.Humanoid.MaxHealth) .. "%" ;
                    end
                elseif player.Character.Head:FindFirstChild("NameEsp" .. Number) then
                    player.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy();
                end
            end
        end);
    end
end
function UpdateChestChams()
    for _, obj in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if string.find(obj.Name, "Chest") then
                if ChestESP then
                    if string.find(obj.Name, "Chest") then
                        if not obj:FindFirstChild("NameEsp" .. Number) then
                            local billboard = Instance.new("BillboardGui", obj);
                            v1475.Name = "NameEsp" .. Number ;
                            v1475.ExtentsOffset = Vector3.new(0, 1, 0);
                            v1475.Size = UDim2.new(1, 200, 1, 30);
                            v1475.Adornee = obj;
                            v1475.AlwaysOnTop = true;
                            local textLabel = Instance.new("TextLabel", v1475);
                            v1481.Font = Enum.Font.GothamSemibold;
                            v1481.FontSize = "Size14";
                            v1481.TextWrapped = true;
                            v1481.Size = UDim2.new(1, 0, 1, 0);
                            v1481.TextYAlignment = "Top";
                            v1481.BackgroundTransparency = 1;
                            v1481.TextStrokeTransparency = 0.5;
                            if (obj.Name == "Chest1") then
                                v1481.TextColor3 = Color3.fromRGB(109, 109, 109);
                                v1481.Text = "Chest 1" .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - obj.Position).Magnitude / 3) .. " Distance" ;
                            end
                            if (obj.Name == "Chest2") then
                                v1481.TextColor3 = Color3.fromRGB(173, 158, 21);
                                v1481.Text = "Chest 2" .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - obj.Position).Magnitude / 3) .. " Distance" ;
                            end
                            if (obj.Name == "Chest3") then
                                v1481.TextColor3 = Color3.fromRGB(85, 255, 255);
                                v1481.Text = "Chest 3" .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - obj.Position).Magnitude / 3) .. " Distance" ;
                            end
                        else
                            obj["NameEsp" .. Number ].TextLabel.Text = obj.Name .. "   \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - obj.Position).Magnitude / 3) .. " Distance" ;
                        end
                    end
                elseif obj:FindFirstChild("NameEsp" .. Number) then
                    obj:FindFirstChild("NameEsp" .. Number):Destroy();
                end
            end
        end);
    end
end
function UpdateDevilChams()
    for _, obj in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if DevilFruitESP then
                if string.find(obj.Name, "Fruit") then
                    if not obj.Handle:FindFirstChild("NameEsp" .. Number) then
                        local billboard = Instance.new("BillboardGui", obj.Handle);
                        v1164.Name = "NameEsp" .. Number ;
                        v1164.ExtentsOffset = Vector3.new(0, 1, 0);
                        v1164.Size = UDim2.new(1, 200, 1, 30);
                        v1164.Adornee = obj.Handle;
                        v1164.AlwaysOnTop = true;
                        local textLabel = Instance.new("TextLabel", v1164);
                        v1171.Font = Enum.Font.GothamSemibold;
                        v1171.FontSize = "Size14";
                        v1171.TextWrapped = true;
                        v1171.Size = UDim2.new(1, 0, 1, 0);
                        v1171.TextYAlignment = "Top";
                        v1171.BackgroundTransparency = 1;
                        v1171.TextStrokeTransparency = 0.5;
                        v1171.TextColor3 = Color3.fromRGB(255, 255, 255);
                        v1171.Text = obj.Name .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - obj.Handle.Position).Magnitude / 3) .. " Distance" ;
                    else
                        obj.Handle["NameEsp" .. Number ].TextLabel.Text = obj.Name .. "   \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - obj.Handle.Position).Magnitude / 3) .. " Distance" ;
                    end
                end
            elseif obj.Handle:FindFirstChild("NameEsp" .. Number) then
                obj.Handle:FindFirstChild("NameEsp" .. Number):Destroy();
            end
        end);
    end
end
function UpdateFlowerChams()
    for _, obj in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if ((obj.Name == "Flower2") or (obj.Name == "Flower1")) then
                if FlowerESP then
                    if not obj:FindFirstChild("NameEsp" .. Number) then
                        local billboard = Instance.new("BillboardGui", obj);
                        v1183.Name = "NameEsp" .. Number ;
                        v1183.ExtentsOffset = Vector3.new(0, 1, 0);
                        v1183.Size = UDim2.new(1, 200, 1, 30);
                        v1183.Adornee = obj;
                        v1183.AlwaysOnTop = true;
                        local textLabel = Instance.new("TextLabel", v1183);
                        v1189.Font = Enum.Font.GothamSemibold;
                        v1189.FontSize = "Size14";
                        v1189.TextWrapped = true;
                        v1189.Size = UDim2.new(1, 0, 1, 0);
                        v1189.TextYAlignment = "Top";
                        v1189.BackgroundTransparency = 1;
                        v1189.TextStrokeTransparency = 0.5;
                        v1189.TextColor3 = Color3.fromRGB(255, 0, 0);
                        if (obj.Name == "Flower1") then
                            v1189.Text = "Blue Flower" .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - obj.Position).Magnitude / 3) .. " Distance" ;
                            v1189.TextColor3 = Color3.fromRGB(0, 0, 255);
                        end
                        if (obj.Name == "Flower2") then
                            v1189.Text = "Red Flower" .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - obj.Position).Magnitude / 3) .. " Distance" ;
                            v1189.TextColor3 = Color3.fromRGB(255, 0, 0);
                        end
                    else
                        obj["NameEsp" .. Number ].TextLabel.Text = obj.Name .. "   \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - obj.Position).Magnitude / 3) .. " Distance" ;
                    end
                elseif obj:FindFirstChild("NameEsp" .. Number) then
                    obj:FindFirstChild("NameEsp" .. Number):Destroy();
                end
            end
        end);
    end
end
function UpdateRealFruitChams()
    for _, fruit in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if fruit:IsA("Tool") then
            if RealFruitESP then
                if not fruit.Handle:FindFirstChild("NameEsp" .. Number) then
                    local billboard = Instance.new("BillboardGui", fruit.Handle);
                    v907.Name = "NameEsp" .. Number ;
                    v907.ExtentsOffset = Vector3.new(0, 1, 0);
                    v907.Size = UDim2.new(1, 200, 1, 30);
                    v907.Adornee = fruit.Handle;
                    v907.AlwaysOnTop = true;
                    local textLabel = Instance.new("TextLabel", v907);
                    v914.Font = Enum.Font.GothamSemibold;
                    v914.FontSize = "Size14";
                    v914.TextWrapped = true;
                    v914.Size = UDim2.new(1, 0, 1, 0);
                    v914.TextYAlignment = "Top";
                    v914.BackgroundTransparency = 1;
                    v914.TextStrokeTransparency = 0.5;
                    v914.TextColor3 = Color3.fromRGB(255, 0, 0);
                    v914.Text = fruit.Name .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - fruit.Handle.Position).Magnitude / 3) .. " Distance" ;
                else
                    fruit.Handle["NameEsp" .. Number ].TextLabel.Text = fruit.Name .. " " .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - fruit.Handle.Position).Magnitude / 3) .. " Distance" ;
                end
            elseif fruit.Handle:FindFirstChild("NameEsp" .. Number) then
                fruit.Handle:FindFirstChild("NameEsp" .. Number):Destroy();
            end
        end
    end
    for _, fruit in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if fruit:IsA("Tool") then
            if RealFruitESP then
                if not fruit.Handle:FindFirstChild("NameEsp" .. Number) then
                    local billboard = Instance.new("BillboardGui", fruit.Handle);
                    v926.Name = "NameEsp" .. Number ;
                    v926.ExtentsOffset = Vector3.new(0, 1, 0);
                    v926.Size = UDim2.new(1, 200, 1, 30);
                    v926.Adornee = fruit.Handle;
                    v926.AlwaysOnTop = true;
                    local textLabel = Instance.new("TextLabel", v926);
                    v933.Font = Enum.Font.GothamSemibold;
                    v933.FontSize = "Size14";
                    v933.TextWrapped = true;
                    v933.Size = UDim2.new(1, 0, 1, 0);
                    v933.TextYAlignment = "Top";
                    v933.BackgroundTransparency = 1;
                    v933.TextStrokeTransparency = 0.5;
                    v933.TextColor3 = Color3.fromRGB(255, 174, 0);
                    v933.Text = fruit.Name .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - fruit.Handle.Position).Magnitude / 3) .. " Distance" ;
                else
                    fruit.Handle["NameEsp" .. Number ].TextLabel.Text = fruit.Name .. " " .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - fruit.Handle.Position).Magnitude / 3) .. " Distance" ;
                end
            elseif fruit.Handle:FindFirstChild("NameEsp" .. Number) then
                fruit.Handle:FindFirstChild("NameEsp" .. Number):Destroy();
            end
        end
    end
    for v439, v440 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v440:IsA("Tool") then
            if RealFruitESP then
                if not v440.Handle:FindFirstChild("NameEsp" .. Number) then
                    local billboard = Instance.new("BillboardGui", v440.Handle);
                    v945.Name = "NameEsp" .. Number ;
                    v945.ExtentsOffset = Vector3.new(0, 1, 0);
                    v945.Size = UDim2.new(1, 200, 1, 30);
                    v945.Adornee = v440.Handle;
                    v945.AlwaysOnTop = true;
                    local textLabel = Instance.new("TextLabel", v945);
                    v952.Font = Enum.Font.GothamSemibold;
                    v952.FontSize = "Size14";
                    v952.TextWrapped = true;
                    v952.Size = UDim2.new(1, 0, 1, 0);
                    v952.TextYAlignment = "Top";
                    v952.BackgroundTransparency = 1;
                    v952.TextStrokeTransparency = 0.5;
                    v952.TextColor3 = Color3.fromRGB(251, 255, 0);
                    v952.Text = v440.Name .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v440.Handle.Position).Magnitude / 3) .. " Distance" ;
                else
                    v440.Handle["NameEsp" .. Number ].TextLabel.Text = v440.Name .. " " .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v440.Handle.Position).Magnitude / 3) .. " Distance" ;
                end
            elseif v440.Handle:FindFirstChild("NameEsp" .. Number) then
                v440.Handle:FindFirstChild("NameEsp" .. Number):Destroy();
            end
        end
    end
end
----------------------------------------------------------------
-- ESP Đảo
----------------------------------------------------------------
function UpdateIslandESP()
    -- 1. Tìm thư mục chứa các đảo
    local locations = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")
    if not locations then return end

    -- 2. Lấy vị trí nhân vật hiện tại
    local myPos = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Head") and Players.LocalPlayer.Character.Head.Position

    for _, island in pairs(locations:GetChildren()) do
        pcall(function()
            -- Nếu tắt ESP hoặc mất nhân vật -> Xóa ESP cũ
            if not IslandESP or not myPos then
                local oldEsp = island:FindFirstChild("NameEsp")
                if oldEsp then oldEsp:Destroy() end
                return
            end

            if island.Name == "Sea" or not island:IsA("BasePart") then return end

            -- 3. Tạo khung hiển thị (BillboardGui) nếu chưa có
            local esp = island:FindFirstChild("NameEsp")
            if not esp then
                esp = Instance.new("BillboardGui", island)
                esp.Name = "NameEsp"
                esp.Size = UDim2.new(0, 200, 0, 45)
                esp.StudsOffset = Vector3.new(0, 4, 0)
                esp.AlwaysOnTop = true

                local text = Instance.new("TextLabel", esp)
                text.Name = "TextLabel"
                text.Size = UDim2.new(1, 0, 1, 0)
                text.BackgroundTransparency = 1
                text.TextColor3 = Color3.fromRGB(255, 255, 255)
                text.TextStrokeTransparency = 0.2
                text.Font = Enum.Font.GothamBold
                text.TextSize = 15
            end

            -- 4. Tính khoảng cách và cập nhật chữ liên tục
            local dist = math.floor((myPos - island.Position).Magnitude / 3)
            esp.TextLabel.Text = string.format("%s\n[%d m]", island.Name, dist)
        end)
    end
end
function isnil(v200)
    return v200 == nil ;
end
local function v20(v201)
    return math.floor(tonumber(v201) + 0.5);
end
Number = math.random(1, 1000000);
function UpdateIslandMirageESP()
    for v457, v458 in pairs(game:GetService("Workspace")['_WorldOrigin'].Locations:GetChildren()) do
        pcall(function()
            if MirageIslandESP then
                if (v458.Name == "Mirage Island") then
                    if not v458:FindFirstChild("NameEsp") then
                        local billboard = Instance.new("BillboardGui", v458);
                        v1270.Name = "NameEsp";
                        v1270.ExtentsOffset = Vector3.new(0, 1, 0);
                        v1270.Size = UDim2.new(1, 200, 1, 30);
                        v1270.Adornee = v458;
                        v1270.AlwaysOnTop = true;
                        local textLabel = Instance.new("TextLabel", v1270);
                        v1276.Font = "Code";
                        v1276.FontSize = "Size14";
                        v1276.TextWrapped = true;
                        v1276.Size = UDim2.new(1, 0, 1, 0);
                        v1276.TextYAlignment = "Top";
                        v1276.BackgroundTransparency = 1;
                        v1276.TextStrokeTransparency = 0.5;
                        v1276.TextColor3 = Color3.fromRGB(80, 245, 245);
                    else
                        v458['NameEsp'].TextLabel.Text = v458.Name .. "   \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v458.Position).Magnitude / 3) .. " M" ;
                    end
                end
            elseif v458:FindFirstChild("NameEsp") then
                v458:FindFirstChild("NameEsp"):Destroy();
            end
        end);
    end
end
function UpdateAuraESP()
    for v459, v460 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        pcall(function()
            if AuraESP then
                if (v460.Name == "Master of Enhancement") then
                    if not v460:FindFirstChild("NameEsp") then
                        local billboard = Instance.new("BillboardGui", v460);
                        v1286.Name = "NameEsp";
                        v1286.ExtentsOffset = Vector3.new(0, 1, 0);
                        v1286.Size = UDim2.new(1, 200, 1, 30);
                        v1286.Adornee = v460;
                        v1286.AlwaysOnTop = true;
                        local textLabel = Instance.new("TextLabel", v1286);
                        v1292.Font = "Code";
                        v1292.FontSize = "Size14";
                        v1292.TextWrapped = true;
                        v1292.Size = UDim2.new(1, 0, 1, 0);
                        v1292.TextYAlignment = "Top";
                        v1292.BackgroundTransparency = 1;
                        v1292.TextStrokeTransparency = 0.5;
                        v1292.TextColor3 = Color3.fromRGB(80, 245, 245);
                    else
                        v460['NameEsp'].TextLabel.Text = v460.Name .. "   \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v460.Position).Magnitude / 3) .. " M" ;
                    end
                end
            elseif v460:FindFirstChild("NameEsp") then
                v460:FindFirstChild("NameEsp"):Destroy();
            end
        end);
    end
end
function UpdateLSDESP()
    for v461, v462 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        pcall(function()
            if LADESP then
                if (v462.Name == "Legendary Sword Dealer") then
                    if not v462:FindFirstChild("NameEsp") then
                        local billboard = Instance.new("BillboardGui", v462);
                        v1302.Name = "NameEsp";
                        v1302.ExtentsOffset = Vector3.new(0, 1, 0);
                        v1302.Size = UDim2.new(1, 200, 1, 30);
                        v1302.Adornee = v462;
                        v1302.AlwaysOnTop = true;
                        local textLabel = Instance.new("TextLabel", v1302);
                        v1308.Font = "Code";
                        v1308.FontSize = "Size14";
                        v1308.TextWrapped = true;
                        v1308.Size = UDim2.new(1, 0, 1, 0);
                        v1308.TextYAlignment = "Top";
                        v1308.BackgroundTransparency = 1;
                        v1308.TextStrokeTransparency = 0.5;
                        v1308.TextColor3 = Color3.fromRGB(80, 245, 245);
                    else
                        v462['NameEsp'].TextLabel.Text = v462.Name .. "   \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v462.Position).Magnitude / 3) .. " M" ;
                    end
                end
            elseif v462:FindFirstChild("NameEsp") then
                v462:FindFirstChild("NameEsp"):Destroy();
            end
        end);
    end
end
function UpdateGeaESP()
    for v463, v464 in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do
        pcall(function()
            if GearESP then
                if (v464.Name == "MeshPart") then
                    if not v464:FindFirstChild("NameEsp") then
                        local billboard = Instance.new("BillboardGui", v464);
                        v1318.Name = "NameEsp";
                        v1318.ExtentsOffset = Vector3.new(0, 1, 0);
                        v1318.Size = UDim2.new(1, 200, 1, 30);
                        v1318.Adornee = v464;
                        v1318.AlwaysOnTop = true;
                        local textLabel = Instance.new("TextLabel", v1318);
                        v1324.Font = "Code";
                        v1324.FontSize = "Size14";
                        v1324.TextWrapped = true;
                        v1324.Size = UDim2.new(1, 0, 1, 0);
                        v1324.TextYAlignment = "Top";
                        v1324.BackgroundTransparency = 1;
                        v1324.TextStrokeTransparency = 0.5;
                        v1324.TextColor3 = Color3.fromRGB(80, 245, 245);
                    else
                        v464['NameEsp'].TextLabel.Text = v464.Name .. "   \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v464.Position).Magnitude / 3) .. " M" ;
                    end
                end
            elseif v464:FindFirstChild("NameEsp") then
                v464:FindFirstChild("NameEsp"):Destroy();
            end
        end);
    end
end
function BTPZ(v209)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v209;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v209;
end
local TweenSpeed = 270
local CurrentTween = nil
_G.StopTween = false
function Tween(targetCFrame)
    if _G.StopTween then return end
    if not game.Players.LocalPlayer.Character then return end
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local distance = (targetCFrame.Position - root.Position).Magnitude
    if distance < 2 then
        root.CFrame = targetCFrame
        return
    end
    if CurrentTween then
        pcall(function() CurrentTween:Cancel() end)
        CurrentTween = nil
    end
    local time = distance / TweenSpeed
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
    CurrentTween = game:GetService("TweenService"):Create(root, tweenInfo, {
        CFrame = targetCFrame
    })
    CurrentTween:Play()
end
function CancelTween()
    _G.StopTween = true

    if CurrentTween then
        pcall(function() CurrentTween:Cancel() end)
        CurrentTween = nil
    end
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
    task.wait(0.15)
    _G.StopTween = false
end
function Tween2(targetCFrame)
    if not game.Players.LocalPlayer.Character then return end
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local distance = (targetCFrame.Position - root.Position).Magnitude
    if distance < 3 then
        root.CFrame = targetCFrame
        return
    end
    _G.StopTween = false
    _G.Clip2 = true
    Tween(targetCFrame)
    while (root.Position - targetCFrame.Position).Magnitude > 6 do
        if _G.StopTween then break end
        task.wait()
    end
    if not _G.StopTween and root.Parent then
        root.CFrame = targetCFrame
        root.AssemblyLinearVelocity = Vector3.zero
    end

    _G.Clip2 = false
end
function EquipTool(v217)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(v217) then
        local v570 = game.Players.LocalPlayer.Backpack:FindFirstChild(v217)
        task.wait()
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v570)
    end
end
spawn(function()
    local v218 = getrawmetatable(game);
    local v219 = v218.__namecall;
    setreadonly(v218, false);
    v218.__namecall = newcclosure(function(...)
        local v465 = getnamecallmethod();
        local v466 = {
            ...
        };
        if (tostring(v465) == "FireServer") then
            if (tostring(v466[1]) == "RemoteEvent") then
                if ((tostring(v466[2]) ~= "true") and (tostring(v466[2]) ~= "false")) then
                    if _G.UseSkill then
                        if (type(v466[2]) == "vector") then
                            v466[2] = PositionSkillMasteryDevilFruit;
                        else
                            v466[2] = CFrame.new(PositionSkillMasteryDevilFruit);
                        end
                        return v219(unpack(v466));
                    end
                end
            end
        end
        return v219(...);
    end);
end);
spawn(function()
    while task.wait() do
        pcall(function()
            if (_G.AutoEvoRace or _G.CastleRaid or _G.CollectAzure or _G.TweenToKitsune or _G.GhostShip or _G.Ship or _G.Auto_Holy_Torch or _G.TeleportPly or _G.Auto_Sea3 or _G.Auto_Sea2 or _G.Tweenfruit or _G.AutoFishCrew or _G.Auto_Saber or _G.AutoShark or _G.Auto_Warden or _G.Auto_RainbowHaki or AutoFarmRace or _G.AutoQuestRace or Auto_Law or AutoTushita or _G.AutoHolyTorch or _G.AutoTerrorshark or _G.farmpiranya or _G.Auto_MusketeerHat or _G.Auto_ObservationV2 or _G.AutoNear or _G.Auto_PoleV1 or _G.Auto_Buddy or _G.Ectoplasm or AutoEvoRace or AutoBartilo or _G.Auto_Canvander or _G.AutoLevel or _G.Auto_DualKatana or Auto_Quest_Yama_3 or Auto_Quest_Yama_2 or Auto_Quest_Yama_1 or Auto_Quest_Tushita_1 or Auto_Quest_Tushita_2 or Auto_Quest_Tushita_3 or _G.Clip2 or _G.Auto_Regoku or _G.AutoBone or _G.AutoBoneNoQuest or _G.AutoBoss or AutoFarmMasDevilFruit or AutoHallowSycthe or AutoTushita or _G.CakePrince or _G.Auto_SkullGuitar or _G.AutoFarmSwan or _G.DoughKing or _G.AutoEliteor or AutoNextIsland or Musketeer or _G.AutoMaterial or AutoFarmRaceQuest or _G.Factory or _G.Auto_Saw or _G.AutoFrozenDimension or _G.AutoKillTrial or _G.AutoUpgrade or _G.TweenToFrozenDimension) then
                if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local v887 = Instance.new("BodyVelocity");
                    v887.Name = "BodyClip";
                    v887.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart;
                    v887.MaxForce = Vector3.new(0, 100000, 0);
                    v887.Velocity = Vector3.new(0, 0, 0);
                end
            else
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy();
            end
        end);
    end
end);
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if (_G.AutoEvoRace or _G.Auto_RainbowHaki or _G.Auto_SkullGuitar or _G.CastleRaid or _G.CollectAzure or _G.TweenToKitsune or _G.Auto_Sea3 or _G.Auto_Sea2 or _G.GhostShip or _G.Ship or _G.Auto_Holy_Torch or _G.TeleportPly or _G.Tweenfruit or _G.Auto_Saber or _G.Auto_PoleV1 or _G.Auto_MusketeerHat or _G.AutoFishCrew or _G.AutoShark or AutoFarmRace or _G.AutoQuestRace or _G.Auto_Warden or Auto_Law or _G.Auto_DualKatana or Auto_Quest_Tushita_1 or Auto_Quest_Tushita_2 or Auto_Quest_Tushita_3 or AutoTushita or _G.AutoHolyTorch or _G.Auto_Buddy or _G.AutoTerrorshark or _G.farmpiranya or Auto_Quest_Yama_3 or _G.Auto_ObservationV2 or Auto_Quest_Yama_2 or Auto_Quest_Yama_1 or _G.AutoNear or _G.Ectoplasm or AutoEvoRace or _G.AutoKillTrial or AutoBartilo or _G.Auto_Regoku or _G.AutoLevel or _G.Clip2 or _G.AutoBone or _G.Auto_Canvander or _G.AutoBoneNoQuest or _G.AutoBoss or _G.Auto_Saw or AutoFarmMasDevilFruit or AutoHallowSycthe or AutoTushita or _G.CakePrince or _G.DoughKing or _G.AutoFarmSwan or _G.AutoEliteor or AutoNextIsland or Musketeer or _G.AutoMaterial or _G.Factory or _G.AutoFrozenDimension or AutoFarmRaceQuest or _G.AutoUpgrade or _G.TweenToFrozenDimension) then
                for v834, v835 in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v835:IsA("BasePart") then
                        v835.CanCollide = false;
                    end
                end
            end
        end);
    end);
end);
task.spawn(function()
    if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
        game.Players.LocalPlayer.Character.Stun.Changed:connect(function()
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
                    game.Players.LocalPlayer.Character.Stun.Value = 0;
                end
            end);
        end);
    end
end);
function CheckMaterial(v221)
    for v467, v468 in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if (type(v468) == "table") then
            if (v468.Type == "Material") then
                if (v468.Name == v221) then
                    return v468.Count;
                end
            end
        end
    end
    return 0;
end
function GetWeaponInventory(v222)
    for v469, v470 in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if (type(v470) == "table") then
            if (v470.Type == "Sword") then
                if (v470.Name == v222) then
                    return true;
                end
            end
        end
    end
    return false;
end
local LocalPlayer = game.Players.LocalPlayer;
function FindEnemiesInRange(v223, v224)
    local v225 = (v21.Character or v21.CharacterAdded:Wait()):GetPivot().Position;
    local v226 = nil;
    for v471, v472 in ipairs(v224) do
        if (not v472:GetAttribute("IsBoat") and v472:FindFirstChildOfClass("Humanoid") and (v472.Humanoid.Health > 0)) then
            local v671 = v472:FindFirstChild("Head");
            if (v671 and ((v225 - v671.Position).Magnitude <= 60)) then
                if (v472 ~= v21.Character) then
                    table.insert(v223, {
                        v472,
                        v671
                    });
                    v226 = v671;
                end
            end
        end
    end
    for v473, v474 in ipairs(game.Players:GetPlayers()) do
        if (v474.Character and (v474 ~= v21)) then
            local v672 = v474.Character:FindFirstChild("Head");
            if (v672 and ((v225 - v672.Position).Magnitude <= 60)) then
                table.insert(v223, {
                    v474.Character,
                    v672
                });
                v226 = v672;
            end
        end
    end
    return v226;
end
function GetEquippedTool()
    local v227 = v21.Character;
    if not v227 then
        return nil;
    end
    for v475, v476 in ipairs(v227:GetChildren()) do
        if v476:IsA("Tool") then
            return v476;
        end
    end
    return nil;
end
function AttackNoCoolDown()
    local v228 = {};
    local v229 = game:GetService("Workspace").Enemies:GetChildren();
    local v230 = FindEnemiesInRange(v228, v229);
    if not v230 then
        return;
    end
    local v231 = GetEquippedTool();
    if not v231 then
        return;
    end
    pcall(function()
        local delay = _G.Fast_Delay or 0.5
        local v477 = game:GetService("ReplicatedStorage");
        local v478 = v477:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack");
        local v479 = v477:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit");
        if (# v228 > 0) then
            v478:FireServer(delay);
            v479:FireServer(v230, v228);
        else
            task.wait(delay);
        end
    end);
end
Type = 1
Pos = CFrame.new(0, 30, 0)
function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso");
    end
end
function to(v232)
    repeat
        wait(_G.Fast_Delay);
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(15);
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v232;
        task.wait();
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v232;
    until (v232.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2000
end
function to(v233)
    pcall(function()
        if (((v233.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000) and not Auto_Raid and (game.Players.LocalPlayer.Character.Humanoid.Health > 0)) then
            if (NameMon == "FishmanQuest") then
                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame);
                wait();
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875));
            elseif (Mon == "God's Guard") then
                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame);
                wait();
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 4607.82275, 872.54248, - 1667.55688));
            elseif (NameMon == "SkyExp1Quest") then
                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame);
                wait();
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047));
            elseif (NameMon == "ShipQuest1") then
                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame);
                wait();
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
            elseif (NameMon == "ShipQuest2") then
                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame);
                wait();
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
            elseif (NameMon == "FrostQuest") then
                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame);
                wait();
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 6508.5581054688, 89.034996032715, - 132.83953857422));
            else
                repeat
                    wait(_G.Fast_Delay);
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v233;
                    wait(0.05);
                    game.Players.LocalPlayer.Character.Head:Destroy();
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v233;
                until ((v233.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2500) and (game.Players.LocalPlayer.Character.Humanoid.Health > 0)
                wait();
            end
        end
    end);
end
if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Death") then
    game:GetService("ReplicatedStorage").Effect.Container.Death:Destroy();
end
if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Respawn") then
    game:GetService("ReplicatedStorage").Effect.Container.Respawn:Destroy();
end
Tabs.Home:AddButton({
    Title = "Discord",
    Description = "Giao Lưu",
    Callback = function()
        setclipboard("https://discord.gg/25ms")
    end
})
local SelectWeaponDropdown = Tabs.Main:AddDropdown("DropdownSelectWeapon", {
    Title = "Vũ Khí",
    Description = "",
    Values = {
        "Melee",
        "Sword",
        "Blox Fruits"
    },
    Multi = false,
    Default = 1
});
SelectWeaponDropdown:SetValue("Melee");
SelectWeaponDropdown:OnChanged(function(v236)
    ChooseWeapon = v236;
end);
task.spawn(function()
    while wait() do
        pcall(function()
            if (ChooseWeapon == "Melee") then
                for v836, v837 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if (v837.ToolTip == "Melee") then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v837.Name)) then
                            SelectWeapon = v837.Name;
                        end
                    end
                end
            elseif (ChooseWeapon == "Sword") then
                for v1028, v1029 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if (v1029.ToolTip == "Sword") then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v1029.Name)) then
                            SelectWeapon = v1029.Name;
                        end
                    end
                end
            elseif (ChooseWeapon == "Blox Fruits") then
                for v1430, v1431 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if (v1431.ToolTip == "Blox Fruit") then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v1431.Name)) then
                            SelectWeapon = v1431.Name;
                        end
                    end
                end
            end
        end);
    end
end);
local AutoLevelToggle = Tabs.Main:AddToggle("ToggleLevel", {
    Title = "Cày Cấp",
    Description = "",
    Default = false
});
AutoLevelToggle:OnChanged(function(v237)
    _G.AutoLevel = v237;
    if (v237 == false) then
        wait();
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame);
        wait();
    end
end);
Options.ToggleLevel:SetValue(false);
spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                CheckLevel();
                if (not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false)) then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest");
                    Tween(CFrameQ);
                    if ((CFrameQ.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv);
                        task.wait(0.5);
                    end
                elseif (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true)) then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1433:FindFirstChild("Humanoid") and v1433:FindFirstChild("HumanoidRootPart") and (v1433.Humanoid.Health > 0)) then
                            if (v1433.Name == Ms) then
                                repeat
                                    wait(_G.Fast_Delay);
                                    AttackNoCoolDown();
                                    bringmob = true;
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    Tween(v1433.HumanoidRootPart.CFrame * Pos);
                                    v1433.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    v1433.HumanoidRootPart.Transparency = 1;
                                    v1433.Humanoid.JumpPower = 0;
                                    v1433.Humanoid.WalkSpeed = 0;
                                    v1433.HumanoidRootPart.CanCollide = false;
                                    FarmPos = v1433.HumanoidRootPart.CFrame;
                                    MonFarm = v1433.Name;
                                until not _G.AutoLevel or not v1433.Parent or (v1433.Humanoid.Health <= 0) or not game:GetService("Workspace").Enemies:FindFirstChild(v1433.Name) or (game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false)
                                bringmob = false;
                            end
                        end
                    end
                    for v1434, v1435 in pairs(game:GetService("Workspace")['_WorldOrigin'].EnemySpawns:GetChildren()) do
                        if string.find(v1435.Name, NameMon) then
                            if ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v1435.Position).Magnitude >= 10) then
                                Tween(v1435.CFrame * Pos);
                            end
                        end
                    end
                end
            end);
        end
    end
end);
local MobAuraToggle = Tabs.Main:AddToggle("ToggleMobAura", {
    Title = "Đấm Quái Gần",
    Description = "",
    Default = false
});
MobAuraToggle:OnChanged(function(v238)
    _G.AutoNear = v238;
    if (v238 == false) then
        wait();
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame);
        wait();
    end
end);
Options.ToggleMobAura:SetValue(false);
spawn(function()
    while wait() do
        if _G.AutoNear then
            pcall(function()
                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    if (v839:FindFirstChild("Humanoid") and v839:FindFirstChild("HumanoidRootPart") and (v839.Humanoid.Health > 0)) then
                        if v839.Name then
                            if ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v839:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 5000) then
                                repeat
                                    wait(_G.Fast_Delay);
                                    AttackNoCoolDown();
                                    bringmob = true;
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    Tween(v839.HumanoidRootPart.CFrame * Pos);
                                    v839.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    v839.HumanoidRootPart.Transparency = 1;
                                    v839.Humanoid.JumpPower = 0;
                                    v839.Humanoid.WalkSpeed = 0;
                                    v839.HumanoidRootPart.CanCollide = false;
                                    FarmPos = v839.HumanoidRootPart.CFrame;
                                    MonFarm = v839.Name;
                                until not _G.AutoNear or not v839.Parent or (v839.Humanoid.Health <= 0) or not game.Workspace.Enemies:FindFirstChild(v839.Name)
                                bringmob = false;
                            end
                        end
                    end
                end
            end);
        end
    end
end);
local CastleRaidToggle = Tabs.Main:AddToggle("ToggleCastleRaid", {
    Title = "Đấm Hải Tặc",
    Description = "",
    Default = false
});
CastleRaidToggle:OnChanged(function(v239)
    _G.CastleRaid = v239;
end);
Options.ToggleCastleRaid:SetValue(false);
spawn(function()
    while wait() do
        if _G.CastleRaid then
            pcall(function()
                local v764 = CFrame.new(- 5496.17432, 313.768921, - 2841.53027, 0.924894512, 7.37058e-9, 0.380223751, 3.588102e-8, 1, - 1.06665446e-7, - 0.380223751, 1.1229711e-7, 0.924894512);
                if ((CFrame.new(- 5539.3115234375, 313.800537109375, - 2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500) then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (_G.CastleRaid and v1031:FindFirstChild("HumanoidRootPart") and v1031:FindFirstChild("Humanoid") and (v1031.Humanoid.Health > 0)) then
                            if ((v1031.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000) then
                                repeat
                                    wait(_G.Fast_Delay);
                                    AttackNoCoolDown();
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    v1031.HumanoidRootPart.CanCollide = false;
                                    v1031.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    Tween(v1031.HumanoidRootPart.CFrame * Pos);
                                until (v1031.Humanoid.Health <= 0) or not v1031.Parent or not _G.CastleRaid
                            end
                        end
                    end
                else
                    Tween(v764);
                end
            end);
        end
    end
end);
local HakiFortressToggle = Tabs.Main:AddToggle("ToggleHakiFortress", {
    Title = "Bật Haki Màu Pháo Đài",
    Description = "",
    Default = false
});
HakiFortressToggle:OnChanged(function(v240)
    _G.EnableHakiFortress = v240;
end);
Options.ToggleHakiFortress:SetValue(false);
local function v53(v241, v242)
    local v243 = {
        [1] = {
            StorageName = v241,
            Type = "AuraSkin",
            Context = "Equip"
        }
    };
    game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/FruitCustomizerRF"):InvokeServer(unpack(v243));
    Tween2(v242);
end
local function v54(v244, v245)
    local v246 = game.Players.LocalPlayer.Character;
    if (not v246 or not v246:FindFirstChild("HumanoidRootPart")) then
        return false;
    end
    local v247 = v246.HumanoidRootPart.Position;
    return (v247 - v244).Magnitude < v245 ;
end
spawn(function()
    while true do
        if _G.EnableHakiFortress then
            v53("Snow White", Vector3.new(- 4971.71826171875, 335.9582214355469, - 3720.0595703125));
            while not v54(Vector3.new(- 4971.71826171875, 335.9582214355469, - 3720.0595703125), 1) do
                wait(0.1);
            end
            wait(0.5);
            v53("Pure Red", Vector3.new(- 5414.92041015625, 314.2582092285156, - 2212.20166015625));
            while not v54(Vector3.new(- 5414.92041015625, 314.2582092285156, - 2212.20166015625), 1) do
                wait(0.1);
            end
            wait(0.5);
            v53("Winter Sky", Vector3.new(- 5420.26318359375, 1089.3582763671875, - 2666.8193359375));
            while not v54(Vector3.new(- 5420.26318359375, 1089.3582763671875, - 2666.8193359375), 1) do
                wait(0.1);
            end
            wait(0.5);
            _G.EnableHakiFortress = false;
        end
        wait(0.5);
    end
end);
local CollectChestToggle = Tabs.Main:AddToggle("ToggleCollectChest", {
    Title = "Lụm Rương",
    Description = "",
    Default = false
});
CollectChestToggle:OnChanged(function(v248)
    _G.AutoCollectChest = v248;
end);
spawn(function()
    while wait() do
        if _G.AutoCollectChest then
            local v673 = game:GetService("Players");
            local v674 = v673.LocalPlayer;
            local v675 = v674.Character or v674.CharacterAdded:Wait() ;
            local v676 = v675:GetPivot().Position;
            local v677 = game:GetService("CollectionService");
            local v678 = v677:GetTagged("_ChestTagged");
            local v679, v680 = math.huge;
            for v765 = 1, # v678 do
                local v766 = v678[v765];
                local v767 = (v766:GetPivot().Position - v676).Magnitude;
                if (not v766:GetAttribute("IsDisabled") and (v767 < v679)) then
                    v679, v680 = v767, v766;
                end
            end
            if v680 then
                local v840 = v680:GetPivot().Position;
                local v841 = CFrame.new(v840);
                Tween2(v841);
            end
        end
    end
end);
local MasterySection = Tabs.Main:AddSection("Thông Thạo");
local MasteryDropdown = Tabs.Main:AddDropdown("DropdownMastery", {
    Title = "Cày Thông Thạo",
    Description = "",
    Values = {
        "Near Mobs"
    },
    Multi = false,
    Default = 1
});
MasteryDropdown:SetValue(TypeMastery);
MasteryDropdown:OnChanged(function(v249)
    TypeMastery = v249;
end);
local MasteryFruitToggle = Tabs.Main:AddToggle("ToggleMasteryFruit", {
    Title = "Cày Trái",
    Description = "",
    Default = false
});
MasteryFruitToggle:OnChanged(function(v250)
    AutoFarmMasDevilFruit = v250;
end);
Options.ToggleMasteryFruit:SetValue(false);
local HealthInput = Tabs.Main:AddInput("InputHealth", {
    Title = "Máu Quái Còn Lại",
    Description = "",
    Default = "20",
    Placeholder = "Nhập % Máu Quái",
    Numeric = true,
    Finished = false, 
    Callback = function(v251)
        local num = tonumber(v251)
        if num then
            KillPercent = math.clamp(num, 0, 100)
        else
            KillPercent = 20 
        end
    end
});
HealthInput:OnChanged(function(v252)
    KillPercent = v252;
end);
HealthInput:SetValue(20);
spawn(function()
    while task.wait() do
        if _G.UseSkill then
            pcall(function()
                if _G.UseSkill then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if ((v1033.Name == MonFarm) and v1033:FindFirstChild("Humanoid") and v1033:FindFirstChild("HumanoidRootPart") and (v1033.Humanoid.Health <= ((v1033.Humanoid.MaxHealth * KillPercent) / 100))) then
                            repeat
                                game:GetService("RunService").Heartbeat:wait();
                                EquipTool(game.Players.LocalPlayer.Data.DevilFruit.Value);
                                Tween(v1033.HumanoidRootPart.CFrame * Pos);
                                PositionSkillMasteryDevilFruit = v1033.HumanoidRootPart.Position;
                                if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).MousePos.Value = PositionSkillMasteryDevilFruit;
                                    local v1606 = game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).Level.Value;
                                    if (SkillZ and (v1606 >= 1)) then
                                        game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game);
                                        wait();
                                        game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game);
                                    end
                                    if (SkillX and (v1606 >= 2)) then
                                        game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game);
                                        wait();
                                        game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game);
                                    end
                                    if (SkillC and (v1606 >= 3)) then
                                        game:service("VirtualInputManager"):SendKeyEvent(true, "C", false, game);
                                        wait();
                                        game:service("VirtualInputManager"):SendKeyEvent(false, "C", false, game);
                                    end
                                    if (SkillV and (v1606 >= 4)) then
                                        game:service("VirtualInputManager"):SendKeyEvent(true, "V", false, game);
                                        wait();
                                        game:service("VirtualInputManager"):SendKeyEvent(false, "V", false, game);
                                    end
                                    if (SkillF and (v1606 >= 5)) then
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game);
                                        wait();
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game);
                                    end
                                end
                            until not AutoFarmMasDevilFruit or not _G.UseSkill or (v1033.Humanoid.Health == 0)
                        end
                    end
                end
            end);
        end
    end
end);
spawn(function()
    while task.wait(0.1) do
        if (AutoFarmMasDevilFruit and (TypeMastery == "Near Mobs")) then
            pcall(function()
                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    if (v843.Name and v843:FindFirstChild("Humanoid") and v843:FindFirstChild("HumanoidRootPart")) then
                        if ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v843:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 5000) then
                            repeat
                                wait(_G.Fast_Delay);
                                if (v843.Humanoid.Health <= ((v843.Humanoid.MaxHealth * KillPercent) / 100)) then
                                    _G.UseSkill = true;
                                else
                                    _G.UseSkill = false;
                                    AutoHaki();
                                    bringmob = true;
                                    EquipTool(SelectWeapon);
                                    Tween(v843.HumanoidRootPart.CFrame * Pos);
                                    v843.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    v843.HumanoidRootPart.Transparency = 1;
                                    v843.Humanoid.JumpPower = 0;
                                    v843.Humanoid.WalkSpeed = 0;
                                    v843.HumanoidRootPart.CanCollide = false;
                                    FarmPos = v843.HumanoidRootPart.CFrame;
                                    MonFarm = v843.Name;
                                    AttackNoCoolDown();
                                end
                            until not AutoFarmMasDevilFruit or (not MasteryType == "Near Mobs") or not v843.Parent or (v843.Humanoid.Health == 0)
                            bringmob = false;
                            _G.UseSkill = false;
                        end
                    end
                end
            end);
        end
    end
end);
if Sea3 then
    local v484 = Tabs.Main:AddSection("Xương");
    local v485 = Tabs.Main:AddParagraph({
        Title = "Xương Trạng Thái",
        Content = ""
    });
    spawn(function()
        pcall(function()
            while wait() do
                local v768 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check");
                v485:SetDesc("Mày Có: " .. tostring(v768) .. " Xương");
            end
        end);
    end);
    local v486 = Tabs.Main:AddToggle("ToggleBone", {
        Title = "Cày Xương",
        Description = "",
        Default = false
    });
    v486:OnChanged(function(v571)
        _G.AutoBone = v571;
        if (v571 == false) then
            wait();
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame);
            wait();
        end
    end);
    Options.ToggleBone:SetValue(false);
    local v487 = CFrame.new(- 9515.75, 174.8521728515625, 6079.40625);
    spawn(function()
        while wait() do
            if _G.AutoBone then
                pcall(function()
                    local v894 = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text;
                    if not string.find(v894, "Demonic Soul") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest");
                    end
                    if (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false) then
                        Tween(v487);
                        if ((v487.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3) then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "HauntedQuest2", 1);
                        end
                    elseif (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true) then
                        if (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy")) then
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if (v1662:FindFirstChild("HumanoidRootPart") and v1662:FindFirstChild("Humanoid") and (v1662.Humanoid.Health > 0)) then
                                    if ((v1662.Name == "Reborn Skeleton") or (v1662.Name == "Living Zombie") or (v1662.Name == "Demonic Soul") or (v1662.Name == "Posessed Mummy")) then
                                        if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Demonic Soul") then
                                            repeat
                                                wait(_G.Fast_Delay);
                                                AttackNoCoolDown();
                                                AutoHaki();
                                                bringmob = true;
                                                EquipTool(SelectWeapon);
                                                Tween(v1662.HumanoidRootPart.CFrame * Pos);
                                                v1662.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                                v1662.HumanoidRootPart.Transparency = 1;
                                                v1662.Humanoid.JumpPower = 0;
                                                v1662.Humanoid.WalkSpeed = 0;
                                                v1662.HumanoidRootPart.CanCollide = false;
                                                FarmPos = v1662.HumanoidRootPart.CFrame;
                                                MonFarm = v1662.Name;
                                            until not _G.AutoBone or (v1662.Humanoid.Health <= 0) or not v1662.Parent or (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false)
                                        else
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest");
                                            bringmob = false;
                                        end
                                    end
                                end
                            end
                        else
                        end
                    end
                end);
            end
        end
    end);
    local v488 = CFrame.new(- 9515.75, 174.8521728515625, 6079.40625);
    spawn(function()
        while wait() do
            if _G.AutoBoneNoQuest then
                pcall(function()
                    Tween(v488);
                    if ((v488.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3) then
                    end
                    if (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy")) then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1437:FindFirstChild("HumanoidRootPart") and v1437:FindFirstChild("Humanoid") and (v1437.Humanoid.Health > 0)) then
                                if ((v1437.Name == "Reborn Skeleton") or (v1437.Name == "Living Zombie") or (v1437.Name == "Demonic Soul") or (v1437.Name == "Posessed Mummy")) then
                                    repeat
                                        wait(_G.Fast_Delay);
                                        AttackNoCoolDown();
                                        AutoHaki();
                                        bringmob = true;
                                        EquipTool(SelectWeapon);
                                        Tween(v1437.HumanoidRootPart.CFrame * Pos);
                                        v1437.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        v1437.HumanoidRootPart.Transparency = 1;
                                        v1437.Humanoid.JumpPower = 0;
                                        v1437.Humanoid.WalkSpeed = 0;
                                        v1437.HumanoidRootPart.CanCollide = false;
                                        FarmPos = v1437.HumanoidRootPart.CFrame;
                                        MonFarm = v1437.Name;
                                    until not _G.AutoBoneNoQuest or (v1437.Humanoid.Health <= 0) or not v1437.Parent
                                end
                            end
                        end
                    end
                end);
            end
        end
    end);
    Tabs.Main:AddButton({
        Title = "Cầu Nguyện",
        Description = "",
        Callback = function()
            local v572 = {
                [1] = "gravestoneEvent",
                [2] = 1
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v572));
        end
    });
    Tabs.Main:AddButton({
        Title = "Thử Vận May",
        Description = "",
        Callback = function()
            local v573 = {
                [1] = "gravestoneEvent",
                [2] = 2
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v573));
        end
    });
    local v489 = Tabs.Main:AddToggle("ToggleRandomBone", {
        Title = "Random Xương",
        Description = "",
        Default = false
    });
    v489:OnChanged(function(v574)
        _G.AutoRandomBone = v574;
    end);
    Options.ToggleRandomBone:SetValue(false);
    spawn(function()
        while wait() do
            if _G.AutoRandomBone then
                local v844 = {
                    [1] = "Bones",
                    [2] = "Buy",
                    [3] = 1,
                    [4] = 1
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v844));
            end
        end
    end);
end
if Sea3 then
    local v490 = Tabs.Main:AddSection("Tư Lệnh Bánh");
    local v491 = Tabs.Main:AddParagraph({
        Title = "Trạng Thái Nó Ra",
        Content = ""
    });
    spawn(function()
        while wait() do
            pcall(function()
                if (string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88) then
                    v491:SetDesc("Còn: " .. string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 41) .. "");
                elseif (string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87) then
                    v491:SetDesc("Còn: " .. string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 40) .. "");
                elseif (string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86) then
                    v491:SetDesc("Còn: " .. string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 39) .. " ");
                else
                    v491:SetDesc("Tư Lệnh Bánh : ✅️");
                end
            end);
        end
    end);
    local v492 = Tabs.Main:AddToggle("ToggleCake", {
        Title = "Cày Tư Lệnh Bánh",
        Description = "",
        Default = false
    });
    local v493 = true;
    v492:OnChanged(function(v575)
        _G.CakePrince = v575;
        if v575 then
            if v493 then
                v493 = false;
                local v895 = CFrame.new(- 2003.932861328125, 380.4824523925781, - 12561.0185546875);
                Tween(v895);
            end
        else
            v493 = true;
            wait();
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame);
            wait();
        end
    end);
    Options.ToggleCake:SetValue(false);
    spawn(function()
        while wait() do
            if _G.CakePrince then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1439.Name == "Cake Prince") then
                                if (v1439:FindFirstChild("Humanoid") and v1439:FindFirstChild("HumanoidRootPart") and (v1439.Humanoid.Health > 0)) then
                                    repeat
                                        task.wait(_G.Fast_Delay);
                                        AutoHaki();
                                        EquipTool(SelectWeapon);
                                        v1439.HumanoidRootPart.CanCollide = false;
                                        v1439.Humanoid.WalkSpeed = 0;
                                        v1439.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        Tween(v1439.HumanoidRootPart.CFrame * Pos);
                                        AttackNoCoolDown();
                                    until not _G.CakePrince or not v1439.Parent or (v1439.Humanoid.Health <= 0)
                                end
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                    elseif (game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 1) then
                        if (game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker")) then
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if ((v1755.Name == "Cookie Crafter") or (v1755.Name == "Cake Guard") or (v1755.Name == "Baking Staff") or (v1755.Name == "Head Baker")) then
                                    if (v1755:FindFirstChild("Humanoid") and v1755:FindFirstChild("HumanoidRootPart") and (v1755.Humanoid.Health > 0)) then
                                        repeat
                                            task.wait(_G.Fast_Delay);
                                            AutoHaki();
                                            bringmob = true;
                                            EquipTool(SelectWeapon);
                                            v1755.HumanoidRootPart.CanCollide = false;
                                            v1755.Humanoid.WalkSpeed = 0;
                                            v1755.Head.CanCollide = false;
                                            v1755.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                            FarmPos = v1755.HumanoidRootPart.CFrame;
                                            MonFarm = v1755.Name;
                                            Tween(v1755.HumanoidRootPart.CFrame * Pos);
                                            AttackNoCoolDown();
                                        until not _G.CakePrince or not v1755.Parent or (v1755.Humanoid.Health <= 0) or (game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0) or game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]")
                                        bringmob = false;
                                    end
                                end
                            end
                        end
                    end
                end);
            end
        end
    end);
    local v494 = Tabs.Main:AddToggle("ToggleDoughKing", {
        Title = "Đấm Vua Bột",
        Description = "",
        Default = false
    });
    v494:OnChanged(function(v576)
        _G.DoughKing = v576;
        if (v576 == false) then
            wait();
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame);
            wait();
        end
    end);
    Options.ToggleDoughKing:SetValue(false);
    spawn(function()
        while wait() do
            if _G.DoughKing then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1441.Name == "Dough King") then
                                if (v1441:FindFirstChild("Humanoid") and v1441:FindFirstChild("HumanoidRootPart") and (v1441.Humanoid.Health > 0)) then
                                    repeat
                                        task.wait(_G.Fast_Delay);
                                        AutoHaki();
                                        EquipTool(SelectWeapon);
                                        v1441.HumanoidRootPart.CanCollide = false;
                                        v1441.Humanoid.WalkSpeed = 0;
                                        v1441.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        Tween(v1441.HumanoidRootPart.CFrame * Pos);
                                        AttackNoCoolDown();
                                    until not _G.DoughKing or not v1441.Parent or (v1441.Humanoid.Health <= 0)
                                end
                            end
                        end
                    end
                end);
            end
        end
    end);
    local v495 = Tabs.Main:AddToggle("ToggleSpawnCake", {
        Title = "Triệu Hồi Tư Lệnh Bánh",
        Description = "",
        Default = true
    });
    v495:OnChanged(function(v577)
        _G.SpawnCakePrince = v577;
    end);
    Options.ToggleSpawnCake:SetValue(true);
end
spawn(function()
    while wait() do
        if _G.SpawnCakePrince then
            local v681 = {
                [1] = "CakePrinceSpawner",
                [2] = true
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v681));
            local v681 = {
                [1] = "CakePrinceSpawner"
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v681));
        end
    end
end);
if Sea2 then
    local v496 = Tabs.Main:AddSection("Ectoplasm Farm");
    local v497 = Tabs.Main:AddToggle("ToggleVatChatKiDi", {
        Title = "Auto Farm Ectoplasm",
        Description = "",
        Default = false
    });
    v497:OnChanged(function(v578)
        _G.Ectoplasm = v578;
    end);
    Options.ToggleVatChatKiDi:SetValue(false);
    spawn(function()
        while wait() do
            pcall(function()
                if _G.Ectoplasm then
                    if (game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer")) then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if ((v1443.Name == "Ship Steward") or (v1443.Name == "Ship Engineer") or (v1443.Name == "Ship Deckhand") or ((v1443.Name == "Ship Officer") and v1443:FindFirstChild("Humanoid"))) then
                                if (v1443.Humanoid.Health > 0) then
                                    repeat
                                        wait(_G.Fast_Delay);
                                        AttackNoCoolDown();
                                        AutoHaki();
                                        bringmob = true;
                                        EquipTool(SelectWeapon);
                                        Tween(v1443.HumanoidRootPart.CFrame * Pos);
                                        v1443.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        v1443.HumanoidRootPart.Transparency = 1;
                                        v1443.Humanoid.JumpPower = 0;
                                        v1443.Humanoid.WalkSpeed = 0;
                                        v1443.HumanoidRootPart.CanCollide = false;
                                        FarmPos = v1443.HumanoidRootPart.CFrame;
                                        MonFarm = v1443.Name;
                                    until (_G.Ectoplasm == false) or not v1443.Parent or (v1443.Humanoid.Health == 0) or not game:GetService("Workspace").Enemies:FindFirstChild(v1443.Name)
                                    bringmob = false;
                                end
                            end
                        end
                    else
                        local v1334 = (Vector3.new(904.4072265625, 181.05767822266, 33341.38671875) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
                        if (v1334 > 20000) then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
                        end
                        Tween(CFrame.new(904.4072265625, 181.05767822266, 33341.38671875));
                    end
                end
            end);
        end
    end);
end
local BossSection = Tabs.Main:AddSection("Trùm");
if Sea1 then
    tableBoss = {
        "The Gorilla King",
        "Bobby",
        "Yeti",
        "Mob Leader",
        "Vice Admiral",
        "Warden",
        "Chief Warden",
        "Swan",
        "Magma Admiral",
        "Fishman Lord",
        "Wysper",
        "Thunder God",
        "Cyborg",
        "Saber Expert"
    };
elseif Sea2 then
    tableBoss = {
        "Diamond",
        "Jeremy",
        "Fajita",
        "Don Swan",
        "Smoke Admiral",
        "Cursed Captain",
        "Darkbeard",
        "Order",
        "Awakened Ice Admiral",
        "Tide Keeper"
    };
elseif Sea3 then
    tableBoss = {
        "Stone",
        "Hydra Leader",
        "Kilo Admiral",
        "Captain Elephant",
        "Beautiful Pirate",
        "rip_indra True Form",
        "Longma",
        "Soul Reaper",
        "Cake Queen"
    };
end
local BossDropdown = Tabs.Main:AddDropdown("DropdownBoss", {
    Title = "Chọn Trùm",
    Description = "",
    Values = tableBoss,
    Multi = false,
    Default = 1
});
BossDropdown:SetValue(_G.SelectBoss);
BossDropdown:OnChanged(function(v253)
    _G.SelectBoss = v253;
end);
local BossStatus = Tabs.Main:AddParagraph({ Title = "Boss Status", Content = "Chưa chọn boss" })
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local bossName = _G.SelectBoss
            if not bossName or bossName == "" then
                BossStatus:SetDesc("Chưa chọn boss")
                return
            end
            local isAlive = false
            for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v.Name == bossName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    isAlive = true
                    break
                end
            end
            if not isAlive then
                local repBoss = game:GetService("ReplicatedStorage"):FindFirstChild(bossName)
                if repBoss and repBoss:FindFirstChild("Humanoid") and repBoss.Humanoid.Health > 0 then
                    isAlive = true
                end
            end
            if isAlive then
                BossStatus:SetDesc(bossName .. ": 🟢 - Đang Sống")
            else
                BossStatus:SetDesc(bossName .. ": 🔴 - Chờ Hồi Sinh")
            end
        end)
    end
end)
local AutoFarmBossToggle = Tabs.Main:AddToggle("ToggleAutoFarmBoss", {
    Title = "Đấm Trùm",
    Description = "",
    Default = false
});
AutoFarmBossToggle:OnChanged(function(v254)
    _G.AutoBoss = v254;
end);
Options.ToggleAutoFarmBoss:SetValue(false);
spawn(function()
    while wait() do
        if _G.AutoBoss then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1035.Name == _G.SelectBoss) then
                            if (v1035:FindFirstChild("Humanoid") and v1035:FindFirstChild("HumanoidRootPart") and (v1035.Humanoid.Health > 0)) then
                                repeat
                                    wait(_G.Fast_Delay);
                                    AttackNoCoolDown();
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    v1035.HumanoidRootPart.CanCollide = false;
                                    v1035.Humanoid.WalkSpeed = 0;
                                    v1035.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    Tween(v1035.HumanoidRootPart.CFrame * Pos);
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
                                until not _G.AutoBoss or not v1035.Parent or (v1035.Humanoid.Health <= 0)
                            end
                        end
                    end
                elseif game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame * CFrame.new(5, 10, 7));
                end
            end);
        end
    end
end);
local MaterialSection = Tabs.Main:AddSection("Nguyên Liệu");
if Sea1 then
    MaterialList = {
        "Scrap Metal",
        "Leather",
        "Angel Wings",
        "Magma Ore",
        "Fish Tail"
    };
elseif Sea2 then
    MaterialList = {
        "Scrap Metal",
        "Leather",
        "Radioactive Material",
        "Mystic Droplet",
        "Magma Ore",
        "Vampire Fang"
    };
elseif Sea3 then
    MaterialList = {
        "Scrap Metal",
        "Leather",
        "Demonic Wisp",
        "Conjured Cocoa",
        "Dragon Scale",
        "Gunpowder",
        "Fish Tail",
        "Mini Tusk",
        "Hydra Enforcer",
        "Venomous Assailant"
    };
end
local MaterialDropdown = Tabs.Main:AddDropdown("DropdownMaterial", {
    Title = "Chọn Nguyên Liệu",
    Description = "",
    Values = MaterialList,
    Multi = false,
    Default = 1
});
MaterialDropdown:SetValue(SelectMaterial);
MaterialDropdown:OnChanged(function(v255)
    SelectMaterial = v255;
end);
local MaterialToggle = Tabs.Main:AddToggle("ToggleMaterial", {
    Title = "Cày Nguyên Liệu",
    Description = "",
    Default = false
});
MaterialToggle:OnChanged(function(v256)
    _G.AutoMaterial = v256;
    if (v256 == false) then
        wait();
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame);
        wait();
    end
end);
Options.ToggleMaterial:SetValue(false);
spawn(function()
    while task.wait() do
        if _G.AutoMaterial then
            pcall(function()
                MaterialMon(SelectMaterial);
                Tween(MPos);
                if game:GetService("Workspace").Enemies:FindFirstChild(MMon) then
                    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                        if (v1037:FindFirstChild("Humanoid") and v1037:FindFirstChild("HumanoidRootPart") and (v1037.Humanoid.Health > 0)) then
                            if (v1037.Name == MMon) then
                                repeat
                                    wait(_G.Fast_Delay);
                                    AttackNoCoolDown();
                                    AutoHaki();
                                    bringmob = true;
                                    EquipTool(SelectWeapon);
                                    Tween(v1037.HumanoidRootPart.CFrame * Pos);
                                    v1037.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    v1037.HumanoidRootPart.Transparency = 1;
                                    v1037.Humanoid.JumpPower = 0;
                                    v1037.Humanoid.WalkSpeed = 0;
                                    v1037.HumanoidRootPart.CanCollide = false;
                                    FarmPos = v1037.HumanoidRootPart.CFrame;
                                    MonFarm = v1037.Name;
                                until not _G.AutoMaterial or not v1037.Parent or (v1037.Humanoid.Health <= 0)
                                bringmob = false;
                            end
                        end
                    end
                else
                    for v1038, v1039 in pairs(game:GetService("Workspace")['_WorldOrigin'].EnemySpawns:GetChildren()) do
                        if string.find(v1039.Name, Mon) then
                            if ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v1039.Position).Magnitude >= 10) then
                                Tween(v1039.HumanoidRootPart.CFrame * Pos);
                            end
                        end
                    end
                end
            end);
        end
    end
end);
if Sea3 then
    local v498 = Tabs.Sea:AddSection("Đảo Cáo");
    local v499 = Tabs.Sea:AddParagraph({
        Title = "Trạng Thái Đảo Cáo",
        Content = ""
    });
    function UpdateKitsune()
        if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
            v499:SetDesc("Đảo Cáo : 🟢");
        else
            v499:SetDesc("Đảo Cáo : 🔴");
        end
    end
    spawn(function()
        pcall(function()
            while wait() do
                UpdateKitsune();
            end
        end);
    end);
    local v500 = Tabs.Sea:AddToggle("ToggleEspKitsune", {
        Title = "Định Vị Đảo Cáo",
        Description = "",
        Default = false
    });
    v500:OnChanged(function(v579)
        KitsuneIslandEsp = v579;
        while KitsuneIslandEsp do
            wait();
            UpdateIslandKisuneESP();
        end
    end);
    Options.ToggleEspKitsune:SetValue(false);
    function UpdateIslandKisuneESP()
        for v682, v683 in pairs(game:GetService("Workspace")['_WorldOrigin'].Locations:GetChildren()) do
            pcall(function()
                if KitsuneIslandEsp then
                    if (v683.Name == "Kitsune Island") then
                        if not v683:FindFirstChild("NameEsp") then
                            local billboard = Instance.new("BillboardGui", v683);
                            v1518.Name = "NameEsp";
                            v1518.ExtentsOffset = Vector3.new(0, 1, 0);
                            v1518.Size = UDim2.new(1, 200, 1, 30);
                            v1518.Adornee = v683;
                            v1518.AlwaysOnTop = true;
                            local textLabel = Instance.new("TextLabel", v1518);
                            v1524.Font = "Code";
                            v1524.FontSize = "Size14";
                            v1524.TextWrapped = true;
                            v1524.Size = UDim2.new(1, 0, 1, 0);
                            v1524.TextYAlignment = "Top";
                            v1524.BackgroundTransparency = 1;
                            v1524.TextStrokeTransparency = 0.5;
                            v1524.TextColor3 = Color3.fromRGB(80, 245, 245);
                        else
                            v683['NameEsp'].TextLabel.Text = v683.Name .. "   \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v683.Position).Magnitude / 3) .. " M" ;
                        end
                    end
                elseif v683:FindFirstChild("NameEsp") then
                    v683:FindFirstChild("NameEsp"):Destroy();
                end
            end);
        end
    end
    local v501 = Tabs.Sea:AddToggle("ToggleTPKitsune", {
        Title = "Bay Vô Đảo Cáo",
        Description = "",
        Default = false
    });
    v501:OnChanged(function(v580)
        _G.TweenToKitsune = v580;
    end);
    Options.ToggleTPKitsune:SetValue(false);
    spawn(function()
        local v581;
        while not v581 do
            v581 = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland");
            wait();
        end
        while wait() do
            if _G.TweenToKitsune then
                local v845 = v581:FindFirstChild("ShrineActive");
                if v845 then
                    for v1335, v1336 in pairs(v845:GetDescendants()) do
                        if (v1336:IsA("BasePart") and v1336.Name:find("NeonShrinePart")) then
                            Tween(v1336.CFrame);
                        end
                    end
                end
            end
        end
    end);
    local v502 = Tabs.Sea:AddToggle("ToggleCollectAzure", {
        Title = "Lụm Linh Hồn Xanh",
        Description = "",
        Default = false
    });
    v502:OnChanged(function(v582)
        _G.CollectAzure = v582;
    end);
    Options.ToggleCollectAzure:SetValue(false);
    spawn(function()
        while wait() do
            if _G.CollectAzure then
                pcall(function()
                    if game:GetService("Workspace"):FindFirstChild("AttachedAzureEmber") then
                        Tween(game:GetService("Workspace"):WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame);
                    end
                end);
            end
        end
    end);
end
Tabs.Sea:AddButton({
    Title = "Đổi Linh Hồn Xanh",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/KitsuneStatuePray"):InvokeServer();
    end
});
if Sea3 then
    local v503 = Tabs.Sea:AddSection("Biển");
    local v504 = game:GetService("Players");
    local v505 = game:GetService("RunService");
    local v506 = game:GetService("VirtualInputManager");
    local v507 = game:GetService("Workspace");
    local v508 = 350;
    local v509 = Tabs.Sea:AddSlider("SliderSpeedBoat", {
        Title = "Tốc Độ Thuyền",
        Description = "",
        Default = v508,
        Min = 0,
        Max = 350,
        Rounding = 1,
        Callback = function(v583)
            v508 = v583;
        end
    });
    v509:SetValue(v508);
    local v510 = Tabs.Sea:AddToggle("AutoFindPrehistoric", {
        Title = "Tìm Đảo Dung Nham",
        Description = "",
        Default = false
    });
    Options.AutoFindPrehistoric:SetValue(false);
    v510:OnChanged(function(v584)
        _G.AutoFindPrehistoric = v584;
    end);
    local v511 = {};
    local v512 = false;
    local v513 = false;
    v505.RenderStepped:Connect(function()
        if not _G.AutoFindPrehistoric then
            v513 = false;
            return;
        end
        local v585 = v504.LocalPlayer;
        local v586 = v585.Character;
        if (not v586 or not v586:FindFirstChild("Humanoid")) then
            return;
        end
        local function v587()
            if v512 then
                return;
            end
            v512 = true;
            for v769, v770 in pairs(v511) do
                if (v770 and v770.Parent and (v770.Name == "VehicleSeat") and not v770.Occupant) then
                    Tween2(v770.CFrame);
                    break;
                end
            end
            v512 = false;
        end
        local v588 = v586.Humanoid;
        local v589 = false;
        local v590 = nil;
        for v684, v685 in pairs(v507.Boats:GetChildren()) do
            local v686 = v685:FindFirstChild("VehicleSeat");
            if (v686 and (v686.Occupant == v588)) then
                v589 = true;
                v590 = v686;
                v511[v685.Name] = v686;
            elseif (v686 and (v686.Occupant == nil)) then
                v587();
            end
        end
        if not v589 then
            return;
        end
        v590.MaxSpeed = v508;
        v590.CFrame = CFrame.new(Vector3.new(v590.Position.X, v590.Position.Y, v590.Position.Z)) * v590.CFrame.Rotation ;
        v506:SendKeyEvent(true, "W", false, game);
        for v687, v688 in pairs(v507.Boats:GetDescendants()) do
            if v688:IsA("BasePart") then
                v688.CanCollide = false;
            end
        end
        for v689, v690 in pairs(v586:GetDescendants()) do
            if v690:IsA("BasePart") then
                v690.CanCollide = false;
            end
        end
        local v593 = {
            "ShipwreckIsland",
            "SandIsland",
            "TreeIsland",
            "TinyIsland",
            "MysticIsland",
            "KitsuneIsland",
            "FrozenDimension"
        };
        for v691, v692 in ipairs(v593) do
            local v693 = v507.Map:FindFirstChild(v692);
            if (v693 and v693:IsA("Model")) then
                v693:Destroy();
            end
        end
        local v594 = v507.Map:FindFirstChild("PrehistoricIsland");
        if v594 then
            v506:SendKeyEvent(false, "W", false, game);
            _G.AutoFindPrehistoric = false;
            if not v513 then
                Fluent:Notify({
                    Title = "Min Gaming",
                    Content = "Đảo Dung Nham Tìm Thấy",
                    Duration = 10
                });
                v513 = true;
            end
            return;
        end
    end);
    local v514 = Tabs.Sea:AddToggle("AutoFindMirage", {
        Title = "Tìm Đảo Bí Ẩn",
        Description = "",
        Default = false
    });
    Options.AutoFindMirage:SetValue(false);
    v514:OnChanged(function(v595)
        _G.AutoFindMirage = v595;
    end);
    local v511 = {};
    local v512 = false;
    local v513 = false;
    v505.RenderStepped:Connect(function()
        if not _G.AutoFindMirage then
            v513 = false;
            return;
        end
        local v596 = v504.LocalPlayer;
        local v597 = v596.Character;
        if (not v597 or not v597:FindFirstChild("Humanoid")) then
            return;
        end
        local function v598()
            if v512 then
                return;
            end
            v512 = true;
            for v771, v772 in pairs(v511) do
                if (v772 and v772.Parent and (v772.Name == "VehicleSeat") and not v772.Occupant) then
                    Tween2(v772.CFrame);
                    break;
                end
            end
            v512 = false;
        end
        local v599 = v597.Humanoid;
        local v600 = false;
        local v601 = nil;
        for v694, v695 in pairs(v507.Boats:GetChildren()) do
            local v696 = v695:FindFirstChild("VehicleSeat");
            if (v696 and (v696.Occupant == v599)) then
                v600 = true;
                v601 = v696;
                v511[v695.Name] = v696;
            elseif (v696 and (v696.Occupant == nil)) then
                v598();
            end
        end
        if not v600 then
            return;
        end
        v601.MaxSpeed = v508;
        v601.CFrame = CFrame.new(Vector3.new(v601.Position.X, v601.Position.Y, v601.Position.Z)) * v601.CFrame.Rotation ;
        v506:SendKeyEvent(true, "W", false, game);
        for v697, v698 in pairs(v507.Boats:GetDescendants()) do
            if v698:IsA("BasePart") then
                v698.CanCollide = false;
            end
        end
        for v699, v700 in pairs(v597:GetDescendants()) do
            if v700:IsA("BasePart") then
                v700.CanCollide = false;
            end
        end
        local v604 = {
            "ShipwreckIsland",
            "SandIsland",
            "TreeIsland",
            "TinyIsland",
            "PrehistoricIsland",
            "KitsuneIsland",
            "FrozenDimension"
        };
        for v701, v702 in ipairs(v604) do
            local v703 = v507.Map:FindFirstChild(v702);
            if (v703 and v703:IsA("Model")) then
                v703:Destroy();
            end
        end
        local v605 = v507.Map:FindFirstChild("MysticIsland");
        if v605 then
            v506:SendKeyEvent(false, "W", false, game);
            _G.AutoFindMirage = false;
            if not v513 then
                Fluent:Notify({
                    Title = "Min Gaming",
                    Content = "Đảo Bí Ẩn Tìm Thấy",
                    Duration = 10
                });
                v513 = true;
            end
            return;
        end
    end);
    local v515 = Tabs.Sea:AddToggle("AutoFindFrozen", {
        Title = "Tìm Đảo Leviathan",
        Description = "Cần 5 Người Không Idk",
        Default = false
    });
    Options.AutoFindFrozen:SetValue(false);
    v515:OnChanged(function(v606)
        _G.AutoFindFrozen = v606;
    end);
    local v511 = {};
    local v512 = false;
    local v513 = false;
    v505.RenderStepped:Connect(function()
        if not _G.AutoFindFrozen then
            v513 = false;
            return;
        end
        local v607 = v504.LocalPlayer;
        local v608 = v607.Character;
        if (not v608 or not v608:FindFirstChild("Humanoid")) then
            return;
        end
        local function v609()
            if v512 then
                return;
            end
            v512 = true;
            for v773, v774 in pairs(v511) do
                if (v774 and v774.Parent and (v774.Name == "VehicleSeat") and not v774.Occupant) then
                    Tween2(v774.CFrame);
                    break;
                end
            end
            v512 = false;
        end
        local v610 = v608.Humanoid;
        local v611 = false;
        local v612 = nil;
        for v704, v705 in pairs(v507.Boats:GetChildren()) do
            local v706 = v705:FindFirstChild("VehicleSeat");
            if (v706 and (v706.Occupant == v610)) then
                v611 = true;
                v612 = v706;
                v511[v705.Name] = v706;
            elseif (v706 and (v706.Occupant == nil)) then
                v609();
            end
        end
        if not v611 then
            return;
        end
        v612.MaxSpeed = v508;
        v612.CFrame = CFrame.new(Vector3.new(v612.Position.X, v612.Position.Y, v612.Position.Z)) * v612.CFrame.Rotation ;
        v506:SendKeyEvent(true, "W", false, game);
        for v707, v708 in pairs(v507.Boats:GetDescendants()) do
            if v708:IsA("BasePart") then
                v708.CanCollide = false;
            end
        end
        for v709, v710 in pairs(v608:GetDescendants()) do
            if v710:IsA("BasePart") then
                v710.CanCollide = false;
            end
        end
        local v615 = {
            "ShipwreckIsland",
            "SandIsland",
            "TreeIsland",
            "TinyIsland",
            "MysticIsland",
            "KitsuneIsland",
            "PrehistoricIsland"
        };
        for v711, v712 in ipairs(v615) do
            local v713 = v507.Map:FindFirstChild(v712);
            if (v713 and v713:IsA("Model")) then
                v713:Destroy();
            end
        end
        local v616 = v507.Map:FindFirstChild("FrozenDimension");
        if v616 then
            v506:SendKeyEvent(false, "W", false, game);
            _G.AutoFindFrozen = false;
            if not v513 then
                Fluent:Notify({
                    Title = "Min Gaming",
                    Content = "Đảo Leviathan Tìm Thấy",
                    Duration = 10
                });
                v513 = true;
            end
            return;
        end
    end);
    local v516 = Tabs.Sea:AddToggle("AutoComeTiki", {
        Title = "Lái Thuyền Về Đảo Tiki",
        Description = "",
        Default = false
    });
    v516:OnChanged(function(v617)
        _G.AutoComeTiki = v617;
    end);
    v505.RenderStepped:Connect(function()
        if not _G.AutoComeTiki then
            return;
        end
        local v618 = v504.LocalPlayer;
        local v619 = v618.Character;
        if (not v619 or not v619:FindFirstChild("Humanoid")) then
            return;
        end
        local v620 = v619.Humanoid;
        local v621 = nil;
        for v714, v715 in pairs(v507.Boats:GetChildren()) do
            local v716 = v715:FindFirstChild("VehicleSeat");
            if (v716 and (v716.Occupant == v620)) then
                v621 = v716;
                break;
            end
        end
        if v621 then
            v621.MaxSpeed = v508;
            local v776 = CFrame.new(- 16217.7568359375, 9.126761436462402, 446.06536865234375);
            local v777 = v621.Position;
            local v778 = v776.Position;
            local v779 = (v778 - v777).unit;
            local v780 = v779 * v621.MaxSpeed * v505.RenderStepped:Wait() ;
            v621.CFrame = v621.CFrame + v780 ;
            local v782 = CFrame.new(v777, v778);
            v621.CFrame = CFrame.new(v621.Position, v778);
            if ((v621.Position - v778).magnitude < 120) then
                _G.AutoComeTiki = false;
                v506:SendKeyEvent(false, "W", false, game);
            end
        end
    end);
    local v517 = Tabs.Sea:AddToggle("AutoComeHydra", {
        Title = "Lái Thuyền Về Đảo Hydra",
        Description = "",
        Default = false
    });
    v517:OnChanged(function(v622)
        _G.AutoComeHydra = v622;
    end);
    v505.RenderStepped:Connect(function()
        if not _G.AutoComeHydra then
            return;
        end
        local v623 = v504.LocalPlayer;
        local v624 = v623.Character;
        if (not v624 or not v624:FindFirstChild("Humanoid")) then
            return;
        end
        local v625 = v624.Humanoid;
        local v626 = nil;
        for v717, v718 in pairs(v507.Boats:GetChildren()) do
            local v719 = v718:FindFirstChild("VehicleSeat");
            if (v719 and (v719.Occupant == v625)) then
                v626 = v719;
                break;
            end
        end
        if v626 then
            v626.MaxSpeed = v508;
            local v784 = CFrame.new(5193.9375, - 0.04690289497375488, 1631.578369140625);
            local v785 = v626.Position;
            local v786 = v784.Position;
            local v787 = (v786 - v785).unit;
            local v788 = v787 * v626.MaxSpeed * v505.RenderStepped:Wait() ;
            v626.CFrame = v626.CFrame + v788 ;
            local v790 = CFrame.new(v785, v786);
            v626.CFrame = CFrame.new(v626.Position, v786);
            if ((v626.Position - v786).magnitude < 120) then
                _G.AutoComeHydra = false;
                v506:SendKeyEvent(false, "W", false, game);
            end
        end
    end);
    Tabs.Sea:AddButton({
        Title = "Bay Đến Khu Vực Săn",
        Description = "",
        Callback = function()
            Tween2(CFrame.new(- 16917.154296875, 7.757596015930176, 511.8203125));
        end
    });
    local v511 = {};
    local v518 = {
        "Beast Hunter",
        "Sleigh",
        "Miracle",
        "The Sentinel",
        "Guardian",
        "Lantern",
        "Dinghy",
        "PirateSloop",
        "PirateBrigade",
        "PirateGrandBrigade",
        "MarineGrandBrigade",
        "MarineBrigade",
        "MarineSloop"
    };
    local v519 = Tabs.Sea:AddDropdown("DropdownBoat", {
        Title = "Chọn Thuyền",
        Description = "",
        Values = v518,
        Multi = false,
        Default = 1
    });
    v519:SetValue(selectedBoat);
    v519:OnChanged(function(v627)
        selectedBoat = v627;
    end);
    local function v520(v628)
        local v629 = {
            [1] = "BuyBoat",
            [2] = v628
        };
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v629));
        task.delay(2, function()
            for v791, v792 in pairs(v507.Boats:GetChildren()) do
                if (v792:IsA("Model") and (v792.Name == v628)) then
                    local v896 = v792:FindFirstChild("VehicleSeat");
                    if (v896 and not v896.Occupant) then
                        v511[v628] = v896;
                    end
                end
            end
        end);
    end
    local function v521()
        for v720, v721 in pairs(v511) do
            if (v721 and v721.Parent and (v721.Name == "VehicleSeat") and not v721.Occupant) then
                Tween2(v721.CFrame);
            end
        end
    end
    game:GetService("RunService").RenderStepped:Connect(function()
        for v722, v723 in pairs(v511) do
            if (v723 and v723.Parent and (v723.Name == "VehicleSeat") and not v723.Occupant) then
                v511[v722] = v723;
            end
        end
    end);
    Tabs.Sea:AddButton({
        Title = "Mua Thuyền",
        Description = "",
        Callback = function()
            v520(selectedBoat);
        end
    });
    Tabs.Sea:AddButton({
        Title = "Bay Đến Thuyền",
        Description = "Duy Nhất Thuyền Bạn Mua Ở Chỗ Chọn",
        Callback = function()
            v521();
        end
    });
    local v522 = Tabs.Sea:AddToggle("ToggleTerrorshark", {
        Title = "Đấm Cá Mập",
        Description = "",
        Default = false
    });
    v522:OnChanged(function(v630)
        _G.AutoTerrorshark = v630;
    end);
    Options.ToggleTerrorshark:SetValue(false);
    spawn(function()
        while wait() do
            if _G.AutoTerrorshark then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1445.Name == "Terrorshark") then
                                if (v1445:FindFirstChild("Humanoid") and v1445:FindFirstChild("HumanoidRootPart") and (v1445.Humanoid.Health > 0)) then
                                    repeat
                                        wait(_G.Fast_Delay);
                                        AttackNoCoolDown();
                                        AutoHaki();
                                        EquipTool(SelectWeapon);
                                        v1445.HumanoidRootPart.CanCollide = false;
                                        v1445.Humanoid.WalkSpeed = 0;
                                        v1445.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        Tween(v1445.HumanoidRootPart.CFrame * Pos);
                                    until not _G.AutoTerrorshark or not v1445.Parent or (v1445.Humanoid.Health <= 0)
                                end
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark") then
                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                    else
                    end
                end);
            end
        end
    end);
    local v523 = Tabs.Sea:AddToggle("TogglePiranha", {
        Title = "Đấm Piranha",
        Description = "",
        Default = false
    });
    v523:OnChanged(function(v631)
        _G.farmpiranya = v631;
    end);
    Options.TogglePiranha:SetValue(false);
    spawn(function()
        while wait() do
            if _G.farmpiranya then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Piranha") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1447.Name == "Piranha") then
                                if (v1447:FindFirstChild("Humanoid") and v1447:FindFirstChild("HumanoidRootPart") and (v1447.Humanoid.Health > 0)) then
                                    repeat
                                        wait(_G.Fast_Delay);
                                        AttackNoCoolDown();
                                        AutoHaki();
                                        EquipTool(SelectWeapon);
                                        v1447.HumanoidRootPart.CanCollide = false;
                                        v1447.Humanoid.WalkSpeed = 0;
                                        v1447.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        Tween(v1447.HumanoidRootPart.CFrame * Pos);
                                    until not _G.farmpiranya or not v1447.Parent or (v1447.Humanoid.Health <= 0)
                                end
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Piranha") then
                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Piranha").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                    else
                    end
                end);
            end
        end
    end);
    local v524 = Tabs.Sea:AddToggle("ToggleShark", {
        Title = "Đấm Cá Con",
        Description = "",
        Default = false
    });
    v524:OnChanged(function(v632)
        _G.AutoShark = v632;
    end);
    Options.ToggleShark:SetValue(false);
    spawn(function()
        while wait() do
            if _G.AutoShark then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Shark") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1449.Name == "Shark") then
                                if (v1449:FindFirstChild("Humanoid") and v1449:FindFirstChild("HumanoidRootPart") and (v1449.Humanoid.Health > 0)) then
                                    repeat
                                        wait(_G.Fast_Delay);
                                        AttackNoCoolDown();
                                        AutoHaki();
                                        EquipTool(SelectWeapon);
                                        v1449.HumanoidRootPart.CanCollide = false;
                                        v1449.Humanoid.WalkSpeed = 0;
                                        v1449.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        Tween(v1449.HumanoidRootPart.CFrame * Pos);
                                        game.Players.LocalPlayer.Character.Humanoid.Sit = false;
                                    until not _G.AutoShark or not v1449.Parent or (v1449.Humanoid.Health <= 0)
                                end
                            end
                        end
                    else
                        Tween(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0, 1, 0));
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark") then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                        else
                        end
                    end
                end);
            end
        end
    end);
    local v525 = Tabs.Sea:AddToggle("ToggleFishCrew", {
        Title = "Đấm Tàu Cá",
        Description = "",
        Default = false
    });
    v525:OnChanged(function(v633)
        _G.AutoFishCrew = v633;
    end);
    Options.ToggleFishCrew:SetValue(false);
    spawn(function()
        while wait() do
            if _G.AutoFishCrew then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1451.Name == "Fish Crew Member") then
                                if (v1451:FindFirstChild("Humanoid") and v1451:FindFirstChild("HumanoidRootPart") and (v1451.Humanoid.Health > 0)) then
                                    repeat
                                        wait(_G.Fast_Delay);
                                        AttackNoCoolDown();
                                        AutoHaki();
                                        EquipTool(SelectWeapon);
                                        v1451.HumanoidRootPart.CanCollide = false;
                                        v1451.Humanoid.WalkSpeed = 0;
                                        v1451.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        Tween(v1451.HumanoidRootPart.CFrame * Pos);
                                        game.Players.LocalPlayer.Character.Humanoid.Sit = false;
                                    until not _G.AutoFishCrew or not v1451.Parent or (v1451.Humanoid.Health <= 0)
                                end
                            end
                        end
                    else
                        Tween(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0, 1, 0));
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Fish Crew Member") then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Fish Crew Member").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                        else
                        end
                    end
                end);
            end
        end
    end);
    local v526 = Tabs.Sea:AddToggle("ToggleShip", {
        Title = "Đấm Tàu",
        Description = "",
        Default = false
    });
    v526:OnChanged(function(v634)
        _G.Ship = v634;
    end);
    Options.ToggleShip:SetValue(false);
    function CheckPirateBoat()
        local v635 = {
            "PirateGrandBrigade",
            "PirateBrigade"
        };
        for v724, v725 in next, game:GetService("Workspace").Enemies:GetChildren() do
            if (table.find(v635, v725.Name) and v725:FindFirstChild("Health") and (v725.Health.Value > 0)) then
                return v725;
            end
        end
    end
    spawn(function()
        while wait() do
            if _G.Ship then
                pcall(function()
                    if CheckPirateBoat() then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game);
                        wait(0.5);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game);
                        local v1338 = CheckPirateBoat();
                        repeat
                            wait();
                            spawn(Tween(v1338.Engine.CFrame * CFrame.new(0, - 20, 0)), 1);
                            AimBotSkillPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, - 5, 0) ;
                            Skillaimbot = true;
                            AutoSkill = false;
                        until not v1338 or not v1338.Parent or (v1338.Health.Value <= 0) or not CheckPirateBoat()
                        Skillaimbot = true;
                        AutoSkill = false;
                    end
                end);
            end
        end
    end);
    local v527 = Tabs.Sea:AddToggle("ToggleGhostShip", {
        Title = "Đấm Tàu Ma",
        Description = "",
        Default = false
    });
    v527:OnChanged(function(v636)
        _G.GhostShip = v636;
    end);
    Options.ToggleGhostShip:SetValue(false);
    function CheckPirateBoat()
        local v637 = {
            "FishBoat"
        };
        for v726, v727 in next, game:GetService("Workspace").Enemies:GetChildren() do
            if (table.find(v637, v727.Name) and v727:FindFirstChild("Health") and (v727.Health.Value > 0)) then
                return v727;
            end
        end
    end
    spawn(function()
        while wait() do
            pcall(function()
                if _G.bjirFishBoat then
                    if CheckPirateBoat() then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game);
                        wait();
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game);
                        local v1339 = CheckPirateBoat();
                        repeat
                            wait();
                            spawn(Tween(v1339.Engine.CFrame * CFrame.new(0, - 20, 0), 1));
                            AutoSkill = true;
                            Skillaimbot = true;
                            AimBotSkillPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, - 5, 0) ;
                        until v1339.Parent or (v1339.Health.Value <= 0) or not CheckPirateBoat()
                        AutoSkill = false;
                        Skillaimbot = false;
                    end
                end
            end);
        end
    end);
    spawn(function()
        while wait() do
            if _G.bjirFishBoat then
                pcall(function()
                    if CheckPirateBoat() then
                        AutoHaki();
                        game:GetService("VirtualUser"):CaptureController();
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672));
                        for v1452, v1453 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v1453:IsA("Tool") then
                                if (v1453.ToolTip == "Melee") then
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1453);
                                end
                            end
                        end
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "C", false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        for v1454, v1455 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v1455:IsA("Tool") then
                                if (v1455.ToolTip == "Blox Fruit") then
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1455);
                                end
                            end
                        end
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "V", false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "V", false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait();
                        for v1456, v1457 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v1457:IsA("Tool") then
                                if (v1457.ToolTip == "Sword") then
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1457);
                                end
                            end
                        end
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait();
                        for v1458, v1459 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v1459:IsA("Tool") then
                                if (v1459.ToolTip == "Gun") then
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1459);
                                end
                            end
                        end
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        wait(0.2);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                    end
                end);
            end
        end
    end);
    local v528 = Tabs.Main:AddSection("Elite");
    local v529 = Tabs.Main:AddParagraph({
        Title = "Trạng Thái Elite",
        Content = ""
    });
    spawn(function()
        while wait() do
            pcall(function()
                if (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) then
                    v529:SetDesc("Elite Boss: 🟢 | Killed:  " .. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress"));
                else
                    v529:SetDesc("Elite Boss: 🔴 | Killed: " .. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress"));
                end
            end);
        end
    end);
    local v530 = Tabs.Main:AddToggle("ToggleElite", {
        Title = "Đấm Elite",
        Description = "",
        Default = false
    });
    v530:OnChanged(function(v638)
        _G.AutoElite = v638;
    end);
    Options.ToggleElite:SetValue(false);
    spawn(function()
        while task.wait() do
            if _G.AutoElite then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter");
                    if (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true) then
                        if (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban")) then
                            if (game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) then
                                for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if (v1664:FindFirstChild("Humanoid") and v1664:FindFirstChild("HumanoidRootPart") and (v1664.Humanoid.Health > 0)) then
                                        if ((v1664.Name == "Diablo") or (v1664.Name == "Deandre") or (v1664.Name == "Urban")) then
                                            repeat
                                                wait(_G.Fast_Delay);
                                                AttackNoCoolDown();
                                                EquipTool(SelectWeapon);
                                                AutoHaki();
                                                Tween2(v1664.HumanoidRootPart.CFrame * Pos);
                                                v1664.Humanoid.WalkSpeed = 0;
                                                v1664.HumanoidRootPart.CanCollide = false;
                                                v1664.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                            until (_G.AutoElite == false) or (v1664.Humanoid.Health <= 0) or not v1664.Parent
                                        end
                                    end
                                end
                            elseif game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                                Tween2(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                            elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                                Tween2(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                            elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                                Tween2(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                            end
                        end
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter");
                    end
                end);
            end
        end
    end);
end
if Sea3 then
    local v531 = Tabs.Sea:AddSection("Đảo Bí Ẩn");
    local v532 = Tabs.Sea:AddParagraph({
        Title = "Trạng Thái",
        Content = ""
    });
    task.spawn(function()
        while task.wait() do
            pcall(function()
                local v793 = game:GetService("Lighting").Sky.MoonTextureId;
                if (v793 == "http://www.roblox.com/asset/?id=9709149431") then
                    FullMoonStatus = "100%";
                elseif (v793 == "http://www.roblox.com/asset/?id=9709149052") then
                    FullMoonStatus = "75%";
                elseif (v793 == "http://www.roblox.com/asset/?id=9709143733") then
                    FullMoonStatus = "50%";
                elseif (v793 == "http://www.roblox.com/asset/?id=9709150401") then
                    FullMoonStatus = "25%";
                elseif (v793 == "http://www.roblox.com/asset/?id=9709149680") then
                    FullMoonStatus = "15%";
                else
                    FullMoonStatus = "0%";
                end
            end);
        end
    end);
    task.spawn(function()
        while task.wait() do
            pcall(function()
                if game.Workspace.Map:FindFirstChild("MysticIsland") then
                    MirageStatus = "🟢";
                else
                    MirageStatus = "🔴";
                end
            end);
        end
    end);
    spawn(function()
        pcall(function()
            while wait() do
                v532:SetDesc("Đảo Bí Ẩn: " .. MirageStatus .. " | Trăng Tròn: " .. FullMoonStatus);
            end
        end);
    end);
    Tabs.Sea:AddButton({
        Title = "Bay Đến Chỗ Cao",
        Description = "",
        Callback = function()
            TweenToHighestPoint();
        end
    });
    function TweenToHighestPoint()
        local v639 = getHighestPoint();
        if v639 then
            Tween2(v639.CFrame * CFrame.new(0, 211.88, 0));
        end
    end
    function getHighestPoint()
        if not game.Workspace.Map:FindFirstChild("MysticIsland") then
            return nil;
        end
        for v728, v729 in pairs(game:GetService("Workspace").Map.MysticIsland:GetDescendants()) do
            if v729:IsA("MeshPart") then
                if (v729.MeshId == "rbxassetid://6745037796") then
                    return v729;
                end
            end
        end
    end
end
local v66 = Tabs.Sea:AddToggle("ToggleTpAdvanced", {
    Title = "Bay Đến Advanced Fruit Dealer",
    Description = "",
    Default = false
});
v66:OnChanged(function(v257)
    _G.AutoTpAdvanced = v257;
end);
spawn(function()
    while wait() do
        if _G.AutoTpAdvanced then
            local v730 = game.ReplicatedStorage.NPCs:FindFirstChild("Advanced Fruit Dealer");
            if (v730 and v730:IsA("Model")) then
                local v856 = v730.PrimaryPart and v730.PrimaryPart.Position ;
                if v856 then
                    Tween2(CFrame.new(v856));
                end
            end
        end
    end
end);
local v67 = Tabs.Sea:AddToggle("ToggleTweenGear", {
    Title = "Bay Đến Bánh Răng",
    Description = "",
    Default = false
});
v67:OnChanged(function(v258)
    _G.TweenToGear = v258;
end);
Options.ToggleTweenGear:SetValue(false);
spawn(function()
    pcall(function()
        while wait() do
            if _G.TweenToGear then
                if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
                    for v1040, v1041 in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do
                        if v1041:IsA("MeshPart") then
                            if (v1041.Material == Enum.Material.Neon) then
                                Tween2(v1041.CFrame);
                            end
                        end
                    end
                end
            end
        end
    end);
end);
local v68 = Tabs.Sea:AddToggle("Togglelockmoon", {
    Title = "Nhìn Trăng Và Dùng Tộc",
    Description = "",
    Default = false
});
v68:OnChanged(function(v259)
    _G.AutoLockMoon = v259;
end);
Options.Togglelockmoon:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoLockMoon then
                local v794 = game.Lighting:GetMoonDirection();
                local v795 = game.Workspace.CurrentCamera.CFrame.p + (v794 * 100) ;
                game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, v795);
            end
        end);
    end
end);
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoLockMoon then
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility");
            end
        end);
    end
end);
local v69 = Tabs.ITM:AddToggle("ToggleAutoSaber", {
    Title = "Saber",
    Description = "",
    Default = false
});
v69:OnChanged(function(v260)
    _G.Auto_Saber = v260;
end);
Options.ToggleAutoSaber:SetValue(false);
spawn(function()
    while task.wait() do
        if (_G.Auto_Saber and (game.Players.LocalPlayer.Data.Level.Value >= 200)) then
            pcall(function()
                if (game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 0) then
                    if (game:GetService("Workspace").Map.Jungle.QuestPlates.Door.Transparency == 0) then
                        if ((CFrame.new(- 1612.55884, 36.9774132, 148.719543, 0.37091279, 3.071715e-9, - 0.928667724, 3.970995e-8, 1, 1.9167935e-8, 0.928667724, - 4.398698e-8, 0.37091279).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100) then
                            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame);
                            wait(1);
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.CFrame;
                            wait(1);
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.CFrame;
                            wait(1);
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.CFrame;
                            wait(1);
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.CFrame;
                            wait(1);
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.CFrame;
                            wait(1);
                        else
                            Tween(CFrame.new(- 1612.55884, 36.9774132, 148.719543, 0.37091279, 3.071715e-9, - 0.928667724, 3.970995e-8, 1, 1.9167935e-8, 0.928667724, - 4.398698e-8, 0.37091279));
                        end
                    elseif (game:GetService("Workspace").Map.Desert.Burn.Part.Transparency == 0) then
                        if (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch")) then
                            EquipTool("Torch");
                            Tween(CFrame.new(1114.61475, 5.04679728, 4350.22803, - 0.648466587, - 1.2879909e-9, 0.761243105, - 5.706529e-10, 1, 1.2058454e-9, - 0.761243105, 3.4754488e-10, - 0.648466587));
                        else
                            Tween(CFrame.new(- 1610.00757, 11.5049858, 164.001587, 0.984807551, - 0.167722285, - 0.0449818149, 0.17364943, 0.951244235, 0.254912198, 0.00003423728, - 0.258850515, 0.965917408));
                        end
                    elseif (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") ~= 0) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup");
                        wait(0.5);
                        EquipTool("Cup");
                        wait(0.5);
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", game:GetService("Players").LocalPlayer.Character.Cup);
                        wait(0);
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan");
                    elseif (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == nil) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon");
                    elseif (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0) then
                        if (game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") or game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader")) then
                            Tween(CFrame.new(- 2967.59521, - 4.91089821, 5328.70703, 0.342208564, - 0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, - 0.939287126, 0.0184739735, 0.342634559));
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if (v1800.Name == "Mob Leader") then
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
                                        if (v1800:FindFirstChild("Humanoid") and v1800:FindFirstChild("HumanoidRootPart") and (v1800.Humanoid.Health > 0)) then
                                            repeat
                                                task.wait(_G.Fast_Delay);
                                                AutoHaki();
                                                EquipTool(SelectWeapon);
                                                v1800.HumanoidRootPart.CanCollide = false;
                                                v1800.Humanoid.WalkSpeed = 0;
                                                v1800.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                                Tween(v1800.HumanoidRootPart.CFrame * Pos);
                                                AttackNoCoolDown();
                                            until (v1800.Humanoid.Health <= 0) or not _G.Auto_Saber
                                        end
                                    end
                                    if game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader") then
                                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                                    end
                                end
                            end
                        end
                    elseif (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon");
                        wait(0.5);
                        EquipTool("Relic");
                        wait(0.5);
                        Tween(CFrame.new(- 1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.6690688e-9, 0.481375456, 2.53852e-8, 1, - 5.799956e-8, - 0.481375456, 6.3057264e-8, 0.876514494));
                    end
                elseif (game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert") or game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert")) then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1461:FindFirstChild("Humanoid") and v1461:FindFirstChild("HumanoidRootPart") and (v1461.Humanoid.Health > 0)) then
                            if (v1461.Name == "Saber Expert") then
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    EquipTool(SelectWeapon);
                                    Tween(v1461.HumanoidRootPart.CFrame * Pos);
                                    v1461.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    v1461.HumanoidRootPart.Transparency = 1;
                                    v1461.Humanoid.JumpPower = 0;
                                    v1461.Humanoid.WalkSpeed = 0;
                                    v1461.HumanoidRootPart.CanCollide = false;
                                    bringmob = true;
                                    FarmPos = v1461.HumanoidRootPart.CFrame;
                                    MonFarm = v1461.Name;
                                    AttackNoCoolDown();
                                until (v1461.Humanoid.Health <= 0) or not _G.Auto_Saber
                                bringmob = true;
                                if (v1461.Humanoid.Health <= 0) then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic");
                                end
                            end
                        end
                    end
                end
            end);
        end
    end
end);
local v70 = Tabs.ITM:AddToggle("ToggleAutoPoleV1", {
    Title = "Pole V1",
    Description = "",
    Default = false
});
v70:OnChanged(function(v261)
    _G.Auto_PoleV1 = v261;
end);
Options.ToggleAutoPoleV1:SetValue(false);
local v71 = CFrame.new(- 7748.0185546875, 5606.80615234375, - 2305.898681640625);
spawn(function()
    while wait() do
        if _G.Auto_PoleV1 then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God") then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1043.Name == "Thunder God") then
                            if (v1043:FindFirstChild("Humanoid") and v1043:FindFirstChild("HumanoidRootPart") and (v1043.Humanoid.Health > 0)) then
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    v1043.HumanoidRootPart.CanCollide = false;
                                    v1043.Humanoid.WalkSpeed = 0;
                                    v1043.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    Tween(v1043.HumanoidRootPart.CFrame * Pos);
                                    AttackNoCoolDown();
                                until not _G.Auto_PoleV1 or not v1043.Parent or (v1043.Humanoid.Health <= 0)
                            end
                        end
                    end
                elseif ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v71.Position).Magnitude < 1500) then
                    Tween(v71);
                end
                Tween(CFrame.new(- 7748.0185546875, 5606.80615234375, - 2305.898681640625));
                if game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                end
            end);
        end
    end
end);
local v72 = Tabs.ITM:AddToggle("ToggleAutoSaw", {
    Title = "Cưa Cá Mập",
    Description = "",
    Default = false
});
v72:OnChanged(function(v262)
    _G.Auto_Saw = v262;
end);
Options.ToggleAutoSaw:SetValue(false);
local v71 = CFrame.new(- 690.33081054688, 15.09425163269, 1582.2380371094);
spawn(function()
    while wait() do
        if _G.Auto_Saw then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("The Saw") then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1045.Name == "The Saw") then
                            if (v1045:FindFirstChild("Humanoid") and v1045:FindFirstChild("HumanoidRootPart") and (v1045.Humanoid.Health > 0)) then
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    v1045.HumanoidRootPart.CanCollide = false;
                                    v1045.Humanoid.WalkSpeed = 0;
                                    v1045.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    Tween(v1045.HumanoidRootPart.CFrame * Pos);
                                    AttackNoCoolDown();
                                until not _G.Auto_Saw or not v1045.Parent or (v1045.Humanoid.Health <= 0)
                            end
                        end
                    end
                elseif ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v71.Position).Magnitude < 1500) then
                    Tween(v71);
                end
                Tween(CFrame.new(- 690.33081054688, 15.09425163269, 1582.2380371094));
                if game:GetService("ReplicatedStorage"):FindFirstChild("The Saw") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("The Saw").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                end
            end);
        end
    end
end);
local v73 = Tabs.ITM:AddToggle("ToggleAutoWarden", {
    Title = "Kiếm Quản Ngục",
    Description = "",
    Default = false
});
v73:OnChanged(function(v263)
    _G.Auto_Warden = v263;
end);
Options.ToggleAutoWarden:SetValue(false);
local v74 = CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562);
spawn(function()
    while wait() do
        if _G.Auto_Warden then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Chief Warden") then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1047.Name == "Chief Warden") then
                            if (v1047:FindFirstChild("Humanoid") and v1047:FindFirstChild("HumanoidRootPart") and (v1047.Humanoid.Health > 0)) then
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    v1047.HumanoidRootPart.CanCollide = false;
                                    v1047.Humanoid.WalkSpeed = 0;
                                    v1047.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    Tween(v1047.HumanoidRootPart.CFrame * Pos);
                                    AttackNoCoolDown();
                                until not _G.Auto_Warden or not v1047.Parent or (v1047.Humanoid.Health <= 0)
                            end
                        end
                    end
                elseif ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v74.Position).Magnitude < 1500) then
                    Tween(v74);
                end
                Tween(CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562));
                if game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                end
            end);
        end
    end
end);
if Sea3 then
    local v533 = Tabs.ITM:AddToggle("ToggleHallow", {
        Title = "Lưỡi Hái",
        Description = "",
        Default = false
    });
    v533:OnChanged(function(v640)
        AutoHallowSycthe = v640;
    end);
    Options.ToggleHallow:SetValue(false);
    spawn(function()
        while wait() do
            if AutoHallowSycthe then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if string.find(v1463.Name, "Soul Reaper") then
                                repeat
                                    wait(_G.Fast_Delay);
                                    AttackNoCoolDown();
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    v1463.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    Tween(v1463.HumanoidRootPart.CFrame * Pos);
                                    v1463.HumanoidRootPart.Transparency = 1;
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge);
                                until (v1463.Humanoid.Health <= 0) or (AutoHallowSycthe == false)
                            end
                        end
                    elseif (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hallow Essence")) then
                        repeat
                            Tween(CFrame.new(- 8932.322265625, 146.83154296875, 6062.55078125));
                            wait();
                        until (CFrame.new(- 8932.322265625, 146.83154296875, 6062.55078125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8
                        wait();
                        EquipTool("Hallow Essence");
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") then
                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                    else
                    end
                end);
            end
        end
    end);
    spawn(function()
        while wait() do
            if AutoHallowSycthe then
                local v857 = {
                    [1] = "Bones",
                    [2] = "Buy",
                    [3] = 1,
                    [4] = 1
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v857));
            end
        end
    end);
    local v534 = Tabs.ITM:AddToggle("ToggleYama", {
        Title = "Yama",
        Description = "",
        Default = false
    });
    v534:OnChanged(function(v641)
        _G.AutoYama = v641;
    end);
    Options.ToggleYama:SetValue(false);
    spawn(function()
        while wait() do
            if _G.AutoYama then
                if (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30) then
                    repeat
                        wait();
                        fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector);
                    until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Yama") or not _G.AutoYama
                end
            end
        end
    end);
    local v535 = Tabs.ITM:AddToggle("ToggleTushita", {
        Title = "Tushita",
        Description = "",
        Default = false
    });
    v535:OnChanged(function(v642)
        AutoTushita = v642;
    end);
    Options.ToggleTushita:SetValue(false);
    spawn(function()
        while wait() do
            if AutoTushita then
                if game:GetService("Workspace").Enemies:FindFirstChild("Longma") then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if ((v1341.Name == ("Longma" or (v1341.Name == "Longma"))) and (v1341.Humanoid.Health > 0) and v1341:IsA("Model") and v1341:FindFirstChild("Humanoid") and v1341:FindFirstChild("HumanoidRootPart")) then
                            repeat
                                wait(_G.Fast_Delay);
                                AttackNoCoolDown();
                                AutoHaki();
                                if not game.Players.LocalPlayer.Character:FindFirstChild(SelectWeapon) then
                                    wait();
                                    EquipTool(SelectWeapon);
                                end
                                FarmPos = v1341.HumanoidRootPart.CFrame;
                                v1341.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                v1341.Humanoid.JumpPower = 0;
                                v1341.Humanoid.WalkSpeed = 0;
                                v1341.HumanoidRootPart.CanCollide = false;
                                v1341.Humanoid:ChangeState(11);
                                Tween(v1341.HumanoidRootPart.CFrame * Pos);
                            until not AutoTushita or not v1341.Parent or (v1341.Humanoid.Health <= 0)
                        end
                    end
                else
                    Tween(CFrame.new(- 10238.875976563, 389.7912902832, - 9549.7939453125));
                end
            end
        end
    end);
    local v536 = Tabs.ITM:AddToggle("ToggleHoly", {
        Title = "Đốt Đuốc",
        Description = "",
        Default = false
    });
    v536:OnChanged(function(v643)
        _G.Auto_Holy_Torch = v643;
    end);
    Options.ToggleHoly:SetValue(false);
    spawn(function()
        while wait() do
            if _G.Auto_Holy_Torch then
                pcall(function()
                    wait();
                    repeat
                        Tween(CFrame.new(- 10752, 417, - 9366));
                        wait();
                    until not _G.Auto_Holy_Torch or ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 10752, 417, - 9366)).Magnitude <= 10)
                    wait();
                    repeat
                        Tween(CFrame.new(- 11672, 334, - 9474));
                        wait();
                    until not _G.Auto_Holy_Torch or ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 11672, 334, - 9474)).Magnitude <= 10)
                    wait();
                    repeat
                        Tween(CFrame.new(- 12132, 521, - 10655));
                        wait();
                    until not _G.Auto_Holy_Torch or ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 12132, 521, - 10655)).Magnitude <= 10)
                    wait();
                    repeat
                        Tween(CFrame.new(- 13336, 486, - 6985));
                        wait();
                    until not _G.Auto_Holy_Torch or ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 13336, 486, - 6985)).Magnitude <= 10)
                    wait();
                    repeat
                        Tween(CFrame.new(- 13489, 332, - 7925));
                        wait();
                    until not _G.Auto_Holy_Torch or ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 13489, 332, - 7925)).Magnitude <= 10)
                end);
            end
        end
    end);
end
local v75 = Tabs.ITM:AddToggle("ToggleAutoCanvander", {
    Title = "Canvander",
    Description = "",
    Default = false
});
v75:OnChanged(function(v264)
    _G.Auto_Canvander = v264;
end);
Options.ToggleAutoCanvander:SetValue(false);
local v71 = CFrame.new(5311.07421875, 426.0243835449219, 165.12762451171875);
spawn(function()
    while wait() do
        if _G.Auto_Canvander then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate") then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1049.Name == "Beautiful Pirate") then
                            if (v1049:FindFirstChild("Humanoid") and v1049:FindFirstChild("HumanoidRootPart") and (v1049.Humanoid.Health > 0)) then
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    v1049.HumanoidRootPart.CanCollide = false;
                                    v1049.Humanoid.WalkSpeed = 0;
                                    v1049.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    Tween(v1049.HumanoidRootPart.CFrame * Pos);
                                    AttackNoCoolDown();
                                until not _G.Auto_Canvander or not v1049.Parent or (v1049.Humanoid.Health <= 0)
                            end
                        end
                    end
                elseif ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v71.Position).Magnitude < 1500) then
                    Tween(v71);
                end
                Tween(CFrame.new(5311.07421875, 426.0243835449219, 165.12762451171875));
                if game:GetService("ReplicatedStorage"):FindFirstChild("Beautiful Pirate") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Beautiful Pirate").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                end
            end);
        end
    end
end);
local v76 = Tabs.ITM:AddToggle("ToggleAutoMusketeerHat", {
    Title = "Mũ Lính Ngự Lâm",
    Description = "",
    Default = false
});
v76:OnChanged(function(v265)
    _G.Auto_MusketeerHat = v265;
end);
Options.ToggleAutoMusketeerHat:SetValue(false);
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.Auto_MusketeerHat then
                if ((game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800) and (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits == false)) then
                    if (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true)) then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate") then
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if (v1560.Name == "Forest Pirate") then
                                    repeat
                                        task.wait(_G.Fast_Delay);
                                        pcall(function()
                                            EquipTool(SelectWeapon);
                                            AutoHaki();
                                            v1560.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                            Tween(v1560.HumanoidRootPart.CFrame * Pos);
                                            v1560.HumanoidRootPart.CanCollide = false;
                                            AttackNoCoolDown();
                                            PosMon = v1560.HumanoidRootPart.CFrame;
                                            MonFarm = v1560.Name;
                                            bringmob = true;
                                        end);
                                    until (_G.Auto_MusketeerHat == false) or not v1560.Parent or (v1560.Humanoid.Health <= 0) or (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false)
                                    bringmob = false;
                                end
                            end
                        else
                            bringmob = false;
                            Tween(CFrame.new(- 13206.452148438, 425.89199829102, - 7964.5537109375));
                        end
                    else
                        Tween(CFrame.new(- 12443.8671875, 332.40396118164, - 7675.4892578125));
                        if ((Vector3.new(- 12443.8671875, 332.40396118164, - 7675.4892578125) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30) then
                            wait(1.5);
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1);
                        end
                    end
                elseif ((game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800) and (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss == false)) then
                    if (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true)) then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant") then
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if (v1666.Name == "Captain Elephant") then
                                    OldCFrameElephant = v1666.HumanoidRootPart.CFrame;
                                    repeat
                                        task.wait(_G.Fast_Delay);
                                        pcall(function()
                                            EquipTool(SelectWeapon);
                                            AutoHaki();
                                            v1666.HumanoidRootPart.CanCollide = false;
                                            v1666.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                            Tween(v1666.HumanoidRootPart.CFrame * Pos);
                                            v1666.HumanoidRootPart.CanCollide = false;
                                            v1666.HumanoidRootPart.CFrame = OldCFrameElephant;
                                            AttackNoCoolDown();
                                        end);
                                    until (_G.Auto_MusketeerHat == false) or (v1666.Humanoid.Health <= 0) or not v1666.Parent or (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false)
                                end
                            end
                        else
                            Tween(CFrame.new(- 13374.889648438, 421.27752685547, - 8225.208984375));
                        end
                    else
                        Tween(CFrame.new(- 12443.8671875, 332.40396118164, - 7675.4892578125));
                        if ((CFrame.new(- 12443.8671875, 332.40396118164, - 7675.4892578125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4) then
                            wait(1.5);
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
                        end
                    end
                elseif ((game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800) and (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2)) then
                    Tween(CFrame.new(- 12512.138671875, 340.39279174805, - 9872.8203125));
                end
            end
        end
    end);
end);
local v77 = Tabs.ITM:AddToggle("ToggleAutoObservationV2", {
    Title = "Haki Quan Sát V2",
    Description = "",
    Default = false
});
v77:OnChanged(function(v266)
    _G.Auto_ObservationV2 = v266;
end);
Options.ToggleAutoObservationV2:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_ObservationV2 then
                if (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 3) then
                    _G.Auto_MusketeerHat = false;
                    if (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Banana") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Apple") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pineapple")) then
                        repeat
                            Tween(CFrame.new(- 12444.78515625, 332.40396118164, - 7673.1806640625));
                            wait();
                        until not _G.Auto_ObservationV2 or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 12444.78515625, 332.40396118164, - 7673.1806640625)).Magnitude <= 10)
                        wait(0.5);
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
                    elseif (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fruit Bowl")) then
                        repeat
                            Tween(CFrame.new(- 10920.125, 624.20275878906, - 10266.995117188));
                            wait();
                        until not _G.Auto_ObservationV2 or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 10920.125, 624.20275878906, - 10266.995117188)).Magnitude <= 10)
                        wait(0.5);
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2", "Start");
                        wait(1);
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2", "Buy");
                    else
                        for v1561, v1562 in pairs(game:GetService("Workspace"):GetDescendants()) do
                            if ((v1562.Name == "Apple") or (v1562.Name == "Banana") or (v1562.Name == "Pineapple")) then
                                v1562.Handle.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10) ;
                                wait();
                                firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v1562.Handle, 0);
                                wait();
                            end
                        end
                    end
                else
                    _G.Auto_MusketeerHat = true;
                end
            end
        end);
    end
end);
local v78 = Tabs.ITM:AddToggle("ToggleAutoRainbowHaki", {
    Title = "Haki 7 Màu",
    Description = "",
    Default = false
});
v78:OnChanged(function(v267)
    _G.Auto_RainbowHaki = v267;
end);
Options.ToggleAutoRainbowHaki:SetValue(false);
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.Auto_RainbowHaki then
                if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                    Tween(CFrame.new(- 11892.0703125, 930.57672119141, - 8760.1591796875));
                    if ((Vector3.new(- 11892.0703125, 930.57672119141, - 8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30) then
                        wait(1.5);
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet");
                    end
                elseif (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone")) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Stone") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1564.Name == "Stone") then
                                OldCFrameRainbow = v1564.HumanoidRootPart.CFrame;
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    EquipTool(SelectWeapon);
                                    Tween(v1564.HumanoidRootPart.CFrame * Pos);
                                    v1564.HumanoidRootPart.CanCollide = false;
                                    v1564.HumanoidRootPart.CFrame = OldCFrameRainbow;
                                    v1564.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    AttackNoCoolDown();
                                until not _G.Auto_RainbowHaki or (v1564.Humanoid.Health <= 0) or not v1564.Parent or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                            end
                        end
                    else
                        Tween(CFrame.new(- 1086.11621, 38.8425903, 6768.71436));
                    end
                elseif (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader")) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Hydra Leader") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1670.Name == "Hydra Leader") then
                                OldCFrameRainbow = v1670.HumanoidRootPart.CFrame;
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    EquipTool(SelectWeapon);
                                    Tween(v1670.HumanoidRootPart.CFrame * Pos);
                                    v1670.HumanoidRootPart.CanCollide = false;
                                    v1670.HumanoidRootPart.CFrame = OldCFrameRainbow;
                                    v1670.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    AttackNoCoolDown();
                                until not _G.Auto_RainbowHaki or (v1670.Humanoid.Health <= 0) or not v1670.Parent or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                            end
                        end
                    else
                        Tween(CFrame.new(5713.98877, 601.922974, 202.751251));
                    end
                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Kilo Admiral") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1763.Name == "Kilo Admiral") then
                                OldCFrameRainbow = v1763.HumanoidRootPart.CFrame;
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    EquipTool(SelectWeapon);
                                    Tween(v1763.HumanoidRootPart.CFrame * Pos);
                                    v1763.HumanoidRootPart.CanCollide = false;
                                    v1763.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    v1763.HumanoidRootPart.CFrame = OldCFrameRainbow;
                                    AttackNoCoolDown();
                                until not _G.Auto_RainbowHaki or (v1763.Humanoid.Health <= 0) or not v1763.Parent or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                            end
                        end
                    else
                        Tween(CFrame.new(2877.61743, 423.558685, - 7207.31006));
                    end
                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1775.Name == "Captain Elephant") then
                                OldCFrameRainbow = v1775.HumanoidRootPart.CFrame;
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    EquipTool(SelectWeapon);
                                    Tween(v1775.HumanoidRootPart.CFrame * Pos);
                                    v1775.HumanoidRootPart.CanCollide = false;
                                    v1775.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    v1775.HumanoidRootPart.CFrame = OldCFrameRainbow;
                                    AttackNoCoolDown();
                                until not _G.Auto_RainbowHaki or (v1775.Humanoid.Health <= 0) or not v1775.Parent or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                            end
                        end
                    else
                        Tween(CFrame.new(- 13485.0283, 331.709259, - 8012.4873));
                    end
                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1803.Name == "Beautiful Pirate") then
                                OldCFrameRainbow = v1803.HumanoidRootPart.CFrame;
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    EquipTool(SelectWeapon);
                                    Tween(v1803.HumanoidRootPart.CFrame * Pos);
                                    v1803.HumanoidRootPart.CanCollide = false;
                                    v1803.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    v1803.HumanoidRootPart.CFrame = OldCFrameRainbow;
                                    AttackNoCoolDown();
                                until not _G.Auto_RainbowHaki or (v1803.Humanoid.Health <= 0) or not v1803.Parent or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                            end
                        end
                    else
                        Tween(CFrame.new(5312.3598632813, 20.141201019287, - 10.158538818359));
                    end
                else
                    Tween(CFrame.new(- 11892.0703125, 930.57672119141, - 8760.1591796875));
                    if ((Vector3.new(- 11892.0703125, 930.57672119141, - 8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30) then
                        wait(1.5);
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet");
                    end
                end
            end
        end
    end);
end);
local v79 = Tabs.ITM:AddToggle("ToggleAutoSkullGuitar", {
    Title = "Skull Guitar",
    Description = "",
    Default = false
});
v79:OnChanged(function(v268)
    _G.Auto_SkullGuitar = v268;
end);
Options.ToggleAutoSkullGuitar:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_SkullGuitar then
                if (GetWeaponInventory("Skull Guitar") == false) then
                    if ((CFrame.new(- 9681.458984375, 6.139880657196045, 6341.3720703125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5000) then
                        if game:GetService("Workspace").NPCs:FindFirstChild("Skeleton Machine") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy", true);
                        elseif (game:GetService("Workspace").Map["Haunted Castle"].Candle1.Transparency == 0) then
                            if (game:GetService("Workspace").Map["Haunted Castle"].Placard1.Left.Part.Transparency == 0) then
                                Quest2 = true;
                                repeat
                                    wait();
                                    Tween(CFrame.new(- 8762.69140625, 176.84783935546875, 6171.3076171875));
                                until ((CFrame.new(- 8762.69140625, 176.84783935546875, 6171.3076171875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3) or not _G.Auto_SkullGuitar
                                wait(1);
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard7.Left.ClickDetector);
                                wait(1);
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard6.Left.ClickDetector);
                                wait(1);
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard5.Left.ClickDetector);
                                wait(1);
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard4.Right.ClickDetector);
                                wait(1);
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard3.Left.ClickDetector);
                                wait(1);
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard2.Right.ClickDetector);
                                wait(1);
                                fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard1.Right.ClickDetector);
                                wait(1);
                            elseif game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector") then
                                if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part1:FindFirstChild("ClickDetector") then
                                    Quest4 = true;
                                    repeat
                                        wait();
                                        Tween(CFrame.new(- 9553.5986328125, 65.62338256835938, 6041.58837890625));
                                    until ((CFrame.new(- 9553.5986328125, 65.62338256835938, 6041.58837890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3) or not _G.Auto_SkullGuitar
                                    wait(1);
                                    Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.CFrame);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector);
                                    wait(1);
                                    Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.CFrame);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector);
                                    wait(1);
                                    Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.CFrame);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector);
                                    wait(1);
                                    Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.CFrame);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector);
                                    wait(1);
                                    Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.CFrame);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector);
                                    wait(1);
                                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector);
                                else
                                    Quest3 = true;
                                end
                            else
                                if game:GetService("Workspace").NPCs:FindFirstChild("Ghost") then
                                    local v1798 = {
                                        [1] = "GuitarPuzzleProgress",
                                        [2] = "Ghost"
                                    };
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1798));
                                end
                                if game.Workspace.Enemies:FindFirstChild("Living Zombie") then
                                    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                                        if (v1805:FindFirstChild("HumanoidRootPart") and v1805:FindFirstChild("Humanoid") and (v1805.Humanoid.Health > 0)) then
                                            if (v1805.Name == "Living Zombie") then
                                                EquipTool(SelectWeapon);
                                                v1805.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                                v1805.HumanoidRootPart.Transparency = 1;
                                                v1805.Humanoid.JumpPower = 0;
                                                v1805.Humanoid.WalkSpeed = 0;
                                                v1805.HumanoidRootPart.CanCollide = false;
                                                v1805.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0) ;
                                                Tween(CFrame.new(- 10160.787109375, 138.6616973876953, 5955.03076171875));
                                                game:GetService("VirtualUser"):CaptureController();
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672));
                                            end
                                        end
                                    end
                                else
                                    Tween(CFrame.new(- 10160.787109375, 138.6616973876953, 5955.03076171875));
                                end
                            end
                        elseif string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2), "Error") then
                            Tween(CFrame.new(- 8653.2060546875, 140.98487854003906, 6160.033203125));
                        elseif string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2), "Nothing") then
                            Tween("Wait Full Moon");
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true);
                        end
                    else
                        Tween(CFrame.new(- 9681.458984375, 6.139880657196045, 6341.3720703125));
                    end
                end
            end
        end);
    end
end);
local v80 = Tabs.ITM:AddToggle("ToggleAutoBuddy", {
    Title = "Kiếm Buddy",
    Description = "",
    Default = false
});
v80:OnChanged(function(v269)
    _G.Auto_Buddy = v269;
end);
Options.ToggleAutoBuddy:SetValue(false);
local v81 = CFrame.new(- 731.2034301757812, 381.5658874511719, - 11198.4951171875);
spawn(function()
    while wait() do
        if _G.Auto_Buddy then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1051.Name == "Cake Queen") then
                            if (v1051:FindFirstChild("Humanoid") and v1051:FindFirstChild("HumanoidRootPart") and (v1051.Humanoid.Health > 0)) then
                                repeat
                                    task.wait(_G.Fast_Delay);
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    v1051.HumanoidRootPart.CanCollide = false;
                                    v1051.Humanoid.WalkSpeed = 0;
                                    v1051.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    Tween(v1051.HumanoidRootPart.CFrame * Pos);
                                    AttackNoCoolDown();
                                until not _G.Auto_Buddy or not v1051.Parent or (v1051.Humanoid.Health <= 0)
                            end
                        end
                    end
                elseif ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v81.Position).Magnitude < 1500) then
                    Tween(v81);
                end
                Tween(CFrame.new(- 731.2034301757812, 381.5658874511719, - 11198.4951171875));
                if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                end
            end);
        end
    end
end);
local v82 = Tabs.ITM:AddToggle("ToggleAutoDualKatana", {
    Title = "Song Kiếm",
    Description = "",
    Default = false
});
v82:OnChanged(function(v270)
    _G.Auto_DualKatana = v270;
end);
Options.ToggleAutoDualKatana:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_DualKatana then
                if (game.Players.LocalPlayer.Character:FindFirstChild("Tushita") or game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") or game.Players.LocalPlayer.Character:FindFirstChild("Yama") or game.Players.LocalPlayer.Backpack:FindFirstChild("Yama")) then
                    if (game.Players.LocalPlayer.Character:FindFirstChild("Tushita") or game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita")) then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") then
                            EquipTool("Tushita");
                        end
                    elseif (game.Players.LocalPlayer.Character:FindFirstChild("Yama") or game.Players.LocalPlayer.Backpack:FindFirstChild("Yama")) then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Yama") then
                            EquipTool("Yama");
                        end
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Tushita");
                end
            end
        end);
    end
end);
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_DualKatana then
                if (GetMaterial("Alucard Fragment") == 0) then
                    Auto_Quest_Yama_1 = true;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = false;
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
                elseif (GetMaterial("Alucard Fragment") == 1) then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = true;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = false;
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
                elseif (GetMaterial("Alucard Fragment") == 2) then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = true;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = false;
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
                elseif (GetMaterial("Alucard Fragment") == 3) then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = true;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = false;
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good");
                elseif (GetMaterial("Alucard Fragment") == 4) then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = true;
                    Auto_Quest_Tushita_3 = false;
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good");
                elseif (GetMaterial("Alucard Fragment") == 5) then
                    Auto_Quest_Yama_1 = false;
                    Auto_Quest_Yama_2 = false;
                    Auto_Quest_Yama_3 = false;
                    Auto_Quest_Tushita_1 = false;
                    Auto_Quest_Tushita_2 = false;
                    Auto_Quest_Tushita_3 = true;
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good");
                elseif (GetMaterial("Alucard Fragment") == 6) then
                    if (game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") or game:GetService("Workspace").ReplicatedStorage:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]")) then
                        Auto_Quest_Yama_1 = false;
                        Auto_Quest_Yama_2 = false;
                        Auto_Quest_Yama_3 = false;
                        Auto_Quest_Tushita_1 = false;
                        Auto_Quest_Tushita_2 = false;
                        Auto_Quest_Tushita_3 = false;
                        if (game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]")) then
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if ((v1843.Name == "Cursed Skeleton Boss") or (v1843.Name == "Cursed Skeleton")) then
                                    if (v1843.Humanoid.Health > 0) then
                                        EquipTool(Sword);
                                        Tween(v1843.HumanoidRootPart.CFrame * pos);
                                        v1843.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        v1843.HumanoidRootPart.Transparency = 1;
                                        v1843.Humanoid.JumpPower = 0;
                                        v1843.Humanoid.WalkSpeed = 0;
                                        v1843.HumanoidRootPart.CanCollide = false;
                                        bringmob = true;
                                        FarmPos = v1843.HumanoidRootPart.CFrame;
                                        MonFarm = v1843.Name;
                                        AttackNoCoolDown();
                                    end
                                end
                            end
                        end
                    elseif ((CFrame.new(- 12361.7060546875, 603.3547973632812, - 6550.5341796875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
                        wait(1);
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
                        wait(1);
                        Tween(CFrame.new(- 12361.7060546875, 603.3547973632812, - 6550.5341796875));
                        wait(1.5);
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game);
                        wait(1.5);
                        Tween(CFrame.new(- 12253.5419921875, 598.8999633789062, - 6546.8388671875));
                    else
                        Tween(CFrame.new(- 12361.7060546875, 603.3547973632812, - 6550.5341796875));
                    end
                end
            end
        end);
    end
end);
spawn(function()
    while wait() do
        if Auto_Quest_Yama_1 then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Mythological Pirate") then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1053.Name == "Mythological Pirate") then
                            repeat
                                wait();
                                Tween(v1053.HumanoidRootPart.CFrame * CFrame.new(0, 0, - 2));
                            until (_G.Auto_DualKatana == false) or (Auto_Quest_Yama_1 == false)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
                        end
                    end
                else
                    Tween(CFrame.new(- 13451.46484375, 543.712890625, - 6961.0029296875));
                end
            end);
        end
    end
end);
spawn(function()
    while wait() do
        pcall(function()
            if Auto_Quest_Yama_2 then
                for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v859:FindFirstChild("HazeESP") then
                        v859.HazeESP.Size = UDim2.new(50, 50, 50, 50);
                        v859.HazeESP.MaxDistance = "inf";
                    end
                end
                for v860, v861 in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                    if v861:FindFirstChild("HazeESP") then
                        v861.HazeESP.Size = UDim2.new(50, 50, 50, 50);
                        v861.HazeESP.MaxDistance = "inf";
                    end
                end
            end
        end);
    end
end);
spawn(function()
    while wait() do
        pcall(function()
            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if (Auto_Quest_Yama_2 and v732:FindFirstChild("HazeESP") and ((v732.HumanoidRootPart.Position - FarmPossEsp.Position).magnitude <= 300)) then
                    v732.HumanoidRootPart.CFrame = FarmPossEsp;
                    v732.HumanoidRootPart.CanCollide = false;
                    v732.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                    if not v732.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                        local v1058 = Instance.new("BodyVelocity", v732.HumanoidRootPart);
                        v1058.MaxForce = Vector3.new(1, 1, 1) * math.huge ;
                        v1058.Velocity = Vector3.new(0, 0, 0);
                    end
                end
            end
        end);
    end
end);
spawn(function()
    while wait() do
        if Auto_Quest_Yama_2 then
            pcall(function()
                for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v866:FindFirstChild("HazeESP") then
                        repeat
                            wait();
                            if ((v866.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000) then
                                Tween(v866.HumanoidRootPart.CFrame * Pos);
                            else
                                EquipTool(Sword);
                                Tween(v866.HumanoidRootPart.CFrame * Pos);
                                v866.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                v866.HumanoidRootPart.Transparency = 1;
                                v866.Humanoid.JumpPower = 0;
                                v866.Humanoid.WalkSpeed = 0;
                                v866.HumanoidRootPart.CanCollide = false;
                                FarmPos = v866.HumanoidRootPart.CFrame;
                                MonFarm = v866.Name;
                                AttackNoCoolDown();
                                if ((v866.Humanoid.Health <= 0) and v866.Humanoid:FindFirstChild("Animator")) then
                                    v866.Humanoid.Animator:Destroy();
                                end
                            end
                        until (_G.Auto_DualKatana == false) or (Auto_Quest_Yama_2 == false) or not v866.Parent or (v866.Humanoid.Health <= 0) or not v866:FindFirstChild("HazeESP")
                    else
                        for v1342, v1343 in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                            if v1343:FindFirstChild("HazeESP") then
                                if ((v1343.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000) then
                                    Tween(v1343.HumanoidRootPart.CFrameMon * CFrame.new(2, 20, 2));
                                else
                                    Tween(v1343.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
                                end
                            end
                        end
                    end
                end
            end);
        end
    end
end);
spawn(function()
    while wait() do
        if Auto_Quest_Yama_3 then
            pcall(function()
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") then
                    Tween(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame);
                elseif game:GetService("Workspace").Map:FindFirstChild("HellDimension") then
                    repeat
                        wait();
                        if (game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Hell's Messenger [Lv. 2200] [Boss]")) then
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if ((v1642.Name == "Cursed Skeleton") or (v1642.Name == "Cursed Skeleton") or (v1642.Name == "Hell's Messenger")) then
                                    if (v1642.Humanoid.Health > 0) then
                                        repeat
                                            wait();
                                            EquipTool(Sword);
                                            Tween(v1642.HumanoidRootPart.CFrame * Pos);
                                            v1642.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                            v1642.HumanoidRootPart.Transparency = 1;
                                            v1642.Humanoid.JumpPower = 0;
                                            v1642.Humanoid.WalkSpeed = 0;
                                            v1642.HumanoidRootPart.CanCollide = false;
                                            FarmPos = v1642.HumanoidRootPart.CFrame;
                                            MonFarm = v1642.Name;
                                            AttackNoCoolDown();
                                            if ((v1642.Humanoid.Health <= 0) and v1642.Humanoid:FindFirstChild("Animator")) then
                                                v1642.Humanoid.Animator:Destroy();
                                            end
                                        until (v1642.Humanoid.Health <= 0) or not v1642.Parent or (Auto_Quest_Yama_3 == false)
                                    end
                                end
                            end
                        else
                            wait(5);
                            Tween(game:GetService("Workspace").Map.HellDimension.Torch1.CFrame);
                            wait(1.5);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            Tweem(game:GetService("Workspace").Map.HellDimension.Torch2.CFrame);
                            wait(1.5);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            Tween(game:GetService("Workspace").Map.HellDimension.Torch3.CFrame);
                            wait(1.5);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            Tween(game:GetService("Workspace").Map.HellDimension.Exit.CFrame);
                        end
                    until (_G.Auto_DualKatana == false) or (Auto_Quest_Yama_3 == false) or (GetMaterial("Alucard Fragment") == 3)
                elseif (game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") or game.ReplicatedStorage:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]")) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1672.Name == "Soul Reaper") then
                                if (v1672.Humanoid.Health > 0) then
                                    repeat
                                        wait();
                                        Tween(v1672.HumanoidRootPart.CFrame * Pos);
                                    until (_G.Auto_DualKatana == false) or (Auto_Quest_Yama_3 == false) or game:GetService("Workspace").Map:FindFirstChild("HellDimension")
                                end
                            end
                        end
                    else
                        Tween(CFrame.new(- 9570.033203125, 315.9346923828125, 6726.89306640625));
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1);
                end
            end);
        end
    end
end);
spawn(function()
    while wait() do
        if Auto_Quest_Tushita_1 then
            Tween(CFrame.new(- 9546.990234375, 21.139892578125, 4686.1142578125));
            wait(5);
            Tween(CFrame.new(- 6120.0576171875, 16.455780029296875, - 2250.697265625));
            wait(5);
            Tween(CFrame.new(- 9533.2392578125, 7.254445552825928, - 8372.69921875));
        end
    end
end);
spawn(function()
    while wait() do
        if Auto_Quest_Tushita_2 then
            pcall(function()
                if ((CFrame.new(- 5539.3115234375, 313.800537109375, - 2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500) then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (Auto_Quest_Tushita_2 and v1062:FindFirstChild("HumanoidRootPart") and v1062:FindFirstChild("Humanoid") and (v1062.Humanoid.Health > 0)) then
                            if ((v1062.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000) then
                                repeat
                                    wait();
                                    EquipTool(Sword);
                                    Tween(v1062.HumanoidRootPart.CFrame * Pos);
                                    v1062.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    v1062.HumanoidRootPart.Transparency = 1;
                                    v1062.Humanoid.JumpPower = 0;
                                    v1062.Humanoid.WalkSpeed = 0;
                                    v1062.HumanoidRootPart.CanCollide = false;
                                    FarmPos = v1062.HumanoidRootPart.CFrame;
                                    MonFarm = v1062.Name;
                                    AttackNoCoolDown();
                                    if ((v1062.Humanoid.Health <= 0) and v1062.Humanoid:FindFirstChild("Animator")) then
                                        v1062.Humanoid.Animator:Destroy();
                                    end
                                until (v1062.Humanoid.Health <= 0) or not v1062.Parent or (Auto_Quest_Tushita_2 == false)
                            end
                        end
                    end
                else
                    Tween(CFrame.new(- 5545.1240234375, 313.800537109375, - 2976.616455078125));
                end
            end);
        end
    end
end);
spawn(function()
    while wait() do
        if Auto_Quest_Tushita_3 then
            pcall(function()
                if (game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") or game.ReplicatedStorage:FindFirstChild("Cake Queen [Lv. 2175] [Boss]")) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1465.Name == "Cake Queen") then
                                if (v1465.Humanoid.Health > 0) then
                                    repeat
                                        wait();
                                        EquipTool(Sword);
                                        Tween(v1465.HumanoidRootPart.CFrame * Pos);
                                        v1465.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                        v1465.HumanoidRootPart.Transparency = 1;
                                        v1465.Humanoid.JumpPower = 0;
                                        v1465.Humanoid.WalkSpeed = 0;
                                        v1465.HumanoidRootPart.CanCollide = false;
                                        FarmPos = v1465.HumanoidRootPart.CFrame;
                                        MonFarm = v1465.Name;
                                        AttackNoCoolDown();
                                        if ((v1465.Humanoid.Health <= 0) and v1465.Humanoid:FindFirstChild("Animator")) then
                                            v1465.Humanoid.Animator:Destroy();
                                        end
                                    until (_G.Auto_DualKatana == false) or (Auto_Quest_Tushita_3 == false) or game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension")
                                end
                            end
                        end
                    else
                        Tween(CFrame.new(- 709.3132934570312, 381.6005859375, - 11011.396484375));
                    end
                elseif game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") then
                    repeat
                        wait();
                        if (game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Heaven's Guardian [Lv. 2200] [Boss]")) then
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if ((v1651.Name == "Cursed Skeleton") or (v1651.Name == "Cursed Skeleton") or (v1651.Name == "Heaven's Guardian")) then
                                    if (v1651.Humanoid.Health > 0) then
                                        repeat
                                            wait();
                                            EquipTool(Sword);
                                            Tween(v1651.HumanoidRootPart.CFrame * Pos);
                                            v1651.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                            v1651.HumanoidRootPart.Transparency = 1;
                                            v1651.Humanoid.JumpPower = 0;
                                            v1651.Humanoid.WalkSpeed = 0;
                                            v1651.HumanoidRootPart.CanCollide = false;
                                            FarmPos = v1651.HumanoidRootPart.CFrame;
                                            MonFarm = v1651.Name;
                                            AttackNoCoolDown();
                                            if ((v1651.Humanoid.Health <= 0) and v1651.Humanoid:FindFirstChild("Animator")) then
                                                v1651.Humanoid.Animator:Destroy();
                                            end
                                        until (v1651.Humanoid.Health <= 0) or not v1651.Parent or (Auto_Quest_Tushita_3 == false)
                                    end
                                end
                            end
                        else
                            wait(5);
                            Tween(game:GetService("Workspace").Map.HeavenlyDimension.Torch1.CFrame);
                            wait(1.5);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            Tween(game:GetService("Workspace").Map.HeavenlyDimension.Torch2.CFrame);
                            wait(1.5);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            Tween(game:GetService("Workspace").Map.HeavenlyDimension.Torch3.CFrame);
                            wait(1.5);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            Tween(game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame);
                        end
                    until not _G.Auto_DualKatana or not Auto_Quest_Tushita_3 or (GetMaterial("Alucard Fragment") == 6)
                end
            end);
        end
    end
end);
if Sea2 then
    local v537 = Tabs.ITM:AddToggle("ToggleFactory", {
        Title = "Đấm Nhà Máy",
        Description = "",
        Default = false
    });
    v537:OnChanged(function(v644)
        _G.Factory = v644;
    end);
    Options.ToggleFactory:SetValue(false);
    spawn(function()
        while wait() do
            if _G.Factory then
                if game.Workspace.Enemies:FindFirstChild("Core") then
                    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                        if ((v1345.Name == "Core") and (v1345.Humanoid.Health > 0)) then
                            repeat
                                wait(_G.Fast_Delay);
                                AttackNoCoolDown();
                                repeat
                                    Tween(CFrame.new(448.46756, 199.356781, - 441.389252));
                                    wait();
                                until not _G.Factory or ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(448.46756, 199.356781, - 441.389252)).Magnitude <= 10)
                                EquipTool(SelectWeapon);
                                AutoHaki();
                                Tween(v1345.HumanoidRootPart.CFrame * Pos);
                                v1345.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                v1345.HumanoidRootPart.Transparency = 1;
                                v1345.Humanoid.JumpPower = 0;
                                v1345.Humanoid.WalkSpeed = 0;
                                v1345.HumanoidRootPart.CanCollide = false;
                                FarmPos = v1345.HumanoidRootPart.CFrame;
                                MonFarm = v1345.Name;
                            until not v1345.Parent or (v1345.Humanoid.Health <= 0) or (_G.Factory == false)
                        end
                    end
                elseif game.ReplicatedStorage:FindFirstChild("Core") then
                    repeat
                        Tween(CFrame.new(448.46756, 199.356781, - 441.389252));
                        wait();
                    until not _G.Factory or ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(448.46756, 199.356781, - 441.389252)).Magnitude <= 10)
                end
            end
        end
    end);
end
local v83 = Tabs.ITM:AddToggle("ToggleAutoFarmSwan", {
    Title = "Đấm Swan",
    Description = "",
    Default = false
});
v83:OnChanged(function(v271)
    _G.Auto_FarmSwan = v271;
end);
Options.ToggleAutoFarmSwan:SetValue(false);
spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoFarmSwan then
                if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan") then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if ((v1064.Name == "Don Swan") and (v1064.Humanoid.Health > 0) and v1064:IsA("Model") and v1064:FindFirstChild("Humanoid") and v1064:FindFirstChild("HumanoidRootPart")) then
                            repeat
                                task.wait();
                                pcall(function()
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    v1064.HumanoidRootPart.CanCollide = false;
                                    v1064.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                    Tween(v1064.HumanoidRootPart.CFrame * Pos);
                                    AttackNoCoolDown();
                                end);
                            until (_G.AutoFarmSwan == false) or (v1064.Humanoid.Health <= 0)
                        end
                    end
                else
                    repeat
                        task.wait();
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2284.912109375, 15.537666320801, 905.48291015625));
                    until ((CFrame.new(2284.912109375, 15.537666320801, 905.48291015625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4) or (_G.AutoFarmSwan == false)
                end
            end
        end
    end);
end);
local v84 = Tabs.ITM:AddToggle("ToggleAutoRengoku", {
    Title = "Rengoku",
    Description = "",
    Default = false
});
v84:OnChanged(function(v272)
    _G.Auto_Regoku = v272;
end);
Options.ToggleAutoRengoku:SetValue(false);
spawn(function()
    pcall(function()
        while wait() do
            if _G.Auto_Regoku then
                if (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hidden Key")) then
                    EquipTool("Hidden Key");
                    Tween(CFrame.new(6571.1201171875, 299.23028564453, - 6967.841796875));
                elseif (game:GetService("Workspace").Enemies:FindFirstChild("Snow Lurker") or game:GetService("Workspace").Enemies:FindFirstChild("Arctic Warrior")) then
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (((v1467.Name == "Snow Lurker") or (v1467.Name == "Arctic Warrior")) and (v1467.Humanoid.Health > 0)) then
                            repeat
                                task.wait(_G.Fast_Delay);
                                EquipTool(SelectWeapon);
                                AutoHaki();
                                v1467.HumanoidRootPart.CanCollide = false;
                                v1467.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                FarmPos = v1467.HumanoidRootPart.CFrame;
                                MonFarm = v1467.Name;
                                Tween(v1467.HumanoidRootPart.CFrame * Pos);
                                AttackNoCoolDown();
                                bringmob = true;
                            until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or (_G.Auto_Regoku == false) or not v1467.Parent or (v1467.Humanoid.Health <= 0)
                            bringmob = false;
                        end
                    end
                else
                    bringmob = false;
                    Tween(CFrame.new(5439.716796875, 84.420944213867, - 6715.1635742188));
                end
            end
        end
    end);
end);
if (Sea2 or Sea3) then
    local v538 = Tabs.ITM:AddToggle("ToggleHakiColor", {
        Title = "Mua Màu Haki",
        Description = "",
        Default = false
    });
    v538:OnChanged(function(v645)
        _G.Auto_Buy_Enchancement = v645;
    end);
    Options.ToggleHakiColor:SetValue(false);
    spawn(function()
        while wait() do
            if _G.Auto_Buy_Enchancement then
                local v867 = {
                    [1] = "ColorsDealer",
                    [2] = "2"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v867));
            end
        end
    end);
end
if Sea2 then
    local v539 = Tabs.Main:AddToggle("ToggleSwordLengend", {
        Title = "Mua Kiếm Huyền Thoại",
        Description = "",
        Default = false
    });
    v539:OnChanged(function(v646)
        _G.BuyLengendSword = v646;
    end);
    Options.ToggleSwordLengend:SetValue(false);
    spawn(function()
        while wait() do
            pcall(function()
                if (_G.BuyLengendSword or Triple_A) then
                    local v897 = {
                        [1] = "LegendarySwordDealer",
                        [2] = "2"
                    };
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v897));
                else
                    wait();
                end
            end);
        end
    end);
end
if Sea2 then
    local v540 = Tabs.Main:AddToggle("ToggleEvoRace", {
        Title = "Nâng Tộc V2",
        Description = "",
        Default = false
    });
    v540:OnChanged(function(v647)
        _G.AutoEvoRace = v647;
    end);
    Options.ToggleEvoRace:SetValue(false);
    spawn(function()
        pcall(function()
            while wait(0.1) do
                if _G.AutoEvoRace then
                    if not game:GetService("Players").LocalPlayer.Data.Race:FindFirstChild("Evolved") then
                        if (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 0) then
                            Tween(CFrame.new(- 2779.83521, 72.9661407, - 3574.02002, - 0.730484903, 6.390141e-8, - 0.68292886, 3.5996322e-8, 1, 5.5066703e-8, 0.68292886, 1.5642467e-8, - 0.730484903));
                            if ((Vector3.new(- 2779.83521, 72.9661407, - 3574.02002) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4) then
                                wait(1.3);
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "2");
                            end
                        elseif (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 1) then
                            pcall(function()
                                if (not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 1") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 1")) then
                                    Tween(game:GetService("Workspace").Flower1.CFrame);
                                elseif (not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 2") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 2")) then
                                    Tween(game:GetService("Workspace").Flower2.CFrame);
                                elseif (not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 3")) then
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Zombie") then
                                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                            if (v1835.Name == "Zombie") then
                                                repeat
                                                    task.wait(_G.Fast_Delay);
                                                    AutoHaki();
                                                    EquipTool(SelectWeapon);
                                                    Tween(v1835.HumanoidRootPart.CFrame * Pos);
                                                    v1835.HumanoidRootPart.CanCollide = false;
                                                    v1835.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
                                                    AttackNoCoolDown();
                                                    FarmPos = v1835.HumanoidRootPart.CFrame;
                                                    MonFarm = v1835.Name;
                                                    bringmob = true;
                                                until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") or not v1835.Parent or (v1835.Humanoid.Health <= 0) or (_G.AutoEvoRace == false)
                                                bringmob = false;
                                            end
                                        end
                                    else
                                        Tween(CFrame.new(- 5685.9233398438, 48.480125427246, - 853.23724365234));
                                    end
                                end
                            end);
                        elseif (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 2) then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3");
                        end
                    end
                end
            end
        end);
    end);
end
local v85 = Tabs.Setting:AddToggle("ToggleAutoT", {
    Title = "Bật Tộc V3",
    Description = "",
    Default = false
});
v85:OnChanged(function(v273)
    _G.AutoT = v273;
end);
Options.ToggleAutoT:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoT then
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility");
            end
        end);
    end
end);
local v86 = Tabs.Setting:AddToggle("ToggleAutoY", {
    Title = "Bật Tộc V4",
    Description = "",
    Default = false
});
v86:OnChanged(function(v274)
    _G.AutoY = v274;
end);
Options.ToggleAutoY:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoY then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game);
                wait();
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "Y", false, game);
            end
        end);
    end
end);
local v87 = Tabs.Setting:AddToggle("ToggleAutoKen", {
    Title = "Bật Haki Quan Sât",
    Description = "",
    Default = false
});
v87:OnChanged(function(v275)
    _G.AutoKen = v275;
    if v275 then
        game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true);
    else
        game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", false);
    end
end);
Options.ToggleAutoKen:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoKen then
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true);
            end
        end);
    end
end);
local v88 = Tabs.Setting:AddToggle("ToggleSaveSpawn", {
    Title = "Lưu Điểm Hồi Sinh",
    Description = "",
    Default = false
});
v88:OnChanged(function(v276)
    _G.SaveSpawn = v276;
    if v276 then
        local v648 = {
            [1] = "SetSpawnPoint"
        };
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v648));
    end
end);
Options.ToggleSaveSpawn:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.SaveSpawn then
                local v797 = {
                    [1] = "SetSpawnPoint"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v797));
            end
        end);
    end
end);
local v89 = require(game.ReplicatedStorage.Util.CameraShaker);
v89:Stop();
_G.FastAttack = true
_G.Fast_Delay = 0.5
_G.FastAttackInput = "0.5"
local FastToggle = Tabs.Setting:AddToggle("ToggleFastAttack", {
    Title = "Tốc Đánh",
    Description = "Tắt Thì Max Tốc Đánh",
    Default = true
})
FastToggle:OnChanged(function(Value)
    _G.FastAttack = Value
    if Value then
        local delay = tonumber(_G.FastAttackInput) or 0.5
        _G.Fast_Delay = math.clamp(delay, 0.05, 2)
    else
        _G.Fast_Delay = 1e-9
    end
end)
local FastInput = Tabs.Setting:AddInput("InputFastDelay", {
    Title = "Nhập Tốc Đánh",
    Description = "(0.05s -> 2s)",
    Default = "0.5",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        _G.FastAttackInput = Value
        if _G.FastAttack then
            local delay = tonumber(Value) or 0.5
            _G.Fast_Delay = math.clamp(delay, 0.05, 2)
        end
    end
})
local v90 = Tabs.Setting:AddToggle("ToggleBringMob", {
    Title = "Gom Quái",
    Description = "",
    Default = true
});
v90:OnChanged(function(v277)
    _G.BringMob = v277;
end);
Options.ToggleBringMob:SetValue(true);
spawn(function()
    while wait() do
        pcall(function()
            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if (_G.BringMob and bringmob) then
                    if ((v734.Name == MonFarm) and v734:FindFirstChild("Humanoid") and (v734.Humanoid.Health > 0)) then
                        if (v734.Name == "Factory Staff") then
                            if ((v734.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= 1000000000) then
                                v734.Head.CanCollide = false;
                                v734.HumanoidRootPart.CanCollide = false;
                                v734.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                v734.HumanoidRootPart.CFrame = FarmPos;
                                if v734.Humanoid:FindFirstChild("Animator") then
                                    v734.Humanoid.Animator:Destroy();
                                end
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge);
                            end
                        elseif (v734.Name == MonFarm) then
                            if ((v734.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= 1000000000) then
                                v734.HumanoidRootPart.CFrame = FarmPos;
                                v734.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                v734.HumanoidRootPart.Transparency = 1;
                                v734.Humanoid.JumpPower = 0;
                                v734.Humanoid.WalkSpeed = 0;
                                if v734.Humanoid:FindFirstChild("Animator") then
                                    v734.Humanoid.Animator:Destroy();
                                end
                                v734.HumanoidRootPart.CanCollide = false;
                                v734.Head.CanCollide = false;
                                v734.Humanoid:ChangeState(11);
                                v734.Humanoid:ChangeState(14);
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge);
                            end
                        end
                    end
                end
            end
        end);
    end
end);
local v91 = Tabs.Setting:AddToggle("ToggleRemoveNotify", {
    Title = "Xóa Thông Báo",
    Description = "",
    Default = false
});
v91:OnChanged(function(v278)
    RemoveNotify = v278;
end);
Options.ToggleRemoveNotify:SetValue(false);
spawn(function()
    while wait() do
        if RemoveNotify then
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false;
        else
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true;
        end
    end
end);
local v92 = Tabs.Setting:AddToggle("ToggleWhite", {
    Title = "Màn Hình Trắng",
    Description = "",
    Default = false
});
v92:OnChanged(function(v279)
    _G.WhiteScreen = v279;
    if (_G.WhiteScreen == true) then
        game:GetService("RunService"):Set3dRenderingEnabled(false);
    elseif (_G.WhiteScreen == false) then
        game:GetService("RunService"):Set3dRenderingEnabled(true);
    end
end);
Options.ToggleWhite:SetValue(false);
local v93 = Tabs.Setting:AddSection("Kĩ Năng Thông Thạo");
local v94 = Tabs.Setting:AddToggle("ToggleZ", {
    Title = "Kĩ Năng Z",
    Description = "",
    Default = true
});
v94:OnChanged(function(v280)
    SkillZ = v280;
end);
Options.ToggleZ:SetValue(true);
local v95 = Tabs.Setting:AddToggle("ToggleX", {
    Title = "Kĩ Năng X",
    Description = "",
    Default = true
});
v95:OnChanged(function(v281)
    SkillX = v281;
end);
Options.ToggleX:SetValue(true);
local v96 = Tabs.Setting:AddToggle("ToggleC", {
    Title = "Kĩ Năng C",
    Description = "",
    Default = true
});
v96:OnChanged(function(v282)
    SkillC = v282;
end);
Options.ToggleC:SetValue(true);
local v97 = Tabs.Setting:AddToggle("ToggleV", {
    Title = "Kĩ Năng V",
    Description = "",
    Default = true
});
v97:OnChanged(function(v283)
    SkillV = v283;
end);
Options.ToggleV:SetValue(true);
local v98 = Tabs.Setting:AddToggle("ToggleF", {
    Title = "Kĩ Năng F",
    Description = "",
    Default = false
});
v98:OnChanged(function(v284)
    SkillF = v284;
end);
Options.ToggleF:SetValue(true);
local v99 = Tabs.Status:AddParagraph({
    Title = "Thông Tin",
    Content = "━━━━━━━━━━━━━━━━━━━━━\n" .. "Tên : " .. game.Players.LocalPlayer.DisplayName .. " (@" .. game.Players.LocalPlayer.Name .. ")\n" .. "Cấp : " .. game:GetService("Players").LocalPlayer.Data.Level.Value .. "\n" .. "Tiền : " .. game:GetService("Players").LocalPlayer.Data.Beli.Value .. "\n" .. "Điểm F : " .. game:GetService("Players").LocalPlayer.Data.Fragments.Value .. "\n" .. "Tiền Truy Nã : " .. game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].Value .. "\n" .. "Máu: " .. game.Players.LocalPlayer.Character.Humanoid.Health .. "/" .. game.Players.LocalPlayer.Character.Humanoid.MaxHealth .. "\n" .. "Năng Lượng : " .. game.Players.LocalPlayer.Character.Energy.Value .. "/" .. game.Players.LocalPlayer.Character.Energy.MaxValue .. "\n" .. "Tộc : " .. game:GetService("Players").LocalPlayer.Data.Race.Value .. "\n" .. "Trái : " .. game:GetService("Players").LocalPlayer.Data.DevilFruit.Value .. "\n" .. "━━━━━━━━━━━━━━━━━━━━━"
});
local v100 = Tabs.Status:AddParagraph({
    Title = "Thời Gian",
    Content = ""
});
local function v101()
    local v285 = os.date("*t");
    local v286 = v285.hour % 24 ;
    local v287 = ((v286 < 12) and "AM") or "PM" ;
    local v288 = string.format("%02i:%02i:%02i %s", ((v286 - 1) % 12) + 1, v285.min, v285.sec, v287);
    local v289 = string.format("%02d/%02d/%04d", v285.day, v285.month, v285.year);
    local v290 = game:GetService("LocalizationService");
    local v291 = game:GetService("Players");
    local v292 = v291.LocalPlayer;
    local v293 = v292.Name;
    local v294 = "Unknown";
    local v295, v296 = pcall(function()
        return v290:GetCountryRegionForPlayerAsync(v292);
    end);
    if v295 then
        v294 = v296;
    end
    v100:SetDesc(v289 .. "-" .. v288 .. " [ " .. v294 .. " ]");
end
spawn(function()
    while true do
        v101();
        game:GetService("RunService").RenderStepped:Wait();
    end
end);
local v102 = Tabs.Status:AddParagraph({
    Title = "Thời Gian Máy Chủ",
    Content = ""
});
local function v103()
    local v297 = math.floor(workspace.DistributedGameTime + 0.5);
    local v298 = math.floor(v297 / (60 ^ 2)) % 24 ;
    local v299 = math.floor(v297 / 60) % 60 ;
    local v300 = v297 % 60 ;
    v102:SetDesc(string.format("%02d Tiếng-%02d Phút-%02d Giây", v298, v299, v300));
end
spawn(function()
    while task.wait() do
        pcall(v103);
    end
end);
local v104 = Tabs.Status:AddParagraph({
    Title = "Đảo Leviathan",
    Content = ""
});
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("Workspace").Map:FindFirstChild("FrozenDimension") then
                v104:SetDesc("🟢");
            else
                v104:SetDesc("🔴");
            end
        end
    end);
end);
local v105 = Tabs.Status:AddInput("Input", {
    Title = "Job ID",
    Default = "",
    Placeholder = "Dán Job ID Vào Đây",
    Numeric = false,
    Finished = false,
    Callback = function(v301)
        _G.Job = v301;
    end
});
Tabs.Status:AddButton({
    Title = "Bắt Đầu Tham Gia Job ID",
    Description = "",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer);
    end
});
Tabs.Status:AddButton({
    Title = "Sao Chép Job ID",
    Description = "",
    Callback = function()
        setclipboard(tostring(game.JobId));
    end
});
local v106 = Tabs.Status:AddToggle("MyToggle", {
    Title = "Spam Tham Gia Job ID",
    Default = false
});
v106:OnChanged(function(v302)
    _G.Join = v302;
end);
spawn(function()
    while wait() do
        if _G.Join then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer);
        end
    end
end);
local v107 = Tabs.Stats:AddToggle("ToggleMelee", {
    Title = "Nâng Đấm",
    Description = "",
    Default = false
});
v107:OnChanged(function(v303)
    _G.Auto_Stats_Melee = v303;
end);
Options.ToggleMelee:SetValue(false);
local v108 = Tabs.Stats:AddToggle("ToggleDe", {
    Title = "Nâng Máu",
    Description = "",
    Default = false
});
v108:OnChanged(function(v304)
    _G.Auto_Stats_Defense = v304;
end);
Options.ToggleDe:SetValue(false);
local v109 = Tabs.Stats:AddToggle("ToggleSword", {
    Title = "Nâng Kiếm",
    Description = "",
    Default = false
});
v109:OnChanged(function(v305)
    _G.Auto_Stats_Sword = v305;
end);
Options.ToggleSword:SetValue(false);
local v110 = Tabs.Stats:AddToggle("ToggleGun", {
    Title = "Nâng Súng",
    Description = "",
    Default = false
});
v110:OnChanged(function(v306)
    _G.Auto_Stats_Gun = v306;
end);
Options.ToggleGun:SetValue(false);
local v111 = Tabs.Stats:AddToggle("ToggleFruit", {
    Title = "Nâng Trái",
    Description = "",
    Default = false
});
v111:OnChanged(function(v307)
    _G.Auto_Stats_Devil_Fruit = v307;
end);
Options.ToggleFruit:SetValue(false);
spawn(function()
    while wait() do
        if _G.Auto_Stats_Devil_Fruit then
            local v737 = {
                [1] = "AddPoint",
                [2] = "Demon Fruit",
                [3] = 3
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v737));
        end
    end
end);
spawn(function()
    while wait() do
        if _G.Auto_Stats_Gun then
            local v738 = {
                [1] = "AddPoint",
                [2] = "Gun",
                [3] = 3
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v738));
        end
    end
end);
spawn(function()
    while wait() do
        if _G.Auto_Stats_Sword then
            local v739 = {
                [1] = "AddPoint",
                [2] = "Sword",
                [3] = 3
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v739));
        end
    end
end);
spawn(function()
    while wait() do
        if _G.Auto_Stats_Defense then
            local v740 = {
                [1] = "AddPoint",
                [2] = "Defense",
                [3] = 3
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v740));
        end
    end
end);
spawn(function()
    while wait() do
        if _G.Auto_Stats_Melee then
            local v741 = {
                [1] = "AddPoint",
                [2] = "Melee",
                [3] = 3
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v741));
        end
    end
end);
local v112 = {};
for v308, v309 in pairs(game:GetService("Players"):GetChildren()) do
    table.insert(v112, v309.Name);
end
local v113 = Tabs.Player:AddDropdown("SelectedPly", {
    Title = "Chọn Người Chơi",
    Description = "",
    Values = v112,
    Multi = false,
    Default = 1
});
v113:SetValue(_G.SelectPly);
v113:OnChanged(function(v310)
    _G.SelectPly = v310;
end);
Tabs.Player:AddButton({
    Title = "Tải Lại Người Chơi",
    Description = "",
    Callback = function()
        table.clear(v112);
        for v541, v542 in pairs(game:GetService("Players"):GetChildren()) do
            table.insert(v112, v542.Name);
        end
    end
});
local v114 = Tabs.Player:AddToggle("ToggleTeleport", {
    Title = "Bay Đến Người Chơi",
    Description = "",
    Default = false
});
v114:OnChanged(function(v311)
    _G.TeleportPly = v311;
    if (v311 == false) then
        wait();
        AutoHaki();
        Tween2(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame);
        wait();
    end
end);
Options.ToggleTeleport:SetValue(false);
spawn(function()
    while wait() do
        if _G.TeleportPly then
            pcall(function()
                if game.Players:FindFirstChild(_G.SelectPly) then
                    Tween2(game.Players[_G.SelectPly].Character.HumanoidRootPart.CFrame);
                end
            end);
        end
    end
end);
local _section = Tabs.Player:AddSection("Khác");
local v115 = Tabs.Player:AddToggle("ToggleNoClip", {
    Title = "Đi Xuyên Tường",
    Description = "",
    Default = true
});
v115:OnChanged(function(v312)
    _G.LOf = v312;
end);
Options.ToggleNoClip:SetValue(true);
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.LOf then
                for v868, v869 in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v869:IsA("BasePart") then
                        v869.CanCollide = false;
                    end
                end
            end
        end);
    end);
end);
local v116 = Tabs.Player:AddToggle("ToggleWalkonWater", {
    Title = "Đi Trên Nước",
    Description = "",
    Default = true
});
v116:OnChanged(function(v313)
    _G.WalkonWater = v313;
end);
Options.ToggleWalkonWater:SetValue(true);
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.WalkonWater then
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000);
            else
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000);
            end
        end);
    end
end);
local v117 = Tabs.Player:AddToggle("ToggleEnablePvp", {
    Title = "Bật PVP",
    Description = "",
    Default = false
});
v117:OnChanged(function(v314)
    _G.EnabledPvP = v314;
end);
Options.ToggleEnablePvp:SetValue(false);
spawn(function()
    pcall(function()
        while wait() do
            if _G.EnabledPvP then
                if (game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true) then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp");
                end
            end
        end
    end);
end);
local v118 = Tabs.Teleport:AddSection("Thế Giới");
local v119 = Tabs.Teleport:AddToggle("ToggleAutoSea2", {
    Title = "Nhiệm Vụ Qua Biển 2",
    Description = "",
    Default = false
});
v119:OnChanged(function(v315)
    _G.Auto_Sea2 = v315;
end);
Options.ToggleAutoSea2:SetValue(false);
spawn(function()
    while task.wait() do
        if _G.Auto_Sea2 then
            pcall(function()
                local level = game:GetService("Players").LocalPlayer.Data.Level.Value
                if level >= 700 and Sea1 then
                    local door = game:GetService("Workspace").Map.Ice.Door
                    if door.CanCollide == true or door.Transparency < 1 then
                        local detectiveCF = CFrame.new(4849.29883, 5.65138149, 719.611877)
                        Tween(detectiveCF)
                        repeat task.wait() until (detectiveCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 or not _G.Auto_Sea2
                        task.wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
                        task.wait(0.5)
                        EquipTool("Key")
                        local keyCF = CFrame.new(1347.7124, 37.3751602, -1325.6488)
                        Tween(keyCF)
                        repeat task.wait() until (keyCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 or not _G.Auto_Sea2
                        task.wait(0.5)
                    else
                        if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral") then
                            for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Ice Admiral" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    local oldCF = v.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait(_G.Fast_Delay or 0.1)
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        v.HumanoidRootPart.CFrame = oldCF
                                        Tween(v.HumanoidRootPart.CFrame * Pos)
                                        AttackNoCoolDown()
                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                    until not _G.Auto_Sea2 or not v.Parent or v.Humanoid.Health <= 0
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                end
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Ice Admiral") then
                            Tween(game:GetService("ReplicatedStorage")["Ice Admiral"].HumanoidRootPart.CFrame * CFrame.new(5, 10, 7))
                        end
                    end
                end
            end)
        end
    end
end)
local v120 = Tabs.Teleport:AddToggle("ToggleAutoSea3", {
    Title = "Nhiệm Vụ Qua Biển 3",
    Description = "",
    Default = false
});
v120:OnChanged(function(v316)
    _G.Auto_Sea3 = v316;
end);
Options.ToggleAutoSea3:SetValue(false);
spawn(function()
    while task.wait() do
        if _G.Auto_Sea3 then
            pcall(function()
                local level = game:GetService("Players").LocalPlayer.Data.Level.Value
                if level >= 1500 and Sea2 then
                    _G.AutoLevel = false
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "General") == 0 then
                        local startCF = CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016)
                        Tween(startCF)
                        repeat task.wait() until (startCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 or not _G.Auto_Sea3
                        task.wait(1.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
                        task.wait(1.8)
                        if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                            for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "rip_indra" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                    local oldCF = v.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait(_G.Fast_Delay or 0.1)
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Pos)
                                        v.HumanoidRootPart.CFrame = oldCF
                                        v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        AttackNoCoolDown()
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                                    until not _G.Auto_Sea3 or v.Humanoid.Health <= 0 or not v.Parent
                                end
                            end
                        else
                            local indraCF = CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016)
                            if (indraCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                                Tween(indraCF)
                            end
                        end
                    end
                end
            end)
        end
    end
end)
Tabs.Teleport:AddButton({
    Title = "Biển 1",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end
});
Tabs.Teleport:AddButton({
    Title = "Biển 2",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
});
Tabs.Teleport:AddButton({
    Title = "Biển 3",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
});
local _section = Tabs.Teleport:AddSection("Đảo");
if Sea1 then
    IslandList = {
        "WindMill",
        "Marine",
        "Middle Town",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Snow Island",
        "MarineFord",
        "Colosseum",
        "Sky Island 1",
        "Sky Island 2",
        "Sky Island 3",
        "Prison",
        "Magma Village",
        "Under Water Island",
        "Fountain City",
        "Shank Room",
        "Mob Island"
    };
elseif Sea2 then
    IslandList = {
        "The Cafe",
        "Frist Spot",
        "Dark Area",
        "Flamingo Mansion",
        "Flamingo Room",
        "Green Zone",
        "Factory",
        "Colossuim",
        "Zombie Island",
        "Two Snow Mountain",
        "Punk Hazard",
        "Cursed Ship",
        "Ice Castle",
        "Forgotten Island",
        "Ussop Island",
        "Mini Sky Island"
    };
elseif Sea3 then
    IslandList = {
        "Mansion",
        "Port Town",
        "Great Tree",
        "Castle On The Sea",
        "MiniSky",
        "Hydra Island",
        "Floating Turtle",
        "Haunted Castle",
        "Ice Cream Island",
        "Peanut Island",
        "Cake Island",
        "Cocoa Island",
        "Candy Island",
        "Tiki Outpost"
    };
end
local v121 = Tabs.Teleport:AddDropdown("DropdownIsland", {
    Title = "Chọn Đảo",
    Description = "",
    Values = IslandList,
    Multi = false,
    Default = 1
});
v121:SetValue(_G.SelectIsland);
v121:OnChanged(function(v317)
    _G.SelectIsland = v317;
end);
Tabs.Teleport:AddButton({
    Title = "Bay Đến Đảo",
    Description = "",
    Callback = function()
        if (_G.SelectIsland == "WindMill") then
            Tween2(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594));
        elseif (_G.SelectIsland == "Marine") then
            Tween2(CFrame.new(- 2566.4296875, 6.8556680679321, 2045.2561035156));
        elseif (_G.SelectIsland == "Middle Town") then
            Tween2(CFrame.new(- 690.33081054688, 15.09425163269, 1582.2380371094));
        elseif (_G.SelectIsland == "Jungle") then
            Tween2(CFrame.new(- 1612.7957763672, 36.852081298828, 149.12843322754));
        elseif (_G.SelectIsland == "Pirate Village") then
            Tween2(CFrame.new(- 1181.3093261719, 4.7514905929565, 3803.5456542969));
        elseif (_G.SelectIsland == "Desert") then
            Tween2(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688));
        elseif (_G.SelectIsland == "Snow Island") then
            Tween2(CFrame.new(1347.8067626953, 104.66806030273, - 1319.7370605469));
        elseif (_G.SelectIsland == "MarineFord") then
            Tween2(CFrame.new(- 4914.8212890625, 50.963626861572, 4281.0278320313));
        elseif (_G.SelectIsland == "Colosseum") then
            Tween2(CFrame.new(- 1427.6203613281, 7.2881078720093, - 2792.7722167969));
        elseif (_G.SelectIsland == "Sky Island 1") then
            Tween2(CFrame.new(- 4869.1025390625, 733.46051025391, - 2667.0180664063));
        elseif (_G.SelectIsland == "Sky Island 2") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 4607.82275, 872.54248, - 1667.55688));
        elseif (_G.SelectIsland == "Sky Island 3") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047));
        elseif (_G.SelectIsland == "Prison") then
            Tween2(CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656));
        elseif (_G.SelectIsland == "Magma Village") then
            Tween2(CFrame.new(- 5247.7163085938, 12.883934020996, 8504.96875));
        elseif (_G.SelectIsland == "Under Water Island") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875));
        elseif (_G.SelectIsland == "Fountain City") then
            Tween2(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813));
        elseif (_G.SelectIsland == "Shank Room") then
            Tween2(CFrame.new(- 1442.16553, 29.8788261, - 28.3547478));
        elseif (_G.SelectIsland == "Mob Island") then
            Tween2(CFrame.new(- 2850.20068, 7.39224768, 5354.99268));
        elseif (_G.SelectIsland == "The Cafe") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 281.93707275390625, 306.130615234375, 609.280029296875));
            wait();
            Tween2(CFrame.new(- 380.47927856445, 77.220390319824, 255.82550048828));
        elseif (_G.SelectIsland == "Frist Spot") then
            Tween2(CFrame.new(- 11.311455726624, 29.276733398438, 2771.5224609375));
        elseif (_G.SelectIsland == "Dark Area") then
            Tween2(CFrame.new(3780.0302734375, 22.652164459229, - 3498.5859375));
        elseif (_G.SelectIsland == "Flamingo Mansion") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 281.93707275390625, 306.130615234375, 609.280029296875));
        elseif (_G.SelectIsland == "Flamingo Room") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2284.912109375, 15.152034759521484, 905.48291015625));
        elseif (_G.SelectIsland == "Green Zone") then
            Tween2(CFrame.new(- 2448.5300292969, 73.016105651855, - 3210.6306152344));
        elseif (_G.SelectIsland == "Factory") then
            Tween2(CFrame.new(424.12698364258, 211.16171264648, - 427.54049682617));
        elseif (_G.SelectIsland == "Colossuim") then
            Tween2(CFrame.new(- 1503.6224365234, 219.7956237793, 1369.3101806641));
        elseif (_G.SelectIsland == "Zombie Island") then
            Tween2(CFrame.new(- 5622.033203125, 492.19604492188, - 781.78552246094));
        elseif (_G.SelectIsland == "Two Snow Mountain") then
            Tween2(CFrame.new(753.14288330078, 408.23559570313, - 5274.6147460938));
        elseif (_G.SelectIsland == "Punk Hazard") then
            Tween2(CFrame.new(- 6127.654296875, 15.951762199402, - 5040.2861328125));
        elseif (_G.SelectIsland == "Cursed Ship") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.40197753906, 125.05712890625, 32885.875));
        elseif (_G.SelectIsland == "Ice Castle") then
            Tween2(CFrame.new(6148.4116210938, 294.38687133789, - 6741.1166992188));
        elseif (_G.SelectIsland == "Forgotten Island") then
            Tween2(CFrame.new(- 3032.7641601563, 317.89672851563, - 10075.373046875));
        elseif (_G.SelectIsland == "Ussop Island") then
            Tween2(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781));
        elseif (_G.SelectIsland == "Mini Sky Island") then
            Tween2(CFrame.new(- 288.74060058594, 49326.31640625, - 35248.59375));
        elseif (_G.SelectIsland == "Great Tree") then
            Tween2(CFrame.new(2681.2736816406, 1682.8092041016, - 7190.9853515625));
        elseif (_G.SelectIsland == "Castle On The Sea") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5075.50927734375, 314.5155029296875, - 3150.0224609375));
        elseif (_G.SelectIsland == "MiniSky") then
            Tween2(CFrame.new(- 260.65557861328, 49325.8046875, - 35253.5703125));
        elseif (_G.SelectIsland == "Port Town") then
            Tween2(CFrame.new(- 290.7376708984375, 6.729952812194824, 5343.5537109375));
        elseif (_G.SelectIsland == "Hydra Island") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906));
        elseif (_G.SelectIsland == "Floating Turtle") then
            Tween2(CFrame.new(- 13274.528320313, 531.82073974609, - 7579.22265625));
        elseif (_G.SelectIsland == "Mansion") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 12468.5380859375, 375.0094299316406, - 7554.62548828125));
        elseif (_G.SelectIsland == "Haunted Castle") then
            Tween2(CFrame.new(- 9515.3720703125, 164.00624084473, 5786.0610351562));
        elseif (_G.SelectIsland == "Ice Cream Island") then
            Tween2(CFrame.new(- 902.56817626953, 79.93204498291, - 10988.84765625));
        elseif (_G.SelectIsland == "Peanut Island") then
            Tween2(CFrame.new(- 2062.7475585938, 50.473892211914, - 10232.568359375));
        elseif (_G.SelectIsland == "Cake Island") then
            Tween2(CFrame.new(- 1884.7747802734375, 19.327526092529297, - 11666.8974609375));
        elseif (_G.SelectIsland == "Cocoa Island") then
            Tween2(CFrame.new(87.94276428222656, 73.55451202392578, - 12319.46484375));
        elseif (_G.SelectIsland == "Candy Island") then
            Tween2(CFrame.new(- 1014.4241943359375, 149.11068725585938, - 14555.962890625));
        elseif (_G.SelectIsland == "Tiki Outpost") then
            Tween2(CFrame.new(- 16542.447265625, 55.68632888793945, 1044.41650390625));
        end
    end
});
Tabs.Teleport:AddButton({
    Title = "Dừng Bay",
    Description = "",
    Callback = function()
        CancelTween();
    end
});
local v122 = game.ReplicatedStorage:FindFirstChild("Remotes").CommF_:InvokeServer("GetFruits");
Table_DevilFruitSniper = {};
ShopDevilSell = {};
for v335, v336 in next, v122 do
    table.insert(Table_DevilFruitSniper, v336.Name);
    if v336.OnSale then
        table.insert(ShopDevilSell, v336.Name);
    end
end
_G.SelectFruit = "Dragon-Dragon";
_G.PermanentFruit = "Dragon-Dragon";
_G.AutoBuyFruitSniper = false;
_G.AutoSwitchPermanentFruit = false;
local v123 = Tabs.Fruit:AddDropdown("DropdownFruit", {
    Title = "Chọn Trái",
    Description = "",
    Values = Table_DevilFruitSniper,
    Multi = false,
    Default = 1
});
v123:SetValue(_G.SelectFruit);
v123:OnChanged(function(v337)
    _G.SelectFruit = v337;
end);
local v111 = Tabs.Fruit:AddToggle("ToggleFruit", {
    Title = "Mua Trái Chọn",
    Description = "",
    Default = false
});
v111:OnChanged(function(v338)
    if v338 then
        _G.AutoBuyFruitSniper = true;
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits");
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.SelectFruit, false);
        end);
        _G.AutoBuyFruitSniper = false;
    end
end);
Options.ToggleFruit:SetValue(false);
local v124 = Tabs.Fruit:AddDropdown("DropdownPermanentFruit", {
    Title = "Chọn Trái Vĩnh Viễn",
    Description = "",
    Values = Table_DevilFruitSniper,
    Multi = false,
    Default = 1
});
v124:SetValue(_G.PermanentFruit);
v124:OnChanged(function(v339)
    _G.PermanentFruit = v339;
end);
local v125 = Tabs.Fruit:AddToggle("TogglePermanentFruit", {
    Title = "Đổi Trái Vĩnh Viễn",
    Description = "",
    Default = false
});
v125:OnChanged(function(v340)
    if v340 then
        _G.AutoSwitchPermanentFruit = true;
        pcall(function()
            local v742 = {
                [1] = "SwitchFruit",
                [2] = _G.PermanentFruit
            };
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v742));
        end);
        _G.AutoSwitchPermanentFruit = false;
    end
end);
Options.TogglePermanentFruit:SetValue(false);
local v126 = Tabs.Fruit:AddToggle("ToggleStore", {
    Title = "Lưu Trái",
    Description = "",
    Default = false
});
v126:OnChanged(function(v341)
    _G.AutoStoreFruit = v341;
end);
Options.ToggleStore:SetValue(false);
spawn(function()
    while task.wait() do
        if _G.AutoStoreFruit then
            pcall(function()
                if _G.AutoStoreFruit then
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bomb Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bomb Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Bomb-Bomb", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bomb Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spike Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spike Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spike-Spike", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spike Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Chop Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Chop Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Chop-Chop", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Chop Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spring Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spring Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spring-Spring", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spring Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rocket Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kilo Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rocket-Rocket", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kilo Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Smoke Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Smoke Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Smoke-Smoke", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Smoke Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spin Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spin-Spin", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flame Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Flame-Flame", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Falcon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Falcon Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Falcon", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("alcon Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ice Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Ice-Ice", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sand Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Sand-Sand", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dark Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Dark-Dark", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ghost Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Revive Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Ghost-Ghost", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Revive Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Diamond Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Diamond Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Diamond-Diamond", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Diamond Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Light Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Light-Light", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Love Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Love Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Love-Love", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Love Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rubber Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rubber Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rubber-Rubber", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rubber Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Barrier Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Barrier Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Barrier-Barrier", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Barrier Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Magma Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Magma-Magma", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Portal Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Portal Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Door-Door", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Portal Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Quake Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Quake-Quake", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Buddha Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Buddha Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buddha", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Buddha Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spider Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spider Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spider-Spider", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spider Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Phoenix Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Phoenix Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Phoenix", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Phoenix Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rumble Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rumble-Rumble", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Pain Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pain Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Pain-Pain", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pain Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gravity Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gravity Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Gravity-Gravity", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gravity Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dough Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Dough-Dough", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Shadow Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Shadow Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Shadow-Shadow", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Shadow Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Venom Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Venom Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Venom-Venom", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Venom Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Control Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Control Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Control-Control", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Control Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spirit Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spirit Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Soul-Soul", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spirit Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Dragon-Dragon", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Fruit"));
                        if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Leopard Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Leopard Fruit")) then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Leopard-Leopard", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Leopard Fruit"));
                        end
                    end
                end
            end);
        end
        wait();
    end
end);
local v127 = Tabs.Fruit:AddToggle("ToggleRandomFruit", {
    Title = "Random Trái",
    Description = "",
    Default = false
});
v127:OnChanged(function(v342)
    _G.Random_Auto = v342;
end);
Options.ToggleRandomFruit:SetValue(false);
spawn(function()
    pcall(function()
        while wait() do
            if _G.Random_Auto then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy");
            end
        end
    end);
end);
local v128 = Tabs.Fruit:AddToggle("ToggleCollectTP", {
    Title = "Bay Đến Trái",
    Description = "",
    Default = false
});
v128:OnChanged(function(v343)
    _G.CollectFruitTP = v343;
end);
Options.ToggleCollectTP:SetValue(false);
spawn(function()
    while wait() do
        if _G.CollectFruitTP then
            for v801, v802 in pairs(game.Workspace:GetChildren()) do
                if string.find(v802.Name, "Fruit") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v802.Handle.CFrame;
                end
            end
        end
    end
end);
local v129 = Tabs.Fruit:AddToggle("ToggleCollect", {
    Title = "Dịch Chuyển Đến Trái",
    Description = "",
    Default = false
});
v129:OnChanged(function(v344)
    _G.Tweenfruit = v344;
end);
Options.ToggleCollect:SetValue(false);
spawn(function()
    while wait() do
        if _G.Tweenfruit then
            for v803, v804 in pairs(game.Workspace:GetChildren()) do
                if string.find(v804.Name, "Fruit") then
                    Tween(v804.Handle.CFrame);
                end
            end
        end
    end
end);
local _section = Tabs.Fruit:AddSection("Định Vị");
local v130 = Tabs.Fruit:AddToggle("ToggleEspPlayer", {
    Title = "Người Chơi",
    Description = "",
    Default = false
});
v130:OnChanged(function(v345)
    ESPPlayer = v345;
    UpdatePlayerChams();
end);
Options.ToggleEspPlayer:SetValue(false);
local v131 = Tabs.Fruit:AddToggle("ToggleEspFruit", {
    Title = "Trái",
    Description = "",
    Default = false
});
v131:OnChanged(function(v346)
    DevilFruitESP = v346;
    while DevilFruitESP do
        wait();
        UpdateDevilChams();
    end
end);
Options.ToggleEspFruit:SetValue(false);
local v132 = Tabs.Fruit:AddToggle("ToggleEspIsland", {
    Title = "Đảo",
    Description = "",
    Default = false
});
v132:OnChanged(function(v347)
    IslandESP = v347;
    while IslandESP do
        wait();
        UpdateIslandESP();
    end
end);
Options.ToggleEspIsland:SetValue(false);
local v133 = Tabs.Fruit:AddToggle("ToggleEspFlower", {
    Title = "Hoa",
    Description = "",
    Default = false
});
v133:OnChanged(function(v348)
    FlowerESP = v348;
    UpdateFlowerChams();
end);
Options.ToggleEspFlower:SetValue(false);
spawn(function()
    while wait() do
        if FlowerESP then
            UpdateFlowerChams();
        end
        if DevilFruitESP then
            UpdateDevilChams();
        end
        if ChestESP then
            UpdateChestChams();
        end
        if ESPPlayer then
            UpdatePlayerChams();
        end
        if RealFruitESP then
            UpdateRealFruitChams();
        end
    end
end);
local v134 = Tabs.Fruit:AddToggle("ToggleEspRealFruit", {
    Title = "Trái Dứa Khớm Táo",
    Description = "",
    Default = false
});
v134:OnChanged(function(v349)
    RealFruitEsp = v349;
    while RealFruitEsp do
        wait();
        UpdateRealFruitEsp();
    end
end);
Options.ToggleEspRealFruit:SetValue(false);
function UpdateRealFruitEsp()
    for v548, v549 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v549:IsA("Tool") then
            if RealFruitEsp then
                if not v549.Handle:FindFirstChild("NameEsp" .. Number) then
                    local billboard = Instance.new("BillboardGui", v549.Handle);
                    v1066.Name = "NameEsp" .. Number ;
                    v1066.ExtentsOffset = Vector3.new(0, 1, 0);
                    v1066.Size = UDim2.new(1, 200, 1, 30);
                    v1066.Adornee = v549.Handle;
                    v1066.AlwaysOnTop = true;
                    local textLabel = Instance.new("TextLabel", v1066);
                    v1073.Font = Enum.Font.GothamSemibold;
                    v1073.FontSize = "Size14";
                    v1073.TextWrapped = true;
                    v1073.Size = UDim2.new(1, 0, 1, 0);
                    v1073.TextYAlignment = "Top";
                    v1073.BackgroundTransparency = 1;
                    v1073.TextStrokeTransparency = 0.5;
                    v1073.TextColor3 = Color3.fromRGB(255, 0, 0);
                    v1073.Text = v549.Name .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v549.Handle.Position).Magnitude / 3) .. " Distance" ;
                else
                    v549.Handle["NameEsp" .. Number ].TextLabel.Text = v549.Name .. " " .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v549.Handle.Position).Magnitude / 3) .. " Distance" ;
                end
            elseif v549.Handle:FindFirstChild("NameEsp" .. Number) then
                v549.Handle:FindFirstChild("NameEsp" .. Number):Destroy();
            end
        end
    end
    for v550, v551 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v551:IsA("Tool") then
            if RealFruitEsp then
                if not v551.Handle:FindFirstChild("NameEsp" .. Number) then
                    local billboard = Instance.new("BillboardGui", v551.Handle);
                    v1085.Name = "NameEsp" .. Number ;
                    v1085.ExtentsOffset = Vector3.new(0, 1, 0);
                    v1085.Size = UDim2.new(1, 200, 1, 30);
                    v1085.Adornee = v551.Handle;
                    v1085.AlwaysOnTop = true;
                    local textLabel = Instance.new("TextLabel", v1085);
                    v1092.Font = Enum.Font.GothamSemibold;
                    v1092.FontSize = "Size14";
                    v1092.TextWrapped = true;
                    v1092.Size = UDim2.new(1, 0, 1, 0);
                    v1092.TextYAlignment = "Top";
                    v1092.BackgroundTransparency = 1;
                    v1092.TextStrokeTransparency = 0.5;
                    v1092.TextColor3 = Color3.fromRGB(255, 174, 0);
                    v1092.Text = v551.Name .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v551.Handle.Position).Magnitude / 3) .. " Distance" ;
                else
                    v551.Handle["NameEsp" .. Number ].TextLabel.Text = v551.Name .. " " .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v551.Handle.Position).Magnitude / 3) .. " Distance" ;
                end
            elseif v551.Handle:FindFirstChild("NameEsp" .. Number) then
                v551.Handle:FindFirstChild("NameEsp" .. Number):Destroy();
            end
        end
    end
    for v552, v553 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v553:IsA("Tool") then
            if RealFruitEsp then
                if not v553.Handle:FindFirstChild("NameEsp" .. Number) then
                    local billboard = Instance.new("BillboardGui", v553.Handle);
                    v1104.Name = "NameEsp" .. Number ;
                    v1104.ExtentsOffset = Vector3.new(0, 1, 0);
                    v1104.Size = UDim2.new(1, 200, 1, 30);
                    v1104.Adornee = v553.Handle;
                    v1104.AlwaysOnTop = true;
                    local textLabel = Instance.new("TextLabel", v1104);
                    v1111.Font = Enum.Font.GothamSemibold;
                    v1111.FontSize = "Size14";
                    v1111.TextWrapped = true;
                    v1111.Size = UDim2.new(1, 0, 1, 0);
                    v1111.TextYAlignment = "Top";
                    v1111.BackgroundTransparency = 1;
                    v1111.TextStrokeTransparency = 0.5;
                    v1111.TextColor3 = Color3.fromRGB(251, 255, 0);
                    v1111.Text = v553.Name .. " \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v553.Handle.Position).Magnitude / 3) .. " Distance" ;
                else
                    v553.Handle["NameEsp" .. Number ].TextLabel.Text = v553.Name .. " " .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v553.Handle.Position).Magnitude / 3) .. " Distance" ;
                end
            elseif v553.Handle:FindFirstChild("NameEsp" .. Number) then
                v553.Handle:FindFirstChild("NameEsp" .. Number):Destroy();
            end
        end
    end
end
local v135 = Tabs.Fruit:AddToggle("ToggleIslandMirageEsp", {
    Title = "Đảo Bí Ẩn",
    Description = "",
    Default = false
});
v135:OnChanged(function(v350)
    IslandMirageEsp = v350;
    while IslandMirageEsp do
        wait();
        UpdateIslandMirageEsp();
    end
end);
Options.ToggleIslandMirageEsp:SetValue(false);
function isnil(v351)
    return v351 == nil ;
end
local function v20(v352)
    return math.floor(tonumber(v352) + 0.5);
end
Number = math.random(1, 1000000);
function UpdateIslandMirageEsp()
    for v554, v555 in pairs(game:GetService("Workspace")['_WorldOrigin'].Locations:GetChildren()) do
        pcall(function()
            if MirageIslandESP then
                if (v555.Name == "Mirage Island") then
                    if not v555:FindFirstChild("NameEsp") then
                        local billboard = Instance.new("BillboardGui", v555);
                        v1347.Name = "NameEsp";
                        v1347.ExtentsOffset = Vector3.new(0, 1, 0);
                        v1347.Size = UDim2.new(1, 200, 1, 30);
                        v1347.Adornee = v555;
                        v1347.AlwaysOnTop = true;
                        local textLabel = Instance.new("TextLabel", v1347);
                        v1353.Font = Enum.Font.Code;
                        v1353.FontSize = Enum.FontSize.Size14;
                        v1353.TextWrapped = true;
                        v1353.Size = UDim2.new(1, 0, 1, 0);
                        v1353.TextYAlignment = Enum.TextYAlignment.Top;
                        v1353.BackgroundTransparency = 1;
                        v1353.TextStrokeTransparency = 0.5;
                        v1353.TextColor3 = Color3.fromRGB(80, 245, 245);
                    else
                        v555['NameEsp'].TextLabel.Text = v555.Name .. "   \n" .. v20((game:GetService("Players").LocalPlayer.Character.Head.Position - v555.Position).Magnitude / 3) .. " M" ;
                    end
                end
            elseif v555:FindFirstChild("NameEsp") then
                v555:FindFirstChild("NameEsp"):Destroy();
            end
        end);
    end
end
local v136 = {
    "Flame",
    "Ice",
    "Quake",
    "Light",
    "Dark",
    "Spider",
    "Rumble",
    "Magma",
    "Buddha",
    "Sand",
    "Phoenix",
    "Dough"
};
local v137 = Tabs.Raid:AddDropdown("DropdownRaid", {
    Title = "Chọn Chip",
    Description = "",
    Values = v136,
    Multi = false,
    Default = 1
});
v137:SetValue(SelectChip);
v137:OnChanged(function(v353)
    SelectChip = v353;
end);
local v138 = Tabs.Raid:AddToggle("ToggleBuy", {
    Title = "Mua Chip",
    Description = "",
    Default = false
});
v138:OnChanged(function(v354)
    _G.Auto_Buy_Chips_Dungeon = v354;
end);
Options.ToggleBuy:SetValue(false);
spawn(function()
    while wait() do
        if _G.Auto_Buy_Chips_Dungeon then
            pcall(function()
                local v805 = {
                    [1] = "RaidsNpc",
                    [2] = "Select",
                    [3] = SelectChip
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v805));
            end);
        end
    end
end);
local v139 = Tabs.Raid:AddToggle("ToggleStart", {
    Title = "Bắt Đầu Raid",
    Description = "",
    Default = false
});
v139:OnChanged(function(v355)
    _G.Auto_StartRaid = v355;
end);
Options.ToggleStart:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_StartRaid then
                if (game:GetService("Players")['LocalPlayer'].PlayerGui.Main.Timer.Visible == false) then
                    if (not game:GetService("Workspace")['_WorldOrigin'].Locations:FindFirstChild("Island 1") and (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip"))) then
                        if Sea2 then
                            Tween2(CFrame.new(- 6438.73535, 250.645355, - 4501.50684));
                            local v1547 = {
                                [1] = "SetSpawnPoint"
                            };
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1547));
                            fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector);
                        elseif Sea3 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5075.50927734375, 314.5155029296875, - 3150.0224609375));
                            Tween2(CFrame.new(- 5017.40869, 314.844055, - 2823.0127, - 0.925743818, 4.482175e-8, - 0.378151238, 4.5550315e-9, 1, 1.0737756e-7, 0.378151238, 9.768162e-8, - 0.925743818));
                            local v1656 = {
                                [1] = "SetSpawnPoint"
                            };
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1656));
                            fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector);
                        end
                    end
                end
            end
        end);
    end
end);
local v140 = Tabs.Raid:AddToggle("ToggleNextIsland", {
    Title = "Đấm Quái Raid+Bay Đến Đảo",
    Description = "",
    Default = false
});
v140:OnChanged(function(v356)
    AutoNextIsland = v356;
    if not v356 then
        _G.AutoNear = false;
    end
end);
Options.ToggleNextIsland:SetValue(false);
spawn(function()
    local v357 = {};
    while task.wait() do
        if AutoNextIsland then
            pcall(function()
                local v806 = game.Players.LocalPlayer.Character;
                if (v806 and v806:FindFirstChild("HumanoidRootPart")) then
                    local v900 = game:GetService("Workspace")['_WorldOrigin'].Locations;
                    local v901 = v806.HumanoidRootPart.Position;
                    if (((v901 - Vector3.new(- 6438.73535, 250.645355, - 4501.50684)).Magnitude < 1) or ((v901 - Vector3.new(- 5017.40869, 314.844055, - 2823.0127)).Magnitude < 1)) then
                        v357 = {};
                    end
                    if v900:FindFirstChild("Island 1") then
                        _G.AutoNear = true;
                    end
                    if (v900:FindFirstChild("Island 2") and not v357["Island 2"]) then
                        Tween(v900:FindFirstChild("Island 2").CFrame);
                        v357["Island 2"] = true;
                        AutoNextIsland = false;
                        wait();
                        AutoNextIsland = true;
                    elseif (v900:FindFirstChild("Island 3") and not v357["Island 3"]) then
                        Tween(v900:FindFirstChild("Island 3").CFrame);
                        v357["Island 3"] = true;
                        AutoNextIsland = false;
                        wait();
                        AutoNextIsland = true;
                    elseif (v900:FindFirstChild("Island 4") and not v357["Island 4"]) then
                        Tween(v900:FindFirstChild("Island 4").CFrame);
                        v357["Island 4"] = true;
                        AutoNextIsland = false;
                        wait();
                        AutoNextIsland = true;
                    elseif (v900:FindFirstChild("Island 5") and not v357["Island 5"]) then
                        Tween(v900:FindFirstChild("Island 5").CFrame);
                        v357["Island 5"] = true;
                        AutoNextIsland = false;
                        wait();
                        AutoNextIsland = true;
                    end
                end
            end);
        end
    end
end);
local v141 = Tabs.Raid:AddToggle("ToggleAwake", {
    Title = "Thức Tỉnh",
    Description = "",
    Default = false
});
v141:OnChanged(function(v358)
    AutoAwakenAbilities = v358;
end);
Options.ToggleAwake:SetValue(false);
spawn(function()
    while task.wait() do
        if AutoAwakenAbilities then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Awaken");
            end);
        end
    end
end);
local v142 = Tabs.Raid:AddToggle("ToggleGetFruit", {
    Title = "Lấy Trái Dưới 1 Triệu",
    Description = "",
    Default = false
});
v142:OnChanged(function(v359)
    _G.Autofruit = v359;
end);
spawn(function()
    while wait() do
        pcall(function()
            if _G.Autofruit then
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Rocket-Rocket"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Spin-Spin"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Chop-Chop"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Spring-Spring"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Bomb-Bomb"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Smoke-Smoke"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Spike-Spike"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Flame-Flame"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Falcon-Falcon"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Ice-Ice"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Sand-Sand"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Dark-Dark"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Ghost-Ghost"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Diamond-Diamond"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Light-Light"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Rubber-Rubber"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
                local v807 = {
                    [1] = "LoadFruit",
                    [2] = "Barrier-Barrier"
                };
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v807));
            end
        end);
    end
end);
if Sea2 then
    Tabs.Raid:AddButton({
        Title = "Bay Đến Chỗ Tập Kích",
        Description = "",
        Callback = function()
            Tween2(CFrame.new(- 6438.73535, 250.645355, - 4501.50684));
        end
    });
elseif Sea3 then
    Tabs.Raid:AddButton({
        Title = "Bay Đến Chỗ Tập Kích",
        Description = "",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5075.50927734375, 314.5155029296875, - 3150.0224609375));
            Tween2(CFrame.new(- 5017.40869, 314.844055, - 2823.0127, - 0.925743818, 4.482175e-8, - 0.378151238, 4.5550315e-9, 1, 1.0737756e-7, 0.378151238, 9.768162e-8, - 0.925743818));
        end
    });
end
local _section = Tabs.Raid:AddSection("Tập Kích Law");
local v143 = Tabs.Raid:AddToggle("ToggleLaw", {
    Title = "Mua Chip Và Đấm Law",
    Description = "",
    Default = false
});
v143:OnChanged(function(v360)
    Auto_Law = v360;
end);
Options.ToggleLaw:SetValue(false);
spawn(function()
    pcall(function()
        while wait() do
            if Auto_Law then
                if (not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") and not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip") and not game:GetService("Workspace").Enemies:FindFirstChild("Order") and not game:GetService("ReplicatedStorage"):FindFirstChild("Order")) then
                    wait();
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "1");
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2");
                end
            end
        end
    end);
end);
spawn(function()
    pcall(function()
        while wait() do
            if Auto_Law then
                if (not game:GetService("Workspace").Enemies:FindFirstChild("Order") and not game:GetService("ReplicatedStorage"):FindFirstChild("Order")) then
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip")) then
                        fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector);
                    end
                end
                if (game:GetService("ReplicatedStorage"):FindFirstChild("Order") or game:GetService("Workspace").Enemies:FindFirstChild("Order")) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v1469.Name == "Order") then
                                repeat
                                    wait(_G.Fast_Delay);
                                    AttackNoCoolDown();
                                    AutoHaki();
                                    EquipTool(SelectWeapon);
                                    Tween(v1469.HumanoidRootPart.CFrame * Pos);
                                    v1469.HumanoidRootPart.CanCollide = false;
                                    v1469.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                until not v1469.Parent or (v1469.Humanoid.Health <= 0) or (Auto_Law == false)
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Order") then
                        Tween(CFrame.new(- 6217.2021484375, 28.047645568848, - 5053.1357421875));
                    end
                end
            end
        end
    end);
end);
Tabs.Race:AddButton({
    Title = "Đền Thời Gian",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875));
    end
});
Tabs.Race:AddButton({
    Title = "Cần Gạt",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875));
        Tween2(CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734));
    end
});
Tabs.Race:AddButton({
    Title = "Chỗ Mua Gear",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875));
        Tween2(CFrame.new(28981.552734375, 14888.4267578125, - 120.245849609375));
    end
});
local _section = Tabs.Race:AddSection("Tộc");
Tabs.Race:AddButton({
    Title = "Cửa Tộc",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875));
        if (game:GetService("Players").LocalPlayer.Data.Race.Value == "Human") then
            Tween2(CFrame.new(29221.822265625, 14890.9755859375, - 205.99114990234375));
        elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea") then
            Tween2(CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375));
        elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman") then
            Tween2(CFrame.new(28231.17578125, 14890.9755859375, - 211.64173889160156));
        elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg") then
            Tween2(CFrame.new(28502.681640625, 14895.9755859375, - 423.7279357910156));
        elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul") then
            Tween2(CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156));
        elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink") then
            Tween2(CFrame.new(29012.341796875, 14890.9755859375, - 380.1492614746094));
        end
    end
});
local v144 = Tabs.Race:AddToggle("ToggleHumanandghoul", {
    Title = "Hoàn Thành Ải [Human/Ghoul]",
    Description = "",
    Default = false
});
v144:OnChanged(function(v361)
    KillAura = v361;
end);
Options.ToggleHumanandghoul:SetValue(false);
local v145 = Tabs.Race:AddToggle("ToggleAutotrial", {
    Title = "Hoàn Thành Ải",
    Description = "",
    Default = false
});
v145:OnChanged(function(v362)
    _G.AutoQuestRace = v362;
end);
Options.ToggleAutotrial:SetValue(false);
spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoQuestRace then
                if (game:GetService("Players").LocalPlayer.Data.Race.Value == "Human") then
                    for _, descendant in pairs(game.Workspace.Enemies:GetDescendants()) do
                        if (v1124:FindFirstChild("Humanoid") and v1124:FindFirstChild("HumanoidRootPart") and (v1124.Humanoid.Health > 0)) then
                            pcall(function()
                                repeat
                                    wait();
                                    v1124.Humanoid.Health = 0;
                                    v1124.HumanoidRootPart.CanCollide = false;
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge);
                                until not _G.AutoQuestRace or not v1124.Parent or (v1124.Humanoid.Health <= 0)
                            end);
                        end
                    end
                elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea") then
                    for v1470, v1471 in pairs(game:GetService("Workspace").Map.SkyTrial.Model:GetDescendants()) do
                        if (v1471.Name == "snowisland_Cylinder.081") then
                            BTPZ(v1471.CFrame * CFrame.new(0, 0, 0));
                        end
                    end
                elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman") then
                    for v1582, v1583 in pairs(game:GetService("Workspace").SeaBeasts.SeaBeast1:GetDescendants()) do
                        if (v1583.Name == "HumanoidRootPart") then
                            Tween(v1583.CFrame * Pos);
                            for v1746, v1747 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v1747:IsA("Tool") then
                                    if (v1747.ToolTip == "Melee") then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1747);
                                    end
                                end
                            end
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait(0.2);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait(0.2);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            for v1748, v1749 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v1749:IsA("Tool") then
                                    if (v1749.ToolTip == "Blox Fruit") then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1749);
                                    end
                                end
                            end
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait(0.2);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait(0.2);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait();
                            for v1750, v1751 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v1751:IsA("Tool") then
                                    if (v1751.ToolTip == "Sword") then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1751);
                                    end
                                end
                            end
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait(0.2);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait(0.2);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait();
                            for v1752, v1753 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v1753:IsA("Tool") then
                                    if (v1753.ToolTip == "Gun") then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v1753);
                                    end
                                end
                            end
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait(0.2);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            wait(0.2);
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart);
                        end
                    end
                elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg") then
                    Tween(CFrame.new(28654, 14898.7832, - 30, 1, 0, 0, 0, 1, 0, 0, 0, 1));
                elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul") then
                    for _, descendant in pairs(game.Workspace.Enemies:GetDescendants()) do
                        if (v1765:FindFirstChild("Humanoid") and v1765:FindFirstChild("HumanoidRootPart") and (v1765.Humanoid.Health > 0)) then
                            pcall(function()
                                repeat
                                    wait();
                                    v1765.Humanoid.Health = 0;
                                    v1765.HumanoidRootPart.CanCollide = false;
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge);
                                until not _G.AutoQuestRace or not v1765.Parent or (v1765.Humanoid.Health <= 0)
                            end);
                        end
                    end
                elseif (game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink") then
                    for v1790, v1791 in pairs(game:GetService("Workspace"):GetDescendants()) do
                        if (v1791.Name == "StartPoint") then
                            Tween(v1791.CFrame * CFrame.new(0, 10, 0));
                        end
                    end
                end
            end
        end
    end);
end);
local v146 = Tabs.Race:AddToggle("ToggleKillTrial", {
    Title = "Đấm Người Chơi Trong Trial",
    Description = "",
    Default = false
});
v146:OnChanged(function(v363)
    _G.AutoKillTrial = v363;
end);
Options.ToggleKillTrial:SetValue(false);
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoKillTrial then
                for v870, v871 in pairs(game:GetService("Players"):GetChildren()) do
                    if (v871.Name and (v871.Name ~= game.Players.LocalPlayer.Name) and ((v871.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100)) then
                        if (v871.Character.Humanoid.Health > 0) then
                            repeat
                                wait(_G.Fast_Delay);
                                EquipTool(SelectWeapon);
                                AutoHaki();
                                Tween(v871.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5));
                                v871.Character.HumanoidRootPart.CanCollide = false;
                                v871.Character.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                AttackNoCoolDown();
                            until not _G.AutoKillTrial or not v871.Parent or (v871.Character.Humanoid.Health <= 0)
                        end
                    end
                end
            end
        end);
    end
end);
local _section = Tabs.Race:AddSection("Huấn Luyện");
local v147 = Tabs.Race:AddToggle("ToggleFarmRace", {
    Title = "Cày Luyện Tộc",
    Description = "",
    Default = false
});
local v148 = false;
v147:OnChanged(function(v364)
    v148 = v364;
end);
Options.ToggleFarmRace:SetValue(false);
spawn(function()
    while wait() do
        if v148 then
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
                    if (game.Players.LocalPlayer.Character.RaceTransformed.Value == true) then
                        _G.AutoBoneNoQuest = false;
                        Tween(CFrame.new(- 9698.4736328125, 445.09442138671875, 6545.8525390625));
                    elseif (game.Players.LocalPlayer.Character.RaceTransformed.Value == false) then
                        _G.AutoBoneNoQuest = true;
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game);
                        wait();
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "Y", false, game);
                    end
                end
            end);
        else
            _G.AutoBoneNoQuest = false;
        end
    end
end);
local v149 = Tabs.Race:AddToggle("ToggleUpgrade", {
    Title = "Mua Gear",
    Description = "",
    Default = false
});
v149:OnChanged(function(v365)
    _G.AutoUpgrade = v365;
    if _G.AutoUpgrade then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy");
    end
end);
Options.ToggleUpgrade:SetValue(false);
local _section = Tabs.Shop:AddSection("Khả Năng");
Tabs.Shop:AddButton({
    Title = "Nhảy",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo");
    end
});
Tabs.Shop:AddButton({
    Title = "Haki Đấm",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso");
    end
});
Tabs.Shop:AddButton({
    Title = "Dịch Chuyển",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru");
    end
});
Tabs.Shop:AddButton({
    Title = "Haki Quan Sát",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy");
    end
});
local _section = Tabs.Shop:AddSection("Kiếm");
Tabs.Shop:AddButton({
    Title = "Cutlass",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cutlass");
    end
});
Tabs.Shop:AddButton({
    Title = "Katana",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Katana");
    end
});
Tabs.Shop:AddButton({
    Title = "Iron Mace",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace");
    end
});
Tabs.Shop:AddButton({
    Title = "Duel Katana",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana");
    end
});
Tabs.Shop:AddButton({
    Title = "Triple Katana",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana");
    end
});
Tabs.Shop:AddButton({
    Title = "Pipe",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Pipe");
    end
});
Tabs.Shop:AddButton({
    Title = "Dual-Headed Blade",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade");
    end
});
Tabs.Shop:AddButton({
    Title = "Bisento",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento");
    end
});
Tabs.Shop:AddButton({
    Title = "Soul Cane",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane");
    end
});
Tabs.Shop:AddButton({
    Title = "Pole V2",
    Description = "",
    Callback = function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk");
    end
});
local _section = Tabs.Shop:AddSection("Võ");
Tabs.Shop:AddButton({
    Title = "Black Leg",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg");
    end
});
Tabs.Shop:AddButton({
    Title = "Electro",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro");
    end
});
Tabs.Shop:AddButton({
    Title = "Fishman Karate",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate");
    end
});
Tabs.Shop:AddButton({
    Title = "Dragon Claw",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1");
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2");
    end
});
Tabs.Shop:AddButton({
    Title = "Superhuman",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman");
    end
});
Tabs.Shop:AddButton({
    Title = "Death Step",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep");
    end
});
Tabs.Shop:AddButton({
    Title = "Sharkman Karate",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true);
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate");
    end
});
Tabs.Shop:AddButton({
    Title = "Electric Claw",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw");
    end
});
Tabs.Shop:AddButton({
    Title = "Dragon Talon",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon");
    end
});
Tabs.Shop:AddButton({
    Title = "Godhuman",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman");
    end
});
Tabs.Shop:AddButton({
    Title = "Sanguine Art",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt");
    end
});
local _section = Tabs.Shop:AddSection("Khác");
Tabs.Shop:AddButton({
    Title = "Đổi Chỉ Số",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1");
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2");
    end
});
Tabs.Shop:AddButton({
    Title = "Đổi Tộc",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1");
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2");
    end
});
Tabs.Shop:AddButton({
    Title = "Đổi Tộc Ghoul",
    Description = "",
    Callback = function()
        local v366 = {
            [1] = "Ectoplasm",
            [2] = "Change",
            [3] = 4
        };
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v366));
    end
});
Tabs.Shop:AddButton({
    Title = "Đổi Tộc Cyborg",
    Description = "",
    Callback = function()
        local v367 = {
            [1] = "CyborgTrainer",
            [2] = "Buy"
        };
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v367));
    end
});
Tabs.Shop:AddButton({
    Title = "Đổi Tộc Draco",
    Description = "Chỉ Ở Biển 3",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906));
        Tween2(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938));
        local v368 = Vector3.new(5814.42724609375, 1208.3267822265625, 884.5785522460938);
        local v369 = game.Players.LocalPlayer;
        local v370 = v369.Character or v369.CharacterAdded:Wait() ;
        repeat
            wait();
        until (v370.HumanoidRootPart.Position - v368).Magnitude < 1
        local v371 = {
            [1] = {
                NPC = "Dragon Wizard",
                Command = "DragonRace"
            }
        };
        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v371));
    end
});
Tabs.Misc:AddButton({
    Title = "Tham Gia Máy Chủ Lại",
    Description = "",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer);
    end
});
Tabs.Misc:AddButton({
    Title = "Đổi Máy Chủ",
    Description = "",
    Callback = function()
        Hop();
    end
});
function Hop()
    local placeId = game.PlaceId
    local triedServers = {}
    local cursor = ""
    local currentHour = os.date("!*t").hour
    local found = false
    function TPReturner()
        local servers
        if cursor == "" then
            servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
        else
            servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. cursor))
        end
        local serverId = ""
        if servers.nextPageCursor and servers.nextPageCursor ~= "null" and servers.nextPageCursor ~= nil then
            cursor = servers.nextPageCursor
        end
        local count = 0
        for _, server in pairs(servers.data) do
            local isValid = true
            serverId = tostring(server.id)
            if tonumber(server.maxPlayers) > tonumber(server.playing) then
                for _, tried in pairs(triedServers) do
                    if count ~= 0 then
                        if serverId == tostring(tried) then
                            isValid = false
                        end
                    elseif tonumber(currentHour) ~= tonumber(tried) then
                        local success = pcall(function()
                            triedServers = {}
                            table.insert(triedServers, currentHour)
                        end)
                    end
                    count = count + 1
                end
                if isValid == true then
                    table.insert(triedServers, serverId)
                    wait()
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, serverId, game.Players.LocalPlayer)
                    end)
                    wait()
                end
            end
        end
    end
    function ServerHopLoop()
        while wait() do
            pcall(function()
                TPReturner()
                if cursor ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    ServerHopLoop()
end
local _section = Tabs.Misc:AddSection("Đội");
Tabs.Misc:AddButton({
    Title = "Hải Tặc",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates");
    end
});
Tabs.Misc:AddButton({
    Title = "Hải Quân",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines");
    end
});
local _section = Tabs.Misc:AddSection("Kinh Nghiệm");
local RedeemCodes = {
    "KITT_RESET",
    "Sub2UncleKizaru",
    "SUB2GAMERROBOT_RESET1",
    "Sub2Fer999",
    "Enyu_is_Pro",
    "JCWK",
    "StarcodeHEO",
    "MagicBus",
    "KittGaming",
    "Sub2CaptainMaui",
    "Sub2OfficalNoobie",
    "TheGreatAce",
    "Sub2NoobMaster123",
    "Sub2Daigrock",
    "Axiore",
    "StrawHatMaine",
    "TantaiGaming",
    "Bluxxy",
    "SUB2GAMERROBOT_EXP1",
    "Chandler",
    "NOMOREHACK",
    "BANEXPLOIT",
    "WildDares",
    "BossBuild",
    "GetPranked",
    "EARN_FRUITS",
    "FIGHT4FRUIT",
    "NOEXPLOITER",
    "NOOB2ADMIN",
    "CODESLIDE",
    "ADMINHACKED",
    "ADMINDARES",
    "fruitconcepts",
    "krazydares",
    "TRIPLEABUSE",
    "SEATROLLING",
    "24NOADMIN",
    "REWARDFUN",
    "NEWTROLL",
    "fudd10_v2",
    "Fudd10",
    "Bignews",
    "SECRET_ADMIN"
};
Tabs.Misc:AddButton({
    Title = "Nhập Hết",
    Description = "",
    Callback = function()
        for v559, v560 in ipairs(RedeemCodes) do
            RedeemCode(v560);
        end
    end
});
function RedeemCode(code)
    game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code);
end
local _section = Tabs.Misc:AddSection("Danh Hiệu");
Tabs.Misc:AddButton({
    Title = "Danh Hiệu",
    Description = "",
    Callback = function()
        local v378 = {
            [1] = "getTitles"
        };
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v378));
        game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true;
    end
});
local _section = Tabs.Misc:AddSection("Thức Tỉnh");
Tabs.Misc:AddButton({
    Title = "Thức Tỉnh",
    Description = "",
    Callback = function()
        game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true;
    end
});
local _section = Tabs.Misc:AddSection("Khác");
local v151 = Tabs.Misc:AddToggle("ToggleRejoin", {
    Title = "Tham Gia Máy Chủ Lại",
    Description = "",
    Default = true
});
v151:OnChanged(function(v381)
    _G.AutoRejoin = v381;
end);
Options.ToggleRejoin:SetValue(true);
spawn(function()
    while wait() do
        if _G.AutoRejoin then
            getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(v808)
                if ((v808.Name == "ErrorPrompt") and v808:FindFirstChild("MessageArea") and v808.MessageArea:FindFirstChild("ErrorFrame")) then
                    game:GetService("TeleportService"):Teleport(game.PlaceId);
                end
            end);
        end
    end
end);
local _section = Tabs.Misc:AddSection("Sương");
local function RemoveFog()
    local v382 = game:GetService("Lighting");
    if v382:FindFirstChild("BaseAtmosphere") then
        v382.BaseAtmosphere:Destroy();
    end
    if v382:FindFirstChild("SeaTerrorCC") then
        v382.SeaTerrorCC:Destroy();
    end
    if v382:FindFirstChild("LightingLayers") then
        if v382.LightingLayers:FindFirstChild("Atmosphere") then
            v382.LightingLayers.Atmosphere:Destroy();
        end
        wait();
        if v382.LightingLayers:FindFirstChild("DarkFog") then
            v382.LightingLayers.DarkFog:Destroy();
        end
    end
    v382.FogEnd = 100000;
end
Tabs.Misc:AddButton({
    Title = "Xóa Sương Mù",
    Description = "",
    Callback = function()
        RemoveFog();
    end
});
local AntiBandToggle = Tabs.Misc:AddToggle("ToggleAntiBand", {
    Title = "Chống Band",
    Description = "",
    Default = true
});
AntiBandToggle:OnChanged(function(v384)
    _G.AntiBand = v384;
end);
local BannedUserIds = {
    17884881,
    120173604,
    912348
};
spawn(function()
    while wait() do
        if _G.AntiBand then
            for v809, v810 in pairs(game:GetService("Players"):GetPlayers()) do
                if table.find(BannedUserIds, v810.UserId) then
                    Hop();
                end
            end
        end
    end
end);
local _section = Tabs.Sea:AddSection("Leviathan");
Tabs.Sea:AddButton({
    Title = "Mua Chip Leviathan",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2");
    end
});
local TweenFrozenToggle = Tabs.Sea:AddToggle("ToggleTPFrozenDimension", {
    Title = "Bay Đến Đảo Leviathan",
    Description = "",
    Default = false
});
TweenFrozenToggle:OnChanged(function(v385)
    _G.TweenToFrozenDimension = v385;
end);
TweenFrozenToggle:SetValue(false);
spawn(function()
    local v386;
    while not v386 do
        v386 = game:GetService("Workspace").Map:FindFirstChild("FrozenDimension");
        wait();
    end
    while wait() do
        if _G.TweenToFrozenDimension then
            if v386 then
                Tween(v386.CFrame);
            end
        end
    end
end);
if Sea3 then
    local v561 = Tabs.Sea:AddParagraph({
        Title = "Trạng Thái Chip Leviathan",
        Content = ""
    });
    spawn(function()
        pcall(function()
            while wait() do
                local v811 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "1");
                if (v811 == 5) then
                    v561:SetDesc("Leviathan Is Out There");
                elseif (v811 == 0) then
                    v561:SetDesc("I Don't Know");
                else
                    v561:SetDesc("Mua: " .. tostring(v811));
                end
            end
        end);
    end);
end
local v156 = Tabs.Sea:AddSection("Draco");
local BlazeEmberToggle = Tabs.Sea:AddToggle("ToggleBlazeEmber", {
    Title = "Lụm Lửa Đỏ",
    Description = "",
    Default = false
});
BlazeEmberToggle:OnChanged(function(v387)
    _G.AutoBlazeEmber = v387;
end);
spawn(function()
    while wait() do
        if _G.AutoBlazeEmber then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/DragonDojoEmber"):FireServer();
            end);
        end
    end
end);
local ReceiveQuestToggle = Tabs.Sea:AddToggle("ToggleReceiveQuest", {
    Title = "Nhận Nhiệm Vụ Lửa Đỏ",
    Description = "Bật Lên 1 Lần Là Nhận 1 Nhận Nữa Thì Tắt Bật Lại",
    Default = false
});
ReceiveQuestToggle:OnChanged(function(v388)
    _G.AutoReceiveQuest = v388;
    if _G.AutoReceiveQuest then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906));
        Tween2(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938));
        spawn(function()
            pcall(function()
                while wait() do
                    local v874 = {
                        [1] = {
                            Context = "RequestQuest"
                        }
                    };
                    game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/DragonHunter"):InvokeServer(unpack(v874));
                    local v875 = {
                        [1] = {
                            Context = "Check"
                        }
                    };
                    local v876 = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/DragonHunter"):InvokeServer(unpack(v875));
                end
            end);
        end);
    end
end);
local QuestStatusParagraph = Tabs.Sea:AddParagraph({
    Title = "Trạng Thái Nhiệm Vụ Lửa Đỏ",
    Content = ""
});
spawn(function()
    pcall(function()
        while wait() do
            local v654 = {
                [1] = {
                    Context = "Check"
                }
            };
            local v655 = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/DragonHunter"):InvokeServer(unpack(v654));
            if (typeof(v655) == "table") then
                for v877, v878 in pairs(v655) do
                    if (v878 == "Defeat 3 Venomous Assailants on Hydra Island.") then
                        QuestStatusParagraph:SetDesc("Defeat 3 Venomous Assailants on Hydra Island.");
                    elseif (v878 == "Defeat 3 Hydra Enforcers on Hydra Island.") then
                        QuestStatusParagraph:SetDesc("Defeat 3 Hydra Enforcers on Hydra Island.");
                    elseif (v878 == "Destroy 10 trees on Hydra Island.") then
                        QuestStatusParagraph:SetDesc("Destroy 10 trees on Hydra Island.");
                    end
                end
            else
                print(v655);
            end
        end
    end);
end);
local HydraTreeToggle = Tabs.Sea:AddToggle("ToggleHydraTree", {
    Title = "Phá Cây Ở Đảo Hydra",
    Description = "",
    Default = false
});
HydraTreeToggle:OnChanged(function(v389)
    _G.AutoHydraTree = v389;
end);
local function PressKey(key)
    local v391 = game:GetService("VirtualInputManager");
    v391:SendKeyEvent(true, key, false, game);
    v391:SendKeyEvent(false, key, false, game);
end
local function EquipAndUseTool(toolType)
    local v393 = game.Players.LocalPlayer;
    local v394 = v393.Backpack;
    for v562, v563 in pairs(v394:GetChildren()) do
        if (v563:IsA("Tool") and (v563.ToolTip == toolType)) then
            v563.Parent = v393.Character;
            for v812, v813 in ipairs({
                "Z",
                "X",
                "C",
                "V",
                "F"
            }) do
                wait();
                pcall(function()
                    PressKey(v813);
                end);
            end
            v563.Parent = v394;
            break;
        end
    end
end
local HydraTreePositions = {
    CFrame.new(5288.61962890625, 1005.4000244140625, 392.43011474609375),
    CFrame.new(5343.39453125, 1004.1998901367188, 361.0687561035156),
    CFrame.new(5235.78564453125, 1004.1998901367188, 431.4530944824219),
    CFrame.new(5321.30615234375, 1004.1998901367188, 440.8951416015625),
    CFrame.new(5258.96484375, 1004.1998901367188, 345.5052490234375)
};
spawn(function()
    while wait() do
        if _G.AutoHydraTree then
            AutoHaki();
            for v814, v815 in ipairs(HydraTreePositions) do
                if not _G.AutoHydraTree then
                    break;
                end
                Tween2(v815);
                wait();
                local v816 = game.Players.LocalPlayer.Character;
                if (v816 and v816:FindFirstChild("HumanoidRootPart")) then
                    local v902 = (v816.HumanoidRootPart.Position - v815.Position).Magnitude;
                    if (v902 <= 1) then
                        EquipAndUseTool("Melee");
                        EquipAndUseTool("Sword");
                        EquipAndUseTool("Gun");
                    end
                end
            end
        end
    end
end);
v156:AddButton({
    Title = "Bay Đến Khu Vực Dragon Dojo",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906));
        Tween2(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938));
    end
});
v156:AddButton({
    Title = "Chế Tạo Volcanic Magnet",
    Description = "",
    Callback = function()
        local v395 = {
            [1] = "CraftItem",
            [2] = "Craft",
            [3] = "Volcanic Magnet"
        };
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v395));
    end
});
local v164 = Tabs.Sea:AddToggle("ToggleCollectFireFlowers", {
    Title = "Lụm Hoa Đỏ",
    Description = "",
    Default = false
});
v164:OnChanged(function(v396)
    _G.AutoCollectFireFlowers = v396;
end);
spawn(function()
    while wait() do
        if _G.AutoCollectFireFlowers then
            local v747 = workspace:FindFirstChild("FireFlowers");
            if v747 then
                for v903, v904 in pairs(v747:GetChildren()) do
                    if (v904:IsA("Model") and v904.PrimaryPart) then
                        local v1367 = v904.PrimaryPart.Position;
                        local v1368 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                        local v1369 = (v1367 - v1368).Magnitude;
                        if (v1369 <= 1) then
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game);
                            wait(1.5);
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game);
                        else
                            Tween2(CFrame.new(v1367));
                        end
                    end
                end
            end
        end
    end
end);
local v165 = Tabs.Sea:AddToggle("ToggleWhiteBelt", {
    Title = "Cày Đai Trắng",
    Description = "",
    Default = false
});
v165:OnChanged(function(v397)
    _G.AutoLevel = v397;
    if v397 then
        local v656 = {
            [1] = {
                NPC = "Dojo Trainer",
                Command = "RequestQuest"
            }
        };
        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v656));
        spawn(function()
            while _G.AutoLevel do
                local v817 = {
                    [1] = {
                        NPC = "Dojo Trainer",
                        Command = "ClaimQuest"
                    }
                };
                game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v817));
                wait();
            end
        end);
    end
end);
local v166 = Tabs.Sea:AddParagraph({
    Title = "Hoàn Thành Ải Draco V4 (Sớm Ra)",
    Content = ""
});
local v167 = Tabs.Sea:AddToggle("ToggleTrialTeleport", {
    Title = "Bay Đến Cửa Trial Tộc Draco",
    Description = "",
    Default = false
});
v167:OnChanged(function(v398)
    _G.AutoTrialTeleport = v398;
end);
spawn(function()
    while wait() do
        if _G.AutoTrialTeleport then
            local v748 = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport");
            if (v748 and v748:IsA("Part")) then
                Tween2(CFrame.new(v748.Position));
            end
        end
    end
end);
local v168 = Tabs.Sea:AddSection("Đảo Dung Nham");
local v169 = Tabs.Sea:AddParagraph({
    Title = "Trạng Thái Đảo Dung Nham",
    Content = ""
});
spawn(function()
    pcall(function()
        while wait() do
            if ggame:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
                v169:SetDesc("Đảo Dung Nham: ✅️");
            else
                v169:SetDesc("Đảo Dung Nham: ❌️");
            end
        end
    end);
end);
local v170 = Tabs.Sea:AddToggle("ToggleTPVolcano", {
    Title = "Bay Đến Đảo Dung Nham",
    Description = "",
    Default = false
});
v170:OnChanged(function(v399)
    _G.TweenToPrehistoric = v399;
end);
Options.ToggleTPVolcano:SetValue(false);
spawn(function()
    local v400;
    while not v400 do
        v400 = game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland");
        wait();
    end
    while wait() do
        if _G.TweenToPrehistoric then
            local v749 = game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland");
            if v749 then
                local v879 = v749:FindFirstChild("Core") and v749.Core:FindFirstChild("PrehistoricRelic") ;
                local v880 = v879 and v879:FindFirstChild("Skull") ;
                if v880 then
                    Tween2(CFrame.new(v880.Position));
                    _G.TweenToPrehistoric = false;
                end
            end
        end
    end
end);
local v171 = Tabs.Sea:AddToggle("ToggleDefendVolcano", {
    Title = "Phòng Thủ",
    Description = "",
    Default = false
});
v171:OnChanged(function(v401)
    _G.AutoDefendVolcano = v401;
end);
local v107 = Tabs.Sea:AddToggle("ToggleMelee", {
    Title = "Dùng Melee",
    Description = "",
    Default = false
});
v107:OnChanged(function(v402)
    _G.UseMelee = v402;
end);
local v109 = Tabs.Sea:AddToggle("ToggleSword", {
    Title = "Dùng Sword",
    Description = "",
    Default = false
});
v109:OnChanged(function(v403)
    _G.UseSword = v403;
end);
local v110 = Tabs.Sea:AddToggle("ToggleGun", {
    Title = "Dùng Gun",
    Description = "",
    Default = false
});
v110:OnChanged(function(v404)
    _G.UseGun = v404;
end);
local function v172(v405)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, v405, false, game);
    game:GetService("VirtualInputManager"):SendKeyEvent(false, v405, false, game);
end
local function v173()
    local v406 = game.Workspace.Map.PrehistoricIsland.Core:FindFirstChild("InteriorLava");
    if (v406 and v406:IsA("Model")) then
        v406:Destroy();
    end
    local v407 = game.Workspace.Map:FindFirstChild("PrehistoricIsland");
    if v407 then
        for v750, v751 in pairs(v407:GetDescendants()) do
            if (v751:IsA("Part") and v751.Name:lower():find("lava")) then
                v751:Destroy();
            end
        end
    end
    local v408 = game.Workspace.Map:FindFirstChild("PrehistoricIsland");
    if v408 then
        for v752, v753 in pairs(v408:GetDescendants()) do
            if v753:IsA("Model") then
                for v905, v906 in pairs(v753:GetDescendants()) do
                    if (v906:IsA("MeshPart") and v906.Name:lower():find("lava")) then
                        v906:Destroy();
                    end
                end
            end
        end
    end
end
local function v174()
    local v409 = game.Workspace.Map.PrehistoricIsland.Core.VolcanoRocks;
    for v564, v565 in pairs(v409:GetChildren()) do
        if v565:IsA("Model") then
            local v754 = v565:FindFirstChild("volcanorock");
            if (v754 and v754:IsA("MeshPart")) then
                local v881 = v754.Color;
                if ((v881 == Color3.fromRGB(185, 53, 56)) or (v881 == Color3.fromRGB(185, 53, 57))) then
                    return v754;
                end
            end
        end
    end
    return nil;
end
local function EquipAndUseTool(v410)
    local v411 = game.Players.LocalPlayer;
    local v412 = v411.Backpack;
    for v566, v567 in pairs(v412:GetChildren()) do
        if (v567:IsA("Tool") and (v567.ToolTip == v410)) then
            v567.Parent = v411.Character;
            for v818, v819 in ipairs({
                "Z",
                "X",
                "C",
                "V",
                "F"
            }) do
                wait();
                pcall(function()
                    v172(v819);
                end);
            end
            v567.Parent = v412;
            break;
        end
    end
end
spawn(function()
    while wait() do
        if _G.AutoDefendVolcano then
            AutoHaki();
            pcall(v173);
            local v757 = v174();
            if v757 then
                local v882 = CFrame.new(v757.Position + Vector3.new(0, 0, 0));
                Tween2(v882);
                local v883 = v757.Color;
                if ((v883 ~= Color3.fromRGB(185, 53, 56)) and (v883 ~= Color3.fromRGB(185, 53, 57))) then
                    v757 = v174();
                else
                    local v1125 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                    local v1126 = ((v1125 - v757.Position) - Vector3.new(0, 0, 0)).Magnitude;
                    if (v1126 <= 1) then
                        if _G.UseMelee then
                            EquipAndUseTool("Melee");
                        end
                        if _G.UseSword then
                            EquipAndUseTool("Sword");
                        end
                        if _G.UseGun then
                            EquipAndUseTool("Gun");
                        end
                    end
                    _G.TweenToPrehistoric = false;
                end
            else
                _G.TweenToPrehistoric = true;
            end
        end
    end
end);
local v175 = Tabs.Sea:AddToggle("ToggleKillAura", {
    Title = "Đấm Golems Aura",
    Description = "",
    Default = false
});
v175:OnChanged(function(v413)
    KillAura = v413;
end);
Options.ToggleKillAura:SetValue(false);
spawn(function()
    while wait() do
        if KillAura then
            pcall(function()
                for _, descendant in pairs(game.Workspace.Enemies:GetDescendants()) do
                    if (v885:FindFirstChild("Humanoid") and v885:FindFirstChild("HumanoidRootPart") and (v885.Humanoid.Health > 0)) then
                        repeat
                            task.wait();
                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
                            v885.Humanoid.Health = 0;
                            v885.HumanoidRootPart.CanCollide = false;
                        until not KillAura or not v885.Parent or (v885.Humanoid.Health <= 0)
                    end
                end
            end);
        end
    end
end);
local v176 = Tabs.Sea:AddToggle("ToggleCollectBone", {
    Title = "Lụm Xương",
    Description = "",
    Default = false
});
v176:OnChanged(function(v414)
    _G.AutoCollectBone = v414;
end);
spawn(function()
    while wait() do
        if _G.AutoCollectBone then
            for v820, v821 in pairs(workspace:GetDescendants()) do
                if (v821:IsA("BasePart") and (v821.Name == "DinoBone")) then
                    Tween2(CFrame.new(v821.Position));
                end
            end
        end
    end
end);
local v177 = Tabs.Sea:AddToggle("ToggleCollectEgg", {
    Title = "Lụm Trứng",
    Description = "",
    Default = false
});
v177:OnChanged(function(v415)
    _G.AutoCollectEgg = v415;
end);
spawn(function()
    while wait() do
        if _G.AutoCollectEgg then
            local v758 = workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetChildren();
            if (# v758 > 0) then
                local v886 = v758[math.random(1, # v758)];
                if (v886:IsA("Model") and v886.PrimaryPart) then
                    Tween2(v886.PrimaryPart.CFrame);
                    local v1127 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                    local v1128 = v886.PrimaryPart.Position;
                    local v1129 = (v1127 - v1128).Magnitude;
                    if (v1129 <= 1) then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game);
                        wait(1.5);
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game);
                    end
                end
            end
        end
    end
end);
Fluent:Notify({
    Title = "Min Gaming",
    Content = "Tải Xong",
    Duration = 10
});
