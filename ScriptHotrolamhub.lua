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

    local createdElements = {} 
    local posCount = 0

    local isFrozen = false
    local freezeConnection = nil
    local frozenPosition = nil

    PlayerTab:AddToggle("FreezeToggle", {
        Title = "Đóng Băng Vị Trí Nhân Vật",
        Default = false,
        Callback = function(state)
            isFrozen = state
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if isFrozen then
                if hrp then
                    frozenPosition = hrp.Position
                end

                freezeConnection = RunService.RenderStepped:Connect(function()
                    if isFrozen and hrp and frozenPosition then
                        local currentRot = hrp.CFrame - hrp.Position
                        hrp.CFrame = CFrame.new(frozenPosition) * currentRot
                        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    end
                end)

                Fluent:Notify({
                    Title = "Đã Đóng Băng Vị Trí",
                    Content = "Nhân vật đứng yên, góc quay xoay tự do!",
                    Duration = 2
                })
            else
                if freezeConnection then
                    freezeConnection:Disconnect()
                    freezeConnection = nil
                end
                frozenPosition = nil

                Fluent:Notify({
                    Title = "Đã Mở Khóa",
                    Content = "Nhân vật di chuyển bình thường!",
                    Duration = 2
                })
            end
        end
    })

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
            
            local fullCFrameStr = string.format(
                "CFrame.new(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                tostring(x), tostring(y), tostring(z),
                tostring(r00), tostring(r01), tostring(r02),
                tostring(r10), tostring(r11), tostring(r12),
                tostring(r20), tostring(r21), tostring(r22)
            )

            local paragraphBox = PlayerTab:AddParagraph({
                Title = "Tọa Độ : " .. posCount,
                Content = fullCFrameStr
            })
            table.insert(createdElements, paragraphBox)

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
    -- TAB 2: LẤY TỌA ĐỘ QUÁI (LẤY TẤT CẢ & GỌN CFRAME.NEW(X,Y,Z))
    -------------------------------------------------------
    local MobTab = Tabs["MobPos"]

    local mobCreatedElements = {}
    local mobPosCount = 0
    local targetMobName = ""

    MobTab:AddInput("MobNameInput", {
        Title = "Nhập Tên Quái",
        Default = "",
        Placeholder = "Nhập tên quái cần tìm (VD: Bandit)...",
        Numeric = false,
        Finished = false,
        Callback = function(value)
            targetMobName = value
        end
    })

    MobTab:AddButton({
        Title = "Lấy Tọa Độ Quái",
        Description = "Tìm tất cả quái khớp tên và lấy tọa độ CFrame.new(x, y, z)",
        Callback = function()
            if targetMobName == "" then
                Fluent:Notify({
                    Title = "Lỗi",
                    Content = "Vui lòng nhập tên quái trước!",
                    Duration = 3
                })
                return
            end

            local foundMobs = {}

            local function scanFolder(parent)
                for _, obj in ipairs(parent:GetChildren()) do
                    if obj:IsA("Model") and string.find(string.lower(obj.Name), string.lower(targetMobName)) then
                        local hrp = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") or obj.PrimaryPart
                        local hum = obj:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            table.insert(foundMobs, {
                                Name = obj.Name,
                                Part = hrp
                            })
                        end
                    end
                end
            end

            local enemiesFolder = workspace:FindFirstChild("Enemies")
            if enemiesFolder then
                scanFolder(enemiesFolder)
            end
            scanFolder(workspace)

            if #foundMobs == 0 then
                Fluent:Notify({
                    Title = "Không Tìm Thấy",
                    Content = "Không tìm thấy con quái nào khớp với tên: " .. targetMobName,
                    Duration = 3
                })
                return
            end

            for _, mob in ipairs(foundMobs) do
                mobPosCount = mobPosCount + 1
                local pos = mob.Part.Position
                local posStr = string.format("CFrame.new(%s, %s, %s)", tostring(pos.X), tostring(pos.Y), tostring(pos.Z))

                local paragraphBox = MobTab:AddParagraph({
                    Title = mob.Name .. " [" .. mobPosCount .. "]",
                    Content = posStr
                })
                table.insert(mobCreatedElements, paragraphBox)

                local copyButton = MobTab:AddButton({
                    Title = "Sao Chép: " .. mob.Name .. " [" .. mobPosCount .. "]",
                    Description = posStr,
                    Callback = function()
                        if setclipboard then
                            setclipboard(posStr)
                            Fluent:Notify({
                                Title = "Thành công",
                                Content = "Đã sao chép tọa độ: " .. posStr,
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
                table.insert(mobCreatedElements, copyButton)
            end

            Fluent:Notify({
                Title = "Thành công",
                Content = "Đã tìm thấy và lấy tọa độ của " .. #foundMobs .. " con quái!",
                Duration = 3
            })
        end
    })

    MobTab:AddButton({
        Title = "Xóa Tọa Độ Quái",
        Description = "Xóa toàn bộ các bảng tọa độ quái đã tạo bên dưới",
        Callback = function()
            for _, element in ipairs(mobCreatedElements) do
                pcall(function() element:Destroy() end)
            end
            mobCreatedElements = {}
            mobPosCount = 0

            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã xóa toàn bộ danh sách tọa độ quái!",
                Duration = 2
            })
        end
    })

    -------------------------------------------------------
    -- TAB 3: LẤY TỌA ĐỘ NPC
    -------------------------------------------------------
    local NpcTab = Tabs["NPCPos"]

    local npcCreatedElements = {}
    local npcPosCount = 0
    local targetNpcName = ""

    NpcTab:AddInput("NpcNameInput", {
        Title = "Nhập Tên NPC",
        Default = "",
        Placeholder = "Nhập tên NPC cần tìm (VD: Adventurer)...",
        Numeric = false,
        Finished = false,
        Callback = function(value)
            targetNpcName = value
        end
    })

    NpcTab:AddButton({
        Title = "Lấy Tọa Độ NPC",
        Description = "Tìm tất cả NPC khớp tên và lấy tọa độ CFrame.new(x, y, z)",
        Callback = function()
            if targetNpcName == "" then
                Fluent:Notify({
                    Title = "Lỗi",
                    Content = "Vui lòng nhập tên NPC trước!",
                    Duration = 3
                })
                return
            end

            local foundNpcs = {}

            local function scanNpcFolder(parent)
                for _, obj in ipairs(parent:GetChildren()) do
                    if obj:IsA("Model") and string.find(string.lower(obj.Name), string.lower(targetNpcName)) then
                        local hrp = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") or obj.PrimaryPart
                        if hrp then
                            table.insert(foundNpcs, {
                                Name = obj.Name,
                                Part = hrp
                            })
                        end
                    end
                end
            end

            local npcFolder = workspace:FindFirstChild("NPCs") or workspace:FindFirstChild("NPC")
            if npcFolder then
                scanNpcFolder(npcFolder)
            end
            scanNpcFolder(workspace)

            if #foundNpcs == 0 then
                Fluent:Notify({
                    Title = "Không Tìm Thấy",
                    Content = "Không tìm thấy NPC nào khớp với tên: " .. targetNpcName,
                    Duration = 3
                })
                return
            end

            for _, npc in ipairs(foundNpcs) do
                npcPosCount = npcPosCount + 1
                local pos = npc.Part.Position
                local posStr = string.format("CFrame.new(%s, %s, %s)", tostring(pos.X), tostring(pos.Y), tostring(pos.Z))

                local paragraphBox = NpcTab:AddParagraph({
                    Title = npc.Name .. " [" .. npcPosCount .. "]",
                    Content = posStr
                })
                table.insert(npcCreatedElements, paragraphBox)

                local copyButton = NpcTab:AddButton({
                    Title = "Sao Chép: " .. npc.Name .. " [" .. npcPosCount .. "]",
                    Description = posStr,
                    Callback = function()
                        if setclipboard then
                            setclipboard(posStr)
                            Fluent:Notify({
                                Title = "Thành công",
                                Content = "Đã sao chép tọa độ NPC: " .. posStr,
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
                table.insert(npcCreatedElements, copyButton)
            end

            Fluent:Notify({
                Title = "Thành công",
                Content = "Đã tìm thấy và lấy tọa độ của " .. #foundNpcs .. " NPC!",
                Duration = 3
            })
        end
    })

    NpcTab:AddButton({
        Title = "Xóa Tọa Độ NPC",
        Description = "Xóa toàn bộ các bảng tọa độ NPC đã tạo bên dưới",
        Callback = function()
            for _, element in ipairs(npcCreatedElements) do
                pcall(function() element:Destroy() end)
            end
            npcCreatedElements = {}
            npcPosCount = 0

            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã xóa toàn bộ danh sách tọa độ NPC!",
                Duration = 2
            })
        end
    })

    -------------------------------------------------------
    -- TAB 4: BẮT SỰ KIỆN (REMOTE LOGGER)
    -------------------------------------------------------
    local EventTab = Tabs["EventListener"]
    local eventElements = {}
    local isListening = false
    local remoteNameFilter = ""
    local remoteLogCount = 0

    EventTab:AddInput("RemoteFilterInput", {
        Title = "Lọc Tên Remote (Tùy chọn)",
        Default = "",
        Placeholder = "Nhập từ khóa tên Remote...",
        Numeric = false,
        Finished = false,
        Callback = function(value)
            remoteNameFilter = value
        end
    })

    EventTab:AddToggle("ListenRemoteToggle", {
        Title = "Bật/Tắt Lắng Nghe RemoteEvent",
        Default = false,
        Callback = function(state)
            isListening = state
            if isListening then
                Fluent:Notify({
                    Title = "Đang Bắt Sự Kiện",
                    Content = "Đã bật theo dõi các RemoteEvent được gọi!",
                    Duration = 2
                })
            else
                Fluent:Notify({
                    Title = "Đã Dừng",
                    Content = "Đã tắt theo dõi RemoteEvent.",
                    Duration = 2
                })
            end
        end
    })

    pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if isListening and (method == "FireServer" or method == "InvokeServer") and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
                local name = self.Name
                if remoteNameFilter == "" or string.find(string.lower(name), string.lower(remoteNameFilter)) then
                    remoteLogCount = remoteLogCount + 1
                    local args = {...}
                    local argString = ""
                    pcall(function()
                        for i, v in ipairs(args) do
                            argString = argString .. "[" .. i .. "]: " .. tostring(v) .. " "
                        end
                    end)
                    
                    if remoteLogCount <= 25 then
                        local pBox = EventTab:AddParagraph({
                            Title = "Log #" .. remoteLogCount .. " (" .. method .. ")",
                            Content = "Tên: " .. name .. "\nTham số: " .. argString
                        })
                        table.insert(eventElements, pBox)
                    end
                end
            end
            return oldNamecall(self, ...)
        end)
    end)

    EventTab:AddButton({
        Title = "Xóa Log Sự Kiện",
        Description = "Xóa danh sách các Remote đã bắt được",
        Callback = function()
            for _, el in ipairs(eventElements) do
                pcall(function() el:Destroy() end)
            end
            eventElements = {}
            remoteLogCount = 0
            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã dọn sạch bảng log sự kiện!",
                Duration = 2
            })
        end
    })
end

BuildUI()

---------------------------------------
-- KHỞI CHẠY MENU
---------------------------------------
Fluent:Notify({
    Title = "Fat Cat Hub",
    Content = "Tải Xong - Tool Dev đã sẵn sàng!",
    Duration = 5
})
