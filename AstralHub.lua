do
  ply = game.Players
  plr = ply.LocalPlayer
  Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  replicated = game:GetService("ReplicatedStorage")
  -- Lấy Level an toàn
  Lv = (plr:FindFirstChild("Data") and plr.Data:FindFirstChild("Level")) and plr.Data.Level.Value or 1
  TeleportService = game:GetService("TeleportService")
  TW = game:GetService("TweenService")
  Lighting = game:GetService("Lighting")  
  Enemies = workspace:FindFirstChild("Enemies")
  vim1 = game:GetService("VirtualInputManager")
  vim2 = game:GetService("VirtualUser")
  TeamSelf = plr.Team
  RunSer = game:GetService("RunService")
  Stats = game:GetService("Stats")  
  -- Năng lượng mặc định
  Energy = (plr.Character and plr.Character:FindFirstChild("Energy")) and plr.Character.Energy.Value or 0
  Boss = {}
  BringConnections = {}
  MaterialList = {}
  NPCList = {}  
  shouldTween = false
  SoulGuitar = false
  KenTest = true
  debug = false
  Brazier1 = false
  Brazier2 = false
  Brazier3 = false 
  lastAttackTick = 0
  Sec = 0.1
  ClickState = 0
  Num_self = 25
end

-- Cập nhật Root và Energy khi nhân vật xuất hiện / hồi sinh
local function UpdateCharacterData(char)
    if not char then return end
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if hrp then Root = hrp end
    local en = char:WaitForChild("Energy", 5)
    if en then Energy = en.Value end
end

if plr.Character then
    UpdateCharacterData(plr.Character)
end
plr.CharacterAdded:Connect(UpdateCharacterData)

-- Vòng lặp chờ game load an toàn có Timeout
local t0 = tick()
repeat 
  local main = plr.PlayerGui:FindFirstChild("Main")
  local loading = main and main:FindFirstChild("Loading")
  -- Thoát vòng lặp khi đã vào game hoàn toàn hoặc quá 15 giây
  if main and game:IsLoaded() and (not loading or tick() - t0 > 8) then
    break
  end
  task.wait(0.2)
until tick() - t0 > 15

local pid = tonumber(game.PlaceId) or game.PlaceId
-- Khai báo ID các Sea
World1 = (pid == 2753915549 or pid == 85211729168715)
World2 = (pid == 4442272183)
World3 = (pid == 7449423635)

-- Kiểm tra: Nếu không khớp với bất kỳ World nào thì mới KICK
Sea = World1 or World2 or World3
if not Sea then
    plr:Kick("❌ Error : A[12]Blox Fruits ❌ (ID lạ: " .. tostring(pid) .. ")")
end

Marines = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Marines") end
Pirates = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Pirates") end

if World1 then 
    Boss = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
elseif World2 then 
    Boss = {"Diamond","Jeremy","Fajita","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
elseif World3 then 
    Boss = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Longma","Soul Reaper"}
end

if World1 then 
    MaterialList = {"Leather + Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail"}
elseif World2 then 
    MaterialList = {"Leather + Scrap Metal", "Radioactive Material", "Ectoplasm", "Mystic Droplet", "Magma Ore", "Vampire Fang"}
elseif World3 then 
    MaterialList = {"Scrap Metal", "Demonic Wisp", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk"}
end

local DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
local RenMon = {"Snow Lurker","Arctic Warrior","Hidden Key","Awakened Ice Admiral"}
local CursedTables = {["Mob"] = "Mythological Pirate",["Mob2"] = "Cursed Skeleton","Hell's Messenger",["Mob3"] = "Cursed Skeleton","Heaven's Guardian"}
local Past = {"Part","SpawnLocation","Terrain","WedgePart","MeshPart"}
local BartMon = {"Swan Pirate","Jeremy"}
local CitizenTable = {"Forest Pirate","Captain Elephant"}
local Human_v3_Mob = {"Fajita","Jeremy","Diamond"}
local AllBoats = {"Beast Hunter","Lantern","Guardian","Grand Brigade","Dinghy","Sloop","The Sentinel"}
local mastery1 = {"Cookie Crafter"}
local mastery2 = {"Reborn Skeleton"}
local PosMsList = {
    ["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625),
    ["Pistol Billionaire"] = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625),
    ["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.76270294189453, -730.1290893554688),
    ["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),
    ["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),
    ["Venomous Assailant"] = CFrame.new(4902, 670, 39), 
    ["Marine Commodore"] = CFrame.new(2401, 123, -7589),
    ["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),
    ["Fishman Raider"] = CFrame.new(-10941, 332, -8760),
    ["Fishman Captain"] = CFrame.new(-11035, 332, -9087),
    ["Forest Pirate"] = CFrame.new(-13446, 413, -7760),
    ["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),
    ["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),
    ["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),
    ["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),
    ["Living Zombie"] = CFrame.new(-10227, 421, 6161),
    ["Demonic Soul"] = CFrame.new(-9579, 6, 6194),
    ["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),
    ["Peanut Scout"] = CFrame.new(-1993, 187, -10103),
    ["Peanut President"] = CFrame.new(-2215, 159, -10474),
    ["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),
    ["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),
    ["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),
    ["Cake Guard"] = CFrame.new(-2024, 38, -12026),
    ["Baking Staff"] = CFrame.new(-1932, 38, -12848),
    ["Head Baker"] = CFrame.new(-1932, 38, -12848),
    ["Cocoa Warrior"] = CFrame.new(95, 73, -12309),
    ["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),
    ["Sweet Thief"] = CFrame.new(116, 36, -12478),
    ["Candy Rebel"] = CFrame.new(47, 61, -12889),
    ["Ghost"] = CFrame.new(5251, 5, 1111)
}

EquipWeapon = function(text)
    if not text then return end
    local char = plr.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum or char:FindFirstChild(text) then return end
    local tool = plr.Backpack:FindFirstChild(text)
    if tool then
        hum:EquipTool(tool)
    end
end

weaponSc = function(weapon)
    if not weapon then return end
    local char = plr.Character
    if char then
        for _, v in ipairs(char:GetChildren()) do
            if v:IsA("Tool") and v.ToolTip == weapon then return end
        end
    end
    for _, v in ipairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == weapon then
            EquipWeapon(v.Name)
            return
        end
    end
end

pcall(function()
    hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function() end)
    hookfunction(require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule")).ChangeDisplayedNPC, function() end)
    hookfunction(error, function() end)
    hookfunction(warn, function() end)
end)

local Rock = workspace:FindFirstChild("Rocks")
if Rock then Rock:Destroy() end

local lighting = game:GetService("Lighting")
local lightingLayers = lighting:FindFirstChild("LightingLayers")
if lightingLayers then
    local darkFog = lightingLayers:FindFirstChild("DarkFog")
    if darkFog then darkFog:Destroy() end
end
local Water = workspace._WorldOrigin:FindFirstChild("Foam;")
if Water then Water:Destroy() end

local Attack = {}
Attack.__index = Attack
Attack.Alive = function(model) 
    if not model then return end 
    local Humanoid = model:FindFirstChild("Humanoid") 
    return Humanoid and Humanoid.Health > 0 
end
Attack.Pos = function(model, dist)
    if not model or not Root then return false end
    local pos = model:IsA("Model") and model:GetPivot().Position
        or (model:FindFirstChild("HumanoidRootPart") and model.HumanoidRootPart.Position)
        or model.Position
    if not pos then return false end
    return (Root.Position - pos).Magnitude <= dist
end
Attack.Dist = function(model, dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist end
Attack.DistH = function(model, dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist end

_G.UseAttackCooldown = true
_G.AttackCooldown = 0.12

local function GetEquippedTool()
    local char = plr.Character
    if not char then return nil end
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("Tool") then return v end
    end
    return nil
end

local function FindEnemiesInRange(tbl, list)
    local char = plr.Character
    if not char or not char.PrimaryPart then return nil end
    local myPos = char:GetPivot().Position
    local mainPart = nil
    for _, enemy in ipairs(list) do
        if not enemy:GetAttribute("IsBoat") then
            local hum = enemy:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local head = enemy:FindFirstChild("Head") or enemy:FindFirstChild("HumanoidRootPart")
                if head and (myPos - head.Position).Magnitude <= 120 then
                    if enemy ~= char then
                        table.insert(tbl, {enemy, head})
                        mainPart = head
                    end
                end
            end
        end
    end
    return mainPart
end

function AttackNoCoolDown()
    if _G.UseAttackCooldown then
        local cd = tonumber(_G.AttackCooldown) or 0.12
        if (tick() - lastAttackTick) < cd then return end
        lastAttackTick = tick()
    end

    if not GetEquippedTool() then
        weaponSc("Melee")
        if not GetEquippedTool() then return end
    end

    local targets = {}
    local mainPart = FindEnemiesInRange(targets, workspace.Enemies:GetChildren())
    if not mainPart or #targets == 0 then return end

    pcall(function()
        local Net = replicated:WaitForChild("Modules"):WaitForChild("Net")
        local RE_Attack = Net:FindFirstChild("RE/RegisterAttack")
        local RE_Hit = Net:FindFirstChild("RE/RegisterHit")
        if RE_Attack then
            RE_Attack:FireServer(0.5, 1)
        end
        if RE_Hit then
            RE_Hit:FireServer(mainPart, targets)
        end
    end)

    pcall(function()
        vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end)
end

-- Các phương thức Attack khác giữ nguyên logic cốt lõi
Attack.Kill = function(model, Succes)
    if not (model and Succes) then return end
    local hrp = model:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if not model:GetAttribute("Locked") then
        model:SetAttribute("Locked", hrp.CFrame)
    end
    PosMon = model:GetAttribute("Locked").Position
    BringEnemy()
    if _G.SelectWeapon then
        EquipWeapon(_G.SelectWeapon)
    else
        weaponSc(_G.ChooseWP or "Melee")
    end
    local char = plr.Character
    local Equipped = char and char:FindFirstChildOfClass("Tool")
    if not Equipped then
        weaponSc("Melee")
        Equipped = char and char:FindFirstChildOfClass("Tool")
    end
    if not Equipped then return end
    local ToolTip = Equipped.ToolTip
    if ToolTip == "Blox Fruit" then
        _tp(hrp.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0))
    else
        _tp(hrp.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(180), 0))
    end
    AttackNoCoolDown()
end

statsSetings = function(Num, value)
    if plr.Data.Points.Value ~= 0 then
        if Num == "Melee" or Num == "Defense" or Num == "Sword" or Num == "Gun" or Num == "Devil" then
            local statName = (Num == "Devil") and "Demon Fruit" or Num
            replicated.Remotes.CommF_:InvokeServer("AddPoint", statName, value)
        end
    end
end

BringEnemy = function()
  if not _B then return end
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
	  if v.PrimaryPart and (v.PrimaryPart.Position - PosMon).Magnitude <= 300 then
	    v.PrimaryPart.CFrame = CFrame.new(PosMon)
		v.PrimaryPart.CanCollide = true;
		v:FindFirstChild("Humanoid").WalkSpeed = 0;
		v:FindFirstChild("Humanoid").JumpPower = 0;
		if v.Humanoid:FindFirstChild("Animator") then v.Humanoid.Animator:Destroy() end;
		plr.SimulationRadius = math.huge
	  end
	end                               
  end                    	
end

Useskills = function(weapon, skill)
  if weapon ~= "nil" then
      weaponSc(weapon)
  end
  if skill == "Y" then
      vim1:SendKeyEvent(true, "Y", false, game);
      vim1:SendKeyEvent(false, "Y", false, game);
  else
      vim1:SendKeyEvent(true, skill, false, game);
      vim1:SendKeyEvent(false, skill, false, game);
  end
end

local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
  local method = getnamecallmethod()
  local args = {...}
  if tostring(method) == "FireServer" then
    local remoteName = tostring(args[1])
    if not string.find(remoteName, "RegisterAttack") and not string.find(remoteName, "RegisterHit") then
      if (_G.FarmMastery_G and not SoulGuitar) or (_G.FarmMastery_Dev) or (_G.FarmBlazeEM) or (_G.Prehis_Skills)
        or (_G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials)
        or (_G.AimMethod and (ABmethod == "AimBots Skill" or ABmethod == "Auto Aimbots")) then
        if typeof(args[2]) ~= "boolean" and MousePos then
          args[2] = MousePos
          return old(unpack(args))
        end
      end
    end
  end
  return old(...)
end)

GetConnectionEnemies = function(a)
  for i,v in pairs(replicated:GetChildren()) do
    if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      return v
    end
  end
  for i,v in next,game.Workspace.Enemies:GetChildren() do
    if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      return v
    end
  end
end

Hop = function()
    pcall(function()
        for count = math.random(1, math.random(40, 75)), 100 do
            local remote = replicated.__ServerBrowser:InvokeServer(count)
            if remote then
                for jobId, v in next, remote do
                    if type(v) == "table" and tonumber(v.Count) and tonumber(v.Count) < 12 then
                        if tostring(jobId) ~= tostring(game.JobId) then
                            replicated.__ServerBrowser:InvokeServer("teleport", tostring(jobId))
                            return 
                        end
                    end
                end
            end
        end
    end)
end

local block = Instance.new("Part", workspace)
block.Size = Vector3.new(1, 1, 1)
block.Name = "Rip_Indra"
block.Anchored = true
block.CanCollide = false
block.CanTouch = false
block.Transparency = 1
local blockfind = workspace:FindFirstChild(block.Name)
if blockfind and blockfind ~= block then blockfind:Destroy() end

task.spawn(function()
    while task.wait() do 
        if block and block.Parent == workspace then 
            if shouldTween then getgenv().OnFarm = true else getgenv().OnFarm = false end 
        else 
            getgenv().OnFarm = false 
        end 
    end 
end)

task.spawn(function()
    local a = game.Players.LocalPlayer
    repeat task.wait() until a.Character and a.Character.PrimaryPart
    block.CFrame = a.Character.PrimaryPart.CFrame
    while task.wait() do 
        pcall(function()
            if getgenv().OnFarm then 
                if block and block.Parent == workspace then 
                    local b = a.Character and a.Character.PrimaryPart
                    if b and (b.Position - block.Position).Magnitude <= 200 then 
                        b.CFrame = block.CFrame 
                    else 
                        block.CFrame = b.CFrame 
                    end 
                end
                local c = a.Character
                if c then 
                    for d, e in pairs(c:GetChildren()) do 
                        if e:IsA("BasePart") then e.CanCollide = false end 
                    end 
                end 
            else 
                local c = a.Character
                if c then 
                    for d, e in pairs(c:GetChildren()) do 
                        if e:IsA("BasePart") then e.CanCollide = true end 
                    end 
                end 
            end 
        end)
    end 
end)

_tp = function(target)
  local character = plr.Character
  if not character or not character:FindFirstChild("HumanoidRootPart") then return end
  local rootPart = character.HumanoidRootPart
  local distance = (target.Position - rootPart.Position).Magnitude
  local tweenInfo = TweenInfo.new(distance / 220, Enum.EasingStyle.Linear)
  local tween = game:GetService("TweenService"):Create(block, tweenInfo, {CFrame = target})    
  if plr.Character.Humanoid.Sit == true then
    block.CFrame = CFrame.new(block.Position.X, target.Y, block.Position.Z)
  end  
  tween:Play()    
  task.spawn(function() while tween.PlaybackState == Enum.PlaybackState.Playing do if not shouldTween then tween:Cancel() break end task.wait(0.1) end end)
end

notween = function(p) plr.Character.HumanoidRootPart.CFrame = p end

function BTP(p)
    local player = game.Players.LocalPlayer
    local humanoidRootPart = player.Character.HumanoidRootPart
    local humanoid = player.Character.Humanoid
    local playerGui = player.PlayerGui.Main
    local lastPosition = humanoidRootPart.Position
    repeat
        humanoid.Health = 0
        humanoidRootPart.CFrame = p
        playerGui.Quest.Visible = false
        if (humanoidRootPart.Position - lastPosition).Magnitude > 1 then
            lastPosition = humanoidRootPart.Position
            humanoidRootPart.CFrame = p
        end
        task.wait(0.5)
    until (p.Position - humanoidRootPart.Position).Magnitude <= 2000
end
