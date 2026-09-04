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
-- HÀM HỖ TRỢ BAY ĐẾN TỌA ĐỘ (TWEEN)
---------------------------
local activeTween = nil
local function TweenTo(targetCFrame)
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    
    if activeTween then 
        pcall(function() activeTween:Cancel() end) 
    end
    
    hum.PlatformStand = true
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local speed = 300 -- Tốc độ bay (studs/s) - có thể tăng giảm tùy ý
    local duration = distance / speed
    if duration < 0.2 then duration = 0.2 end
    
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    activeTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    activeTween:Play()
    
    activeTween.Completed:Connect(function()
        hum.PlatformStand = false
        activeTween = nil
    end)
end

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
                Title = "Sao chép",
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
    -- TAB 2: LẤY TỌA ĐỘ QUÁI
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
        Description = "Tìm tất cả quái khớp tên, lấy tọa độ từng con và tính tọa độ tâm (MonCF)",
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
                    Title = "Sao chép",
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

                -- THÊM NÚT BAY ĐẾN ĐÂY NẰM DƯỚI NÚT SAO CHÉP
                local flyButton = MobTab:AddButton({
                    Title = "Bay đến đây",
                    Callback = function()
                        Fluent:Notify({
                            Title = "Đang di chuyển",
                            Content = "Đang bay đến " .. mob.Name,
                            Duration = 2
                        })
                        TweenTo(CFrame.new(pos))
                    end
                })
                table.insert(mobCreatedElements, flyButton)
            end

            local sumPos = Vector3.new(0, 0, 0)
            for _, mob in ipairs(foundMobs) do
                sumPos = sumPos + mob.Part.Position
            end
            local centerPos = sumPos / #foundMobs
            local monCfStr = string.format("MonCF = CFrame.new(%s, %s, %s)", tostring(centerPos.X), tostring(centerPos.Y), tostring(centerPos.Z))

            local centerParagraph = MobTab:AddParagraph({
                Title = "Tọa Độ Trung Tâm Bãi (MonCF)",
                Content = monCfStr
            })
            table.insert(mobCreatedElements, centerParagraph)

            local copyCenterBtn = MobTab:AddButton({
                Title = "Sao chép",
                Callback = function()
                    if setclipboard then
                        setclipboard(monCfStr)
                        Fluent:Notify({
                            Title = "Thành công",
                            Content = "Đã sao chép MonCF của bãi!",
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
            table.insert(mobCreatedElements, copyCenterBtn)

            -- NÚT BAY ĐẾN TÂM BÃI CHO MONCF
            local flyCenterBtn = MobTab:AddButton({
                Title = "Bay đến tâm bãi",
                Callback = function()
                    Fluent:Notify({
                        Title = "Đang di chuyển",
                        Content = "Đang bay đến tâm bãi quái",
                        Duration = 2
                    })
                    TweenTo(CFrame.new(centerPos))
                end
            })
            table.insert(mobCreatedElements, flyCenterBtn)

            Fluent:Notify({
                Title = "Thành công",
                Content = "Đã tìm thấy " .. #foundMobs .. " con quái và tính tọa độ tâm!",
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
    -- TAB 3: LẤY TỌA ĐỘ NPC & VẬT THỂ
    -------------------------------------------------------
    local NpcTab = Tabs["NPCPos"]

    local npcCreatedElements = {}
    local npcPosCount = 0
    local targetNpcName = ""

    NpcTab:AddInput("NpcNameInput", {
        Title = "Nhập Tên NPC / Vật Thể",
        Default = "",
        Placeholder = "Nhập tên cần tìm (VD: Set Home Point)...",
        Numeric = false,
        Finished = false,
        Callback = function(value)
            targetNpcName = value
        end
    })

    NpcTab:AddButton({
        Title = "Lấy Tọa Độ NPC",
        Description = "Tìm tất cả NPC/Vật thể khớp tên trên toàn bản đồ (Hỗ trợ cả Model và Part)",
        Callback = function()
            if targetNpcName == "" then
                Fluent:Notify({
                    Title = "Lỗi",
                    Content = "Vui lòng nhập tên cần tìm trước!",
                    Duration = 3
                })
                return
            end

            local foundNpcs = {}
            local checkedPositions = {}

            for _, obj in ipairs(workspace:GetDescendants()) do
                if string.find(string.lower(obj.Name), string.lower(targetNpcName)) then
                    local pos = nil

                    if obj:IsA("Model") then
                        local successPivot, pivotPos = pcall(function()
                            return obj:GetPivot().Position
                        end)
                        if successPivot and pivotPos then
                            pos = pivotPos
                        else
                            local part = obj:FindFirstChildWhichIsA("BasePart")
                            if part then pos = part.Position end
                        end
                    elseif obj:IsA("BasePart") then
                        pos = obj.Position
                    end

                    if pos then
                        local posKey = math.floor(pos.X / 5) .. "," .. math.floor(pos.Y / 5) .. "," .. math.floor(pos.Z / 5)
                        if not checkedPositions[posKey] then
                            checkedPositions[posKey] = true
                            table.insert(foundNpcs, {
                                Name = obj.Name,
                                Position = pos
                            })
                        end
                    end
                end
            end

            if #foundNpcs == 0 then
                Fluent:Notify({
                    Title = "Không Tìm Thấy",
                    Content = "Không tìm thấy đối tượng nào khớp với tên: " .. targetNpcName,
                    Duration = 3
                })
                return
            end

            for _, npc in ipairs(foundNpcs) do
                npcPosCount = npcPosCount + 1
                local pos = npc.Position
                local posStr = string.format("CFrame.new(%s, %s, %s)", tostring(pos.X), tostring(pos.Y), tostring(pos.Z))

                local paragraphBox = NpcTab:AddParagraph({
                    Title = npc.Name .. " [" .. npcPosCount .. "]",
                    Content = posStr
                })
                table.insert(npcCreatedElements, paragraphBox)

                local copyButton = NpcTab:AddButton({
                    Title = "Sao chép",
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
                table.insert(npcCreatedElements, copyButton)

                -- THÊM NÚT BAY ĐẾN ĐÂY NẰM DƯỚI NÚT SAO CHÉP Ở TAB NPC
                local flyButton = NpcTab:AddButton({
                    Title = "Bay đến đây",
                    Callback = function()
                        Fluent:Notify({
                            Title = "Đang di chuyển",
                            Content = "Đang bay đến " .. npc.Name,
                            Duration = 2
                        })
                        TweenTo(CFrame.new(pos))
                    end
                })
                table.insert(npcCreatedElements, flyButton)
            end

            Fluent:Notify({
                Title = "Thành công",
                Content = "Đã quét và tìm thấy " .. #foundNpcs .. " kết quả trên toàn bản đồ!",
                Duration = 3
            })
        end
    })

    NpcTab:AddButton({
        Title = "Xóa Tọa Độ NPC",
        Description = "Xóa toàn bộ các bảng tọa độ đã tạo bên dưới",
        Callback = function()
            for _, element in ipairs(npcCreatedElements) do
                pcall(function() element:Destroy() end)
            end
            npcCreatedElements = {}
            npcPosCount = 0

            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã xóa toàn bộ danh sách tọa độ!",
                Duration = 2
            })
        end
    })

    -------------------------------------------------------
    -- TAB 4: BẮT SỰ KIỆN
    -------------------------------------------------------
    local EventTab = Tabs["EventListener"]

    local EventLoggerEnabled = false
    local EventLogs = {}
    local EventCount = 0
    local MaxEventLogs = 100

    -------------------------------------------------------
    -- HÀM CẬP NHẬT BẢNG HIỂN THỊ
    -------------------------------------------------------
    local EventParagraph

    local function UpdateEventDisplay()
        if not EventParagraph then
            return
        end

        if #EventLogs == 0 then
            EventParagraph:SetDesc("Chưa có sự kiện nào...")
            return
        end

        EventParagraph:SetDesc(
            table.concat(EventLogs, "\n\n")
        )
    end

    -------------------------------------------------------
    -- HÀM GHI SỰ KIỆN
    -------------------------------------------------------
    local function AddEventLog(eventName, eventData)
        if not EventLoggerEnabled then
            return
        end

        EventCount = EventCount + 1

        local timeText = os.date("%H:%M:%S")

        local text =
            "[" .. EventCount .. "] " ..
            "[" .. timeText .. "] " ..
            tostring(eventName)

        if eventData ~= nil and tostring(eventData) ~= "" then
            text = text .. "\n" .. tostring(eventData)
        end

        table.insert(EventLogs, text)

        -------------------------------------------------------
        -- GIỚI HẠN TỐI ĐA 100 SỰ KIỆN
        -------------------------------------------------------
        if #EventLogs > MaxEventLogs then
            table.remove(EventLogs, 1)
        end

        UpdateEventDisplay()
    end

    -------------------------------------------------------
    -- 1. TOGGLE BẬT / TẮT BẮT SỰ KIỆN
    -------------------------------------------------------
    EventTab:AddToggle("EventLoggerToggle", {
        Title = "Bắt Sự Kiện",
        Description = "Bật để bắt và ghi lại các sự kiện",
        Default = false,

        Callback = function(value)
            EventLoggerEnabled = value

            if value then
                Fluent:Notify({
                    Title = "Bắt Sự Kiện",
                    Content = "Đã bật bắt sự kiện!",
                    Duration = 2
                })

                AddEventLog(
                    "LOGGER",
                    "Đã bắt đầu theo dõi sự kiện."
                )
            else
                Fluent:Notify({
                    Title = "Bắt Sự Kiện",
                    Content = "Đã tắt bắt sự kiện!",
                    Duration = 2
                })
            end
        end
    })

    -------------------------------------------------------
    -- 2. NÚT XÓA SỰ KIỆN
    -------------------------------------------------------
    EventTab:AddButton({
        Title = "Xóa Sự Kiện",
        Description = "Xóa toàn bộ sự kiện đang hiển thị",

        Callback = function()
            table.clear(EventLogs)
            EventCount = 0

            UpdateEventDisplay()

            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã xóa toàn bộ sự kiện!",
                Duration = 2
            })
        end
    })

    -------------------------------------------------------
    -- 3. BẢNG HIỂN THỊ SỰ KIỆN
    -------------------------------------------------------
    EventParagraph = EventTab:AddParagraph({
        Title = "Danh Sách Sự Kiện",
        Content = "Chưa có sự kiện nào..."
    })

    -------------------------------------------------------
    -- CÁC SỰ KIỆN CLIENT CƠ BẢN
    -------------------------------------------------------

    -- Nhân vật spawn / respawn
    plr.CharacterAdded:Connect(function(character)
        AddEventLog(
            "CharacterAdded",
            "Character: " .. character.Name
        )
    end)

    -------------------------------------------------------
    -- TOOL ĐƯỢC THÊM / XÓA
    -------------------------------------------------------
    local function HookBackpack()
        local backpack = plr:FindFirstChild("Backpack")

        if not backpack then
            return
        end

        backpack.ChildAdded:Connect(function(child)
            AddEventLog(
                "Backpack.ChildAdded",
                "Tên: " .. child.Name ..
                "\nClass: " .. child.ClassName
            )
        end)

        backpack.ChildRemoved:Connect(function(child)
            AddEventLog(
                "Backpack.ChildRemoved",
                "Tên: " .. child.Name ..
                "\nClass: " .. child.ClassName
            )
        end)
    end

    HookBackpack()

    -------------------------------------------------------
    -- QUÁI SPAWN / BIẾN MẤT
    -------------------------------------------------------
    local EnemiesFolder = workspace:FindFirstChild("Enemies")

    if EnemiesFolder then
        EnemiesFolder.ChildAdded:Connect(function(enemy)
            AddEventLog(
                "Enemy Spawn",
                "Tên: " .. enemy.Name
            )
        end)

        EnemiesFolder.ChildRemoved:Connect(function(enemy)
            AddEventLog(
                "Enemy Removed",
                "Tên: " .. enemy.Name
            )
        end)
    end
    
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
