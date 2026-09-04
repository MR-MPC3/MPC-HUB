-----------------------------------------------------------
-- SERVICES KHAI BÁO 1 LẦN DƯỚI CHỈ VIỆC GỌI SÀI
-----------------------------------------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local ParentGui = (gethui and gethui()) or CoreGui
local plr = Players.LocalPlayer

---------------------------
-- KIỂM TRA MAP
---------------------------
local MAP_SEAS = {
    [85211729168715] = 1,
    [79091703265657] = 2,
    [100117331123089] = 3
}

local currentSea = MAP_SEAS[game.PlaceId]
if not currentSea then
    plr:Kick("PlaceId không hợp lệ!")
    return
end

-------------------------
-- CLEANUP OLD GUI
-------------------------
pcall(function()
    if ParentGui:FindFirstChild("FatCatToggle") then ParentGui.FatCatToggle:Destroy() end
end)

-------------------------
-- THƯ VIỆN FLUENT UI
-------------------------
local success, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MR-MPC3/Fluent/master/main.lua"))()
end)

if not success or not Fluent then
    error("[Fat Cat Hub] Không thể tải Fluent UI! Hãy kiểm tra lại kết nối mạng hoặc Executor")
end

local Window = Fluent:CreateWindow({
    Title = "Fat Cat Hub - Tool Dev", 
    SubTitle = "Lấy Tọa Độ & Bắt Sự Kiện", 
    TabWidth = 180, 
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(560, 360), 
})

pcall(function()
    if Window.Root then
        Window.Root.Visible = false
    end
end)

-------------------------------------------------------
-- TOGGLE BUTTON (NÚT ẨN/HIỆN MENU & KÉO THẢ)
-------------------------------------------------------
local FatCatGui = Instance.new("ScreenGui")
FatCatGui.Name = "FatCatToggle"
FatCatGui.ResetOnSpawn = false
FatCatGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FatCatGui.Parent = ParentGui

local FatCatButton = Instance.new("ImageButton")
FatCatButton.Name = "FatCatButton"
FatCatButton.BackgroundColor3 = Color3.fromRGB(15,15,15)
FatCatButton.BorderSizePixel = 0
FatCatButton.Position = UDim2.fromOffset(45,85)
FatCatButton.AnchorPoint = Vector2.new(.5,.5)
FatCatButton.Size = UDim2.fromOffset(50,50)
FatCatButton.Image = "rbxassetid://13717478897"
FatCatButton.AutoButtonColor = false
FatCatButton.Parent = FatCatGui

Instance.new("UICorner", FatCatButton).CornerRadius = UDim.new(1,0)

local Scale = Instance.new("UIScale", FatCatButton)
local ButtonTween = nil
local Dragging = false
local DragStart = nil
local StartPos = nil
local IsDragged = false
local AnimationId = 0

local function StopButtonTween()
    if ButtonTween then
        pcall(function() ButtonTween:Cancel() end)
        ButtonTween = nil
    end
end

local function AnimateButton(scale, time, style)
    StopButtonTween()
    ButtonTween = TweenService:Create(Scale, TweenInfo.new(time, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = scale})
    ButtonTween:Play()
end

local function BounceButton()
    AnimationId = AnimationId + 1
    local id = AnimationId
    AnimateButton(.82, .08)
    task.delay(.08, function()
        if id ~= AnimationId or Dragging then return end
        AnimateButton(1.08, .16, Enum.EasingStyle.Back)
        task.delay(.16, function()
            if id ~= AnimationId or Dragging then return end
            AnimateButton(1, .12)
        end)
    end)
end

FatCatButton.InputBegan:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
    Dragging = true
    IsDragged = false
    DragStart = input.Position
    StartPos = FatCatButton.Position
    AnimationId = AnimationId + 1
    AnimateButton(.88, .12)
end)

UserInputService.InputChanged:Connect(function(input)
    if not Dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
    local delta = input.Position - DragStart
    if delta.Magnitude > 6 then IsDragged = true end
    if IsDragged then
        FatCatButton.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if not Dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
    Dragging = false
    AnimationId = AnimationId + 1
    AnimateButton(1.08, .18, Enum.EasingStyle.Back)
    local id = AnimationId
    task.delay(.18, function()
        if id ~= AnimationId or Dragging then return end
        AnimateButton(1, .12)
    end)
end)

local MenuVisible = false
FatCatButton.Activated:Connect(function()
    if IsDragged then
        IsDragged = false
        return
    end
    BounceButton()
    MenuVisible = not MenuVisible
    pcall(function()
        if Window and Window.Root then Window.Root.Visible = MenuVisible end
    end)
end)

---------------------
-- CÁC TABS CHÍNH
---------------------
local TabDefinitions = {
    {"PlayerPos", "Lấy Tọa Độ Nhân Vật", "user"},
    {"MobPos", "Lấy Tọa Độ Quái", "swords"},
    {"NPCPos", "Lấy Tọa Độ NPC", "map-pin"},
    {"EventListener", "Bắt Sự Kiện", "activity"}
}

local Tabs = {}
for _, tab in ipairs(TabDefinitions) do
    local ok, result = pcall(Window.AddTab, Window, {Title = tab[2], Icon = tab[3]})
    if not ok or not result then
        result = Window:AddTab({Title = tab[2]})
    end
    Tabs[tab[1]] = result
end

----------------------------
-- BUILD UI 
----------------------------
function BuildUI()
    -------------------------------------------------------
    -- TAB 1: LẤY TỌA ĐỘ NHÂN VẬT
    -------------------------------------------------------
    local PlayerTab = Tabs["PlayerPos"]

    local createdElements = {} -- Lưu trữ các bảng và nút để sau này bấm Xóa có thể dọn sạch
    local posCount = 0

    -- Biến quản lý trạng thái đóng băng
    local isFrozen = false
    local freezeConnection = nil
    local frozenCFrame = nil

    -- Nút Gạt Đóng Băng Nhân Vật
    PlayerTab:AddToggle("FreezeToggle", {
        Title = "Đóng Băng Nhân Vật & Góc Quay",
        Description = "Giữ nguyên vị trí và hướng nhìn cố định, không thể di chuyển",
        Default = false,
        Callback = function(state)
            isFrozen = state
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")

            if isFrozen then
                if hrp then
                    frozenCFrame = hrp.CFrame
                    hrp.Anchored = true
                end
                if humanoid then
                    humanoid.PlatformStand = true
                end

                -- Chạy ngầm liên tục để ép chặt vị trí và góc quay nếu có lực tác động đẩy đi
                freezeConnection = RunService.RenderStepped:Connect(function()
                    if isFrozen and hrp and frozenCFrame then
                        hrp.CFrame = frozenCFrame
                    end
                end)

                Fluent:Notify({
                    Title = "Đã Đóng Băng",
                    Content = "Nhân vật và góc quay đã được khóa cố định!",
                    Duration = 2
                })
            else
                -- Hủy đóng băng, trả lại trạng thái bình thường
                if freezeConnection then
                    freezeConnection:Disconnect()
                    freezeConnection = nil
                end
                if hrp then
                    hrp.Anchored = false
                end
                if humanoid then
                    humanoid.PlatformStand = false
                end
                frozenCFrame = nil

                Fluent:Notify({
                    Title = "Đã Mở Khóa",
                    Content = "Nhân vật đã hoạt động bình thường trở lại!",
                    Duration = 2
                })
            end
        end
    })

    -- 1. Nút lấy tọa độ nhân vật và góc quay (nằm trên cùng)
    PlayerTab:AddButton({
        Title = "Lấy Tọa Độ Nhân Vật Và Góc Quay",
        Description = "Tạo một bảng lưu CFrame chuẩn xác không làm tròn",
        Callback = function()
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then
                Fluent:Notify({
                    Title = "Lỗi",
                    Content = "Không tìm thấy HumanoidRootPart của nhân vật!",
                    Duration = 3
                })
                return
            end

            posCount = posCount + 1
            local cf = hrp.CFrame
            local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cf:GetComponents()
            
            -- Chuỗi CFrame đầy đủ, chính xác tuyệt đối không làm tròn
            local fullCFrameStr = string.format(
                "CFrame.new(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                tostring(x), tostring(y), tostring(z),
                tostring(r00), tostring(r01), tostring(r02),
                tostring(r10), tostring(r11), tostring(r12),
                tostring(r20), tostring(r21), tostring(r22)
            )

            -- Tạo Bảng (Paragraph) hiển thị đúng định dạng bạn muốn
            local paragraphBox = PlayerTab:AddParagraph({
                Title = "Tọa Độ : " .. posCount,
                Content = fullCFrameStr
            })
            table.insert(createdElements, paragraphBox)

            -- Tạo Nút Sao Chép ngay dưới bảng đó
            local copyButton = PlayerTab:AddButton({
                Title = "Sao Chép Tọa Độ",
                Description = "Sao chép CFrame của Tọa Độ : " .. posCount,
                Callback = function()
                    if setclipboard then
                        setclipboard(fullCFrameStr)
                        Fluent:Notify({
                            Title = "Thành công",
                            Content = "Đã sao chép Tọa Độ : " .. posCount,
                            Duration = 3
                        })
                    else
                        Fluent:Notify({
                            Title = "Lỗi",
                            Content = "Executor không hỗ trợ setclipboard!",
                            Duration = 3
                        })
                    end
                end
            })
            table.insert(createdElements, copyButton)

            Fluent:Notify({
                Title = "Thành công",
                Content = "Đã tạo bảng Tọa Độ : " .. posCount,
                Duration = 2
            })
        end
    })

    -- 2. Nút Xóa Tọa Độ (dùng để dọn sạch toàn bộ các bảng đã tạo)
    PlayerTab:AddButton({
        Title = "Xóa Tọa Độ",
        Description = "Xóa toàn bộ các bảng tọa độ đã tạo bên dưới",
        Callback = function()
            for _, element in ipairs(createdElements) do
                pcall(function() element:Destroy() end)
            end
            createdElements = {}
            posCount = 0

            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã xóa toàn bộ danh sách tọa độ!",
                Duration = 2
            })
        end
    })

    -------------------------------------------------------
    -- TAB 2: LẤY TỌA ĐỘ QUÁI
    -------------------------------------------------------


    -------------------------------------------------------
    -- TAB 3: LẤY TỌA ĐỘ NPC
    -------------------------------------------------------


    -------------------------------------------------------
    -- TAB 4: BẮT SỰ KIỆN
    -------------------------------------------------------

end

BuildUI()

---------------------------------------
-- KHỞI CHẠY MENU
---------------------------------------
Fluent:Notify({
    Title = "Fat Cat Hub",
    Content = "Tải Xong - Đã Thêm Nút Đóng Băng Thành Công!",
    Duration = 5
})
