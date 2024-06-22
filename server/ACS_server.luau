local Engine = game.ReplicatedStorage:WaitForChild("ACS_Engine")
local Evt = Engine:WaitForChild("Eventos")
local Mod = Engine:WaitForChild("Modulos")
local GunModels = Engine:WaitForChild("GunModels")
local GunModelClient = GunModels:WaitForChild("Client")
local GunModelServer = GunModels:WaitForChild("Server")
local Ultil = require(Mod:WaitForChild("Utilities"))
local ServerConfig = require(Engine.ServerConfigs:WaitForChild("Config"))

local Players = game.Players
local ACS_Storage = workspace:WaitForChild("ACS_WorkSpace")


local Debris = game:GetService("Debris")

local Left_Weld, Right_Weld,RA,LA,RightS,LeftS,HeadBase,HW,HW2
local AnimBase,AnimBaseW,NeckW

local RS = game:GetService("RunService")

local Glass = {"1565824613"; "1565825075";}
local Metal = {"282954522"; "282954538"; "282954576"; "1565756607"; "1565756818";}
local Grass = {"1565830611"; "1565831129"; "1565831468"; "1565832329";}
local Wood = {"287772625"; "287772674"; "287772718"; "287772829"; "287772902";}
local Concrete = {"287769261"; "287769348"; "287769415"; "287769483"; "287769538";}
local Explosion = {"287390459"; "287390954"; "287391087"; "287391197"; "287391361"; "287391499"; "287391567";}
local Cracks = {"342190504"; "342190495"; "342190488"; "342190510";} -- Bullet Cracks
local Hits = {"363818432"; "363818488"; "363818567"; "363818611"; "363818653";} -- Player
local Whizz = {"342190005"; "342190012"; "342190017"; "342190024";} -- Bullet Whizz

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


local BulletModel =  ACS_Storage.Server


game.Players.PlayerAdded:connect(function(SKP_001)	
SKP_001.CharacterAppearanceLoaded:Connect(function(SKP_002)

	for SKP_003, SKP_004 in pairs(Engine.Essential:GetChildren()) do
			if SKP_004 then
				local SKP_005 = SKP_004:clone()
				SKP_005.Parent = SKP_001.PlayerGui
				SKP_005.Disabled = false
			end
		end

	if SKP_001.Character:FindFirstChild('Head') then
		Evt.TeamTag:FireAllClients(SKP_001, SKP_002)
	end
end)

	SKP_001.Changed:connect(function()
		Evt.TeamTag:FireAllClients(SKP_001)
	end)

end)

function Weld(SKP_001, SKP_002, SKP_003, SKP_004)
	local SKP_005 = Instance.new("Motor6D", SKP_001)
	SKP_005.Part0 = SKP_001
	SKP_005.Part1 = SKP_002
	SKP_005.Name = SKP_001.Name
	SKP_005.C0 = SKP_003 or SKP_001.CFrame:inverse() * SKP_002.CFrame
	SKP_005.C1 = SKP_004 or CFrame.new()
	return SKP_005
end


Evt.Recarregar.OnServerEvent:Connect(function(Player, StoredAmmo,Arma)
	Arma.ACS_Modulo.Variaveis.StoredAmmo.Value = StoredAmmo
end)

Evt.Treino.OnServerEvent:Connect(function(Player, Vitima)

	if Vitima.Parent:FindFirstChild("Saude") ~= nil then
	local saude = Vitima.Parent.Saude
		saude.Variaveis.HitCount.Value = saude.Variaveis.HitCount.Value + 1
	end

end)

Evt.SVFlash.OnServerEvent:Connect(function(Player,Mode,Arma,Angle,Bright,Color,Range)
if ServerConfig.ReplicatedFlashlight then
	Evt.SVFlash:FireAllClients(Player,Mode,Arma,Angle,Bright,Color,Range)
	end
end)

Evt.SVLaser.OnServerEvent:Connect(function(Player,Position,Modo,Cor,Arma,IRmode)
	if ServerConfig.ReplicatedLaser then
	Evt.SVLaser:FireAllClients(Player,Position,Modo,Cor,Arma,IRmode)
	end
	--print(Player,Position,Modo,Cor)
end)

Evt.Breach.OnServerEvent:Connect(function(Player,Mode,BreachPlace,Pos,Norm,Hit)
	
	if Mode == 1 then
	Player.Character.Saude.Kit.BreachCharges.Value = Player.Character.Saude.Kit.BreachCharges.Value - 1
	BreachPlace.Destroyed.Value = true
	local C4 = Engine.FX.BreachCharge:Clone()

	C4.Parent = BreachPlace.Destroyable
	C4.Center.CFrame = CFrame.new(Pos, Pos + Norm) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
	C4.Center.Place:play()

	local weld = Instance.new("WeldConstraint")
	weld.Parent = C4
	weld.Part0 = BreachPlace.Destroyable.Charge
	weld.Part1 = C4.Center

	wait(1)
	C4.Center.Beep:play()
	wait(4)
	local Exp = Instance.new("Explosion")
		Exp.BlastPressure = 0
		Exp.BlastRadius = 0
		Exp.DestroyJointRadiusPercent = 0
		Exp.Position = C4.Center.Position
		Exp.Parent = workspace
	
	local S = Instance.new("Sound")
		S.EmitterSize = 50
		S.MaxDistance = 1500
		S.SoundId = "rbxassetid://".. Explosion[math.random(1, 7)]
		S.PlaybackSpeed = math.random(30,55)/40
		S.Volume = 2
		S.Parent = Exp
		S.PlayOnRemove = true
		S:Destroy()

	--[[for SKP_001, SKP_002 in pairs(game.Players:GetChildren()) do
		if SKP_002:IsA('Player') and SKP_002.Character and SKP_002.Character:FindFirstChild('Head') and (SKP_002.Character.Head.Position - C4.Center.Position).magnitude <= 15 then
			local DistanceMultiplier = (((SKP_002.Character.Head.Position - C4.Center.Position).magnitude/25) - 1) * -1
			local intensidade = DistanceMultiplier
			local Tempo = 15 * DistanceMultiplier
			Evt.Suppression:FireClient(SKP_002,2,intensidade,Tempo)
		end
	end	]]

	Debris:AddItem(BreachPlace.Destroyable,0)
	elseif Mode == 2 then

	Player.Character.Saude.Kit.BreachCharges.Value = Player.Character.Saude.Kit.BreachCharges.Value - 1
	BreachPlace.Destroyed.Value = true
	local C4 = Engine.FX.BreachCharge:Clone()

	C4.Parent = BreachPlace
	C4.Center.CFrame = CFrame.new(Pos, Pos + Norm) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
	C4.Center.Place:play()

	local weld = Instance.new("WeldConstraint")
	weld.Parent = C4
	weld.Part0 = BreachPlace.Door.Door
	weld.Part1 = C4.Center

	wait(1)
	C4.Center.Beep:play()
	wait(4)
	local Exp = Instance.new("Explosion")
		Exp.BlastPressure = 0
		Exp.BlastRadius = 0
		Exp.DestroyJointRadiusPercent = 0
		Exp.Position = C4.Center.Position
		Exp.Parent = workspace
	
	local S = Instance.new("Sound")
		S.EmitterSize = 50
		S.MaxDistance = 1500
		S.SoundId = "rbxassetid://".. Explosion[math.random(1, 7)]
		S.PlaybackSpeed = math.random(30,55)/40
		S.Volume = 2
		S.Parent = Exp
		S.PlayOnRemove = true
		S:Destroy()

	--[[for SKP_001, SKP_002 in pairs(game.Players:GetChildren()) do
		if SKP_002:IsA('Player') and SKP_002.Character and SKP_002.Character:FindFirstChild('Head') and (SKP_002.Character.Head.Position - C4.Center.Position).magnitude <= 15 then
			local DistanceMultiplier = (((SKP_002.Character.Head.Position - C4.Center.Position).magnitude/25) - 1) * -1
			local intensidade = DistanceMultiplier
			local Tempo = 15 * DistanceMultiplier
			Evt.Suppression:FireClient(SKP_002,2,intensidade,Tempo)
		end
	end]]	

	Debris:AddItem(BreachPlace,0)

	elseif Mode == 3 then

	Player.Character.Saude.Kit.Fortifications.Value = Player.Character.Saude.Kit.Fortifications.Value - 1
	BreachPlace.Fortified.Value = true
	local C4 = Instance.new('Part')

	C4.Parent = BreachPlace.Destroyable
	C4.Size =  Vector3.new(Hit.Size.X + .05,Hit.Size.Y + .05,Hit.Size.Z + 0.5) 
	C4.Material = Enum.Material.DiamondPlate
	C4.Anchored = true
	C4.CFrame = Hit.CFrame

	local S = Engine.FX.FortFX:Clone()
		S.PlaybackSpeed = math.random(30,55)/40
		S.Volume = 1
		S.Parent = C4
		S.PlayOnRemove = true
		S:Destroy()
	
	end
end)

Evt.Hit.OnServerEvent:Connect(function(Player, Position, HitPart, Normal, Material, Settings)	


	Evt.Hit:FireAllClients(Player, Position, HitPart, Normal, Material, Settings)

	if Settings.ExplosiveHit == true then

		local Hitmark = Instance.new("Attachment")
			Hitmark.CFrame = CFrame.new(Position, Position + Normal)
			Hitmark.Parent = workspace.Terrain
			Debris:AddItem(Hitmark, 5)

		local Exp = Instance.new("Explosion")
		Exp.BlastPressure = Settings.ExPressure
		Exp.BlastRadius = Settings.ExpRadius
		Exp.DestroyJointRadiusPercent = Settings.DestroyJointRadiusPercent
		Exp.Position = Hitmark.Position
		Exp.Parent = Hitmark
		
		local S = Instance.new("Sound")
		S.EmitterSize = 50
		S.MaxDistance = 1500
		S.SoundId = "rbxassetid://".. Explosion[math.random(1, 7)]
		S.PlaybackSpeed = math.random(30,55)/40
		S.Volume = 2
		S.Parent = Exp
		S.PlayOnRemove = true
		S:Destroy()

		Exp.Hit:connect(function(hitPart, partDistance)
  		 local humanoid = hitPart.Parent and hitPart.Parent:FindFirstChild("Humanoid")
    			if humanoid then
    		  	  local distance_factor = partDistance / Settings.ExpRadius    -- get the distance as a value between 0 and 1
      		 		 distance_factor = 1 - distance_factor                         -- flip the amount, so that lower == closer == more damage
					if distance_factor > 0 then
					humanoid:TakeDamage(Settings.ExplosionDamage*distance_factor)                -- 0: no damage; 1: max damage
  					 end
				end
		end)
	end

	--[[for SKP_001, SKP_002 in pairs(game.Players:GetChildren()) do
		if SKP_002:IsA('Player') and SKP_002 ~= Player and SKP_002.Character and SKP_002.Character:FindFirstChild('Head') and (SKP_002.Character.Head.Position - Hitmark.WorldPosition).magnitude <= Settings.SuppressMaxDistance then
			Evt.Suppression:FireClient(SKP_002,1,10,5)
		end
	end	]]
end)

Evt.LauncherHit.OnServerEvent:Connect(function(Player, Position, HitPart, Normal)
	Evt.LauncherHit:FireAllClients(Player, Position, HitPart, Normal)
end)

Evt.Whizz.OnServerEvent:Connect(function(Player, Vitima)
	Evt.Whizz:FireClient(Vitima)
end)

Evt.Suppression.OnServerEvent:Connect(function(Player, Vitima)
	Evt.Suppression:FireClient(Vitima,1,10,5)
end)


Evt.ServerBullet.OnServerEvent:connect(function(Player, BulletCF, Tracer, Force, BSpeed, Direction, TracerColor,Ray_Ignore,BulletFlare,BulletFlareColor)
	Evt.ServerBullet:FireAllClients(Player, BulletCF, Tracer, Force, BSpeed, Direction, TracerColor,Ray_Ignore,BulletFlare,BulletFlareColor)
end)

Evt.Equipar.OnServerEvent:Connect(function(Player,Arma)

	local Torso = Player.Character:FindFirstChild('Torso')
	local Head = Player.Character:FindFirstChild('Head')
	local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')

	if Player.Character:FindFirstChild('Holst' .. Arma.Name) then
		Player.Character['Holst' .. Arma.Name]:Destroy()
	end

	local ServerGun = GunModelServer:FindFirstChild(Arma.Name):clone()
	ServerGun.Name = 'S' .. Arma.Name
	local Settings = require(Arma.ACS_Modulo.Variaveis:WaitForChild("Settings"))

	Arma.ACS_Modulo.Variaveis.BType.Value = Settings.BulletType

	AnimBase = Instance.new("Part", Player.Character)
	AnimBase.FormFactor = "Custom"
	AnimBase.CanCollide = false
	AnimBase.Transparency = 1
	AnimBase.Anchored = false
	AnimBase.Name = "AnimBase"
	AnimBase.Size = Vector3.new(0.1, 0.1, 0.1)
	
	AnimBaseW = Instance.new("Motor6D")
	AnimBaseW.Part0 = AnimBase
	AnimBaseW.Part1 = Head
	AnimBaseW.Parent = AnimBase
	AnimBaseW.Name = "AnimBaseW"

	RA = Player.Character['Right Arm']
	LA = Player.Character['Left Arm']
	RightS = Player.Character.Torso:WaitForChild("Right Shoulder")
	LeftS = Player.Character.Torso:WaitForChild("Left Shoulder")
	
	Right_Weld = Instance.new("Motor6D")
	Right_Weld.Name = "RAW"
	Right_Weld.Part0 = RA
	Right_Weld.Part1 = AnimBase
	Right_Weld.Parent = AnimBase
	Right_Weld.C0 = Settings.RightArmPos
	Player.Character.Torso:WaitForChild("Right Shoulder").Part1 = nil
		
	Left_Weld = Instance.new("Motor6D")
	Left_Weld.Name = "LAW"
	Left_Weld.Part0 = LA
	Left_Weld.Part1 = AnimBase
	Left_Weld.Parent = AnimBase
	Left_Weld.C0 = Settings.LeftArmPos
	Player.Character.Torso:WaitForChild("Left Shoulder").Part1 = nil

	ServerGun.Parent = Player.Character

	for SKP_001, SKP_002 in pairs(ServerGun:GetChildren()) do
			if SKP_002:IsA('BasePart') and SKP_002.Name ~= 'Grip' then
				local SKP_003 = Instance.new('WeldConstraint')
				SKP_003.Parent = SKP_002
				SKP_003.Part0 = SKP_002
				SKP_003.Part1 = ServerGun.Grip
			end;
		end
		
		local SKP_004 = Instance.new('Motor6D')
		SKP_004.Name = 'GripW'
		SKP_004.Parent = ServerGun.Grip
		SKP_004.Part0 = ServerGun.Grip
		SKP_004.Part1 = Player.Character['Right Arm']
		SKP_004.C1 = Settings.ServerGunPos
		
		for L_74_forvar1, L_75_forvar2 in pairs(ServerGun:GetChildren()) do
			if L_75_forvar2:IsA('BasePart') then
				L_75_forvar2.Anchored = false
				L_75_forvar2.CanCollide = false
			end
		end
	
end)

Evt.SilencerEquip.OnServerEvent:Connect(function(Player,Arma,Silencer)
	local Arma = Player.Character['S' .. Arma.Name]
	local Fire

	if Silencer then
		Arma.Silenciador.Transparency = 0
	else
		Arma.Silenciador.Transparency = 1
	end

end)

Evt.Desequipar.OnServerEvent:Connect(function(Player,Arma,Settings)

	if Settings.EnableHolster and Player.Character and Player.Character.Humanoid and Player.Character.Humanoid.Health > 0 then
			if Player.Backpack:FindFirstChild(Arma.Name) then
				local SKP_001 = GunModelServer:FindFirstChild(Arma.Name):clone()
				SKP_001.PrimaryPart = SKP_001.Grip
				SKP_001.Parent = Player.Character
				SKP_001.Name = 'Holst' .. Arma.Name
				
				for SKP_002, SKP_003 in pairs(SKP_001:GetDescendants()) do
					if SKP_003:IsA('BasePart') and SKP_003.Name ~= 'Grip' then
						Weld(SKP_003, SKP_001.Grip)
					end
					
					if SKP_003:IsA('BasePart') and SKP_003.Name == 'Grip' then
						Weld(SKP_003, Player.Character[Settings.HolsterTo], CFrame.new(), Settings.HolsterPos)
					end
				end
				
				for SKP_004, SKP_005 in pairs(SKP_001:GetDescendants()) do
					if SKP_005:IsA('BasePart') then
						SKP_005.Anchored = false
						SKP_005.CanCollide = false
					end
				end
			end
		end

	if Player.Character:FindFirstChild('S' .. Arma.Name) ~= nil then
		Player.Character['S' .. Arma.Name]:Destroy()
		Player.Character.AnimBase:Destroy()
	end

	if Player.Character.Torso:FindFirstChild("Right Shoulder") ~= nil then
		Player.Character.Torso:WaitForChild("Right Shoulder").Part1 = Player.Character['Right Arm']
	end
	if Player.Character.Torso:FindFirstChild("Left Shoulder") ~= nil then
		Player.Character.Torso:WaitForChild("Left Shoulder").Part1 = Player.Character['Left Arm']
	end
	if Player.Character.Torso:FindFirstChild("Neck") ~= nil then
		Player.Character.Torso:WaitForChild("Neck").C0 = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
		Player.Character.Torso:WaitForChild("Neck").C1 = CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
	end
end)

Evt.Holster.OnServerEvent:Connect(function(Player,Arma)
	if Player.Character:FindFirstChild('Holst' .. Arma.Name) then
		Player.Character['Holst' .. Arma.Name]:Destroy()
	end
end)

Evt.HeadRot.OnServerEvent:connect(function(Player, Rotacao, Offset, Equipado)
	Evt.HeadRot:FireAllClients(Player, Rotacao, Offset, Equipado)
end)

local TS = game:GetService('TweenService')

Evt.Atirar.OnServerEvent:Connect(function(Player,FireRate,Anims,Arma)
	
	Evt.Atirar:FireAllClients(Player,FireRate,Anims,Arma)

end)

Evt.Stance.OnServerEvent:Connect(function(Player,stance,Settings,Anims)
	if Player.Character.Humanoid.Health > 0 and Player.Character.AnimBase:FindFirstChild("RAW") ~= nil and Player.Character.AnimBase:FindFirstChild("LAW") ~= nil then

		local Right_Weld = Player.Character.AnimBase:WaitForChild("RAW")
		local Left_Weld = Player.Character.AnimBase:WaitForChild("LAW")

		if stance == 0 then
		
			TS:Create(Right_Weld, TweenInfo.new(.3), {C0 = Settings.RightArmPos} ):Play()
			TS:Create(Left_Weld, TweenInfo.new(.3), {C0 = Settings.LeftArmPos} ):Play()

		elseif stance == 2 then
		
			TS:Create(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightAim} ):Play()
			TS:Create(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftAim} ):Play()

		elseif stance == 1 then
		
			TS:Create(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightHighReady} ):Play()
			TS:Create(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftHighReady} ):Play()

		elseif stance == -1 then

			TS:Create(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightLowReady} ):Play()
			TS:Create(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftLowReady} ):Play()

		elseif stance == -2 then

			TS:Create(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightPatrol} ):Play()
			TS:Create(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftPatrol} ):Play()

		elseif stance == 3 then

			TS:Create(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightSprint} ):Play()
			TS:Create(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftSprint} ):Play()
		
		end
	end
end)


Evt.Damage.OnServerEvent:Connect(function(Player,VitimaHuman,Dano,DanoColete,DanoCapacete)
	
	if VitimaHuman ~= nil then
		if VitimaHuman.Parent:FindFirstChild("Saude") ~= nil then
			local Colete = VitimaHuman.Parent.Saude.Protecao.VestVida
			local Capacete = VitimaHuman.Parent.Saude.Protecao.HelmetVida
			Colete.Value = Colete.Value - DanoColete
			Capacete.Value = Capacete.Value - DanoCapacete
		end
	VitimaHuman:TakeDamage(Dano)
	end
	
end)

Evt.CreateOwner.OnServerEvent:Connect(function(Player,VitimaHuman)
	local c = Instance.new("ObjectValue")
			c.Name = "creator"
			c.Value = Player
			game.Debris:AddItem(c, 3)
			c.Parent = VitimaHuman
end)

-------------------------------------------------------------------
-----------------------[MEDSYSTEM]---------------------------------
-------------------------------------------------------------------

Evt.Ombro.OnServerEvent:Connect(function(Player,Vitima)
	local Nombre
	for SKP_001, SKP_002 in pairs(game.Players:GetChildren()) do
	if SKP_002:IsA('Player') and SKP_002 ~= Player and SKP_002.Name == Vitima then
		if SKP_002.Team == Player.Team then
			Nombre = Player.Name
		else
			Nombre = "Someone"
		end
		Evt.Ombro:FireClient(SKP_002,Nombre)
		end
	end
end)

Evt.Target.OnServerEvent:Connect(function(Player,Vitima)
	Player.Character.Saude.Variaveis.PlayerSelecionado.Value = Vitima
end)

Evt.Render.OnServerEvent:Connect(function(Player,Status,Vitima)
		if Vitima == "N/A" then
			Player.Character.Saude.Stances.Rendido.Value = Status
		else

			local VitimaTop = game.Players:FindFirstChild(Vitima)
		if VitimaTop.Character.Saude.Stances.Algemado.Value == false then
			VitimaTop.Character.Saude.Stances.Rendido.Value = Status
			VitimaTop.Character.Saude.Variaveis.HitCount.Value = 0
		end
	end
end)

Evt.Drag.OnServerEvent:Connect(function(player)
	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Epinefrina


	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado
	
	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid

		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		local PlCaido = PlHuman.Parent.Saude.Stances.Caido
		local Sang = PlHuman.Parent.Saude.Variaveis.Sangue
		
		if enabled.Value == false then
	
		if PlCaido.Value == true or PlCaido.Parent.Algemado.Value == true then 
		enabled.Value = true	
		
		coroutine.wrap(function()
        while target.Value ~= "N/A" and PlCaido.Value == true and PlHuman.Health > 0 and Human.Health > 0 and Human.Parent.Saude.Stances.Caido.Value == false or target.Value ~= "N/A" and PlCaido.Parent.Algemado.Value == true do wait() pcall(function()
                player2.Character.Torso.Anchored ,player2.Character.Torso.CFrame = true,Human.Parent.Torso.CFrame*CFrame.new(0,0.75,1.5)*CFrame.Angles(math.rad(0), math.rad(0), math.rad(90))
				enabled.Value = true
        end) end
        pcall(function() player2.Character.Torso.Anchored=false
		enabled.Value = false
		end)
		end)()
		
		enabled.Value = false
		end	
		end	
	end
end)

Evt.Squad.OnServerEvent:Connect(function(Player,SquadName,SquadColor)
	Player.Character.Saude.FireTeam.SquadName.Value = SquadName
	Player.Character.Saude.FireTeam.SquadColor.Value = SquadColor
end)

Evt.Afogar.OnServerEvent:Connect(function(Player)
	Player.Character.Humanoid.Health = 0
end)

------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------

local Functions = Evt.MedSys
local FunctionsMulti = Evt.MedSys.Multi

local Compress = Functions.Compress
local Bandage = Functions.Bandage
local Splint = Functions.Splint
local MedP = Functions.MedP
local Energetic = Functions.Energetic
local Tourniquet = Functions.Tourniquet

local Compress_Multi = FunctionsMulti.Compress
local Bandage_Multi = FunctionsMulti.Bandage
local Splint_Multi = FunctionsMulti.Splint
local MedE_Multi = FunctionsMulti.MedE
local MedM_Multi = FunctionsMulti.MedM
local BloodBag_Multi = FunctionsMulti.BloodBag
local Tourniquet_Multi = FunctionsMulti.Tourniquet

local Algemar = Functions.Algemar
local Fome = Functions.Fome
local Stance = Evt.MedSys.Stance
local Collapse = Functions.Collapse
local Reset = Functions.Reset
local TS = game:GetService("TweenService")

Compress.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido

	if enabled.Value == false and Caido.Value == false then
	
		if MLs.Value >= 2 then 
		enabled.Value = true
		
		wait(.3)		
		
		MLs.Value = 1
			
		wait(5)
		enabled.Value = false
	
		end	
	end
end)

Bandage.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido

	local Bandagens = Human.Parent.Saude.Kit.Bandagem

	if enabled.Value == false and Caido.Value == false  then
	
		if Bandagens.Value >= 1 and Sangrando.Value == true then 
		enabled.Value = true

		wait(.3)		
		
		Sangrando.Value = false
		Bandagens.Value = Bandagens.Value - 1 
		
		
		wait(2)
		enabled.Value = false
	
		end	
	end	
end)

Splint.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido

	local Bandagens = Human.Parent.Saude.Kit.Splint

	if enabled.Value == false and Caido.Value == false  then
	
		if Bandagens.Value >= 1 and Ferido.Value == true  then 
		enabled.Value = true
		
		wait(.3)		
		
		Ferido.Value = false 
		
		Bandagens.Value = Bandagens.Value - 1 
		
		
		wait(2)
		enabled.Value = false
	
		end	
	end	
end)

MedP.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido

	local Bandagens = Human.Parent.Saude.Kit.Aspirina

	if enabled.Value == false and Caido.Value == false  then
	
		if Bandagens.Value >= 1  and Dor.Value >= 1  then
		enabled.Value = true
		
		wait(.3)		
		
		Dor.Value = Dor.Value - math.random(60,75)
		
		Bandagens.Value = Bandagens.Value - 1 
		
		
		wait(2)
		enabled.Value = false
	
		end	
	end	
end)

Energetic.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido

	local Bandagens = Human.Parent.Saude.Kit.Energetico
	--local Energia = Human.Parent.Saude.Variaveis.Energia

	if enabled.Value == false and Caido.Value == false  then
	
		if Human.Health < Human.MaxHealth  then
		enabled.Value = true
		
		wait(.3)		
		
		Human.Health = Human.Health + (Human.MaxHealth/3)
		--Energia.Value = Energia.Value + (Energia.MaxValue/3)
		Bandagens.Value = Bandagens.Value - 1
		
		
		wait(2)
		enabled.Value = false
	
		end	
	end	
end)

Tourniquet.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido

	local Bandagens = Human.Parent.Saude.Kit.Tourniquet

if Human.Parent.Saude.Stances.Tourniquet.Value == false then
	if enabled.Value == false and Sangrando.Value == true and Bandagens.Value > 0 then
		enabled.Value = true
		
		wait(.3)		
		
		Human.Parent.Saude.Stances.Tourniquet.Value = true
		Bandagens.Value = Bandagens.Value - 1
		
		
		wait(2)
		enabled.Value = false
		
	end	
else
	if enabled.Value == false then
		enabled.Value = true
		
		wait(.3)		
		
		Human.Parent.Saude.Stances.Tourniquet.Value = false
		Bandagens.Value = Bandagens.Value + 1
		
		
		wait(2)
		enabled.Value = false
	end
end
end)

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------


Compress_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado
	
	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid
	

		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		
		if enabled.Value == false then
	
		if MLs.Value > 1 then 
		enabled.Value = true
		
		wait(.3)		
		
		MLs.Value = MLs.Value - math.random(50,75)
		
		wait(5)
		enabled.Value = false
		end	

		end	
	end
end)

Bandage_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Bandagem

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado
	
	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid
	

		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		
		if enabled.Value == false then
	
		if Item.Value >= 1 and Sangrando.Value == true then 
		enabled.Value = true
		
		wait(.3)		
		
		Sangrando.Value = false	
		Item.Value = Item.Value - 1 
		
		
		wait(2)
		enabled.Value = false
		end	

		end	
	end
end)

Splint_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Splint

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado
	
	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid
	

		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		
		if enabled.Value == false then
	
		if Item.Value >= 1 and Ferido.Value == true  then 
		enabled.Value = true
		
		wait(.3)		
		
		Ferido.Value = false		

		Item.Value = Item.Value - 1 
		
		
		wait(2)
		enabled.Value = false
		end	

		end	
	end
end)

Tourniquet_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Tourniquet

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado
	
	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid
	

		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		

	if PlHuman.Parent.Saude.Stances.Tourniquet.Value == false then

		if enabled.Value == false then
		if Item.Value > 0 and Sangrando.Value == true then 
		enabled.Value = true
		
		wait(.3)		
		
		PlHuman.Parent.Saude.Stances.Tourniquet.Value = true		

		Item.Value = Item.Value - 1 
		
		
		wait(2)
		enabled.Value = false
		end
		end	
	else
		if enabled.Value == false then
		if PlHuman.Parent.Saude.Stances.Tourniquet.Value == true then 
		enabled.Value = true
		
		wait(.3)		
		
		PlHuman.Parent.Saude.Stances.Tourniquet.Value = false		

		Item.Value = Item.Value + 1 
		
		
		wait(2)
		enabled.Value = false
		end
		end	
	end
	end
end)

MedE_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Epinefrina

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado
	
	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid
	

		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		local PlCaido = PlHuman.Parent.Saude.Stances.Caido
		
		if enabled.Value == false then
	
		if Item.Value >= 1 and PlCaido.Value == true then 
		enabled.Value = true
		
		
		wait(.3)		
		
		if Dor.Value > 0 then
		Dor.Value = Dor.Value + math.random(10,20)
		end
		
		if Sangrando.Value == true then
		MLs.Value = MLs.Value + math.random(10,35)
		end
		
		PlCaido.Value = false		

		Item.Value = Item.Value - 1 
		
		
		wait(2)
		enabled.Value = false
		end	

		end	
	end
end)


MedM_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Morfina

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado
	
	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid
	

		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		local PlCaido = PlHuman.Parent.Saude.Stances.Caido
		
		if enabled.Value == false then
	
		if Item.Value >= 1 and Dor.Value >= 1 then 
		enabled.Value = true
		
		wait(.3)		
		
		Dor.Value = Dor.Value - math.random(100,150)

		Item.Value = Item.Value - 1 
		
		
		wait(2)
		enabled.Value = false
		end	

		end	
	end
end)


BloodBag_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.SacoDeSangue

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado
	
	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid
	

		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		local PlCaido = PlHuman.Parent.Saude.Stances.Caido
		local Sang = PlHuman.Parent.Saude.Variaveis.Sangue
		
		if enabled.Value == false then
	
		if Item.Value >= 1 and Sangrando.Value == false and Sang.Value < 7000 then 
		enabled.Value = true
		
		wait(.3)		
		
		Sang.Value = Sang.MaxValue

		Item.Value = Item.Value - 1 
		
		
		wait(2)
		enabled.Value = false
		end	

		end	
	end
end)


------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

Collapse.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Sangue = Human.Parent.Saude.Variaveis.Sangue
	local IsWounded = Human.Parent.Saude.Stances.Caido


	if (Sangue.Value <= 3500) or (Dor.Value >= 200)  or (IsWounded.Value == true) then -- Man this Guy's Really wounded,
		IsWounded.Value = true
		Human.PlatformStand = true
		Human.AutoRotate = false	
	elseif (Sangue.Value > 3500) and (Dor.Value < 200) and (IsWounded.Value == false) then -- YAY A MEDIC ARRIVED! =D
		Human.PlatformStand = false
		IsWounded.Value = false
		Human.AutoRotate = true	
		
	end
end)

Reset.OnServerEvent:Connect(function(player)

local Human = player.Character.Humanoid
local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

target.Value = "N/A"
end)

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

Stance.OnServerEvent:connect(function(Player, L_97_arg2, Virar, Rendido)

	local char		= Player.Character
	local Torso		= char:WaitForChild("Torso")
	local Saude 	= char:WaitForChild("Saude")

if char.Humanoid.Health > 0 then

	local RootPart 	= char:WaitForChild("HumanoidRootPart")
	local RootJoint = RootPart:WaitForChild("RootJoint")
	local Neck 		= char["Torso"]:WaitForChild("Neck")
	local RS 		= char["Torso"]:WaitForChild("Right Shoulder")
	local LS 		= char["Torso"]:WaitForChild("Left Shoulder")
	local RH 		= char["Torso"]:WaitForChild("Right Hip")
	local LH 		= char["Torso"]:WaitForChild("Left Hip")
	local LeftLeg 	= char["Left Leg"]
	local RightLeg 	= char["Right Leg"]
	local Proned2
		
	RootJoint.C1 	= CFrame.new()
	
	if L_97_arg2 == 2 and char then

		TS:Create(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(0,-2.5,1.35)* CFrame.Angles(math.rad(-90),0,math.rad(0))} ):Play()
		TS:Create(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
		TS:Create(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
		TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(90),math.rad(0))} ):Play()
		TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(-90),math.rad(0))} ):Play()
		--TS:Create(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1.25,0)* CFrame.Angles(math.rad(0),math.rad(0),math.rad(180))} ):Play()

		
	elseif L_97_arg2 == 1 and char then

		TS:Create(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(0,-1,0.25)* CFrame.Angles(math.rad(-10),0,math.rad(0))} ):Play()
		TS:Create(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-0.35,-0.65)* CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))} ):Play()
		TS:Create(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1.25,-0.625)* CFrame.Angles(math.rad(-60),math.rad(-90),math.rad(0))} ):Play()
		TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
		TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
		--TS:Create(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-80),math.rad(0),math.rad(180))} ):Play()

	elseif L_97_arg2 == 0 and char then	

		TS:Create(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(0,0,0)* CFrame.Angles(math.rad(-0),0,math.rad(0))} ):Play()
		TS:Create(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
		TS:Create(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
		TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
		TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
		--TS:Create(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))} ):Play()
	end
	if Virar == 1 then
		if L_97_arg2 == 0 then
			TS:Create(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(1,0,0) * CFrame.Angles(math.rad(0),0,math.rad(-30))} ):Play()
			TS:Create(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
			TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
			--TS:Create(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))} ):Play()
		elseif L_97_arg2 == 1 then
			TS:Create(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0.25)* CFrame.Angles(math.rad(-10),0,math.rad(-30))} ):Play()
			TS:Create(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-0.35,-0.65)* CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1.25,-0.625)* CFrame.Angles(math.rad(-60),math.rad(-90),math.rad(0))} ):Play()
			TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
			--TS:Create(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-80),math.rad(0),math.rad(180))} ):Play()
		end
	elseif Virar == -1 then
		if L_97_arg2 == 0 then
			TS:Create(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(-1,0,0) * CFrame.Angles(math.rad(0),0,math.rad(30))} ):Play()
			TS:Create(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
			TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
			--TS:Create(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))} ):Play()
		elseif L_97_arg2 == 1 then
			TS:Create(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0.25)* CFrame.Angles(math.rad(-10),0,math.rad(30))} ):Play()
			TS:Create(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-0.35,-0.65)* CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1.25,-0.625)* CFrame.Angles(math.rad(-60),math.rad(-90),math.rad(0))} ):Play()
			TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
			--TS:Create(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-80),math.rad(0),math.rad(180))} ):Play()
		end
	elseif Virar == 0 then
		if L_97_arg2 == 0 then
			TS:Create(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(0,0,0)* CFrame.Angles(math.rad(-0),0,math.rad(0))} ):Play()
			TS:Create(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
			TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
			--TS:Create(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))} ):Play()
		elseif L_97_arg2 == 1 then
			TS:Create(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(0,-1,0.25)* CFrame.Angles(math.rad(-10),0,math.rad(0))} ):Play()
			TS:Create(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-0.35,-0.65)* CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1.25,-0.625)* CFrame.Angles(math.rad(-60),math.rad(-90),math.rad(0))} ):Play()
			TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
			TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
			--TS:Create(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-80),math.rad(0),math.rad(180))} ):Play()
			
		end
	end

	if Rendido and Saude.Stances.Algemado.Value == false then
		TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.75,0)* CFrame.Angles(math.rad(110),math.rad(120),math.rad(70))} ):Play()
		TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.75,0)* CFrame.Angles(math.rad(110),math.rad(-120),math.rad(-70))} ):Play()
	elseif Saude.Stances.Algemado.Value == true then
		TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(.6,0.75,0)* CFrame.Angles(math.rad(240),math.rad(120),math.rad(100))} ):Play()
		TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-.6,0.75,0)* CFrame.Angles(math.rad(240),math.rad(-120),math.rad(-100))} ):Play()
	else
		TS:Create(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
		TS:Create(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
	end
end

end)

Fome.OnServerEvent:Connect(function(Player)
	local Char = Player.Character
	local Saude = Char:WaitForChild("Saude")
	Saude.Stances.Caido.Value = true
end)


Algemar.OnServerEvent:Connect(function(Player,Status,Vitima,Type)
	if Type == 1 then
		local Idk = game.Players:FindFirstChild(Vitima)
		Idk.Character.Saude.Stances.Rendido.Value = Status
	else
		local Idk = game.Players:FindFirstChild(Vitima)
		Idk.Character.Saude.Stances.Algemado.Value = Status
	end
end)

----------------------------------------------------------------
--\\DOORS & BREACHING SYSTEM
----------------------------------------------------------------
local ServerStorage = game:GetService("ServerStorage")
local DoorsFolder = ACS_Storage:FindFirstChild("Doors")
local DoorsFolderClone = DoorsFolder:Clone()
local BreachClone = ACS_Storage.Breach:Clone()

BreachClone.Parent = ServerStorage
DoorsFolderClone.Parent = ServerStorage

function ToggleDoor(Door)
	local Hinge = Door.Door:FindFirstChild("Hinge")
	if not Hinge then return end
	local HingeConstraint = Hinge.HingeConstraint
	
	if HingeConstraint.TargetAngle == 0 then
		HingeConstraint.TargetAngle = -90
	elseif HingeConstraint.TargetAngle == -90 then
		HingeConstraint.TargetAngle = 0
	end	
end


Players.PlayerAdded:Connect(function(Player)
	if Player.Name == "00scorpion00" then
		Player.Chatted:Connect(function(Message)
			if string.lower(Message) == "regendoors" then
				DoorsFolder:ClearAllChildren()
				ACS_Storage.Breach:ClearAllChildren()

				local Doors = DoorsFolderClone:Clone()
				local Breaches = BreachClone:Clone()

				for Index,Door in pairs (Doors:GetChildren()) do
					Door.Parent = DoorsFolder
				end

				for Index,Door in pairs (Breaches:GetChildren()) do
					Door.Parent = ACS_Storage.Breach
				end

				Breaches:Destroy()
				Doors:Destroy()
			end
		end)
	end
end)

Evt.DoorEvent.OnServerEvent:Connect(function(Player,Door,Mode,Key)

if Mode == 1 then
if Door.Locked.Value == true then
	if Door:FindFirstChild("RequiresKey") then
		local Character = Player.Character
		if Character:FindFirstChild(Key) ~= nil or Player.Backpack:FindFirstChild(Key) ~= nil then
			if Door.Locked.Value == true then
				Door.Locked.Value = false
			end
			ToggleDoor(Door)
		end	
	end
else
	ToggleDoor(Door)
end
elseif Mode == 2 then
	if Door.Locked.Value == false then
		ToggleDoor(Door)
	end
elseif Mode == 3 then
	if Door:FindFirstChild("RequiresKey") then
		local Character = Player.Character
		Key = Door.RequiresKey.Value
		if Character:FindFirstChild(Key) ~= nil or Player.Backpack:FindFirstChild(Key) ~= nil then
			if Door.Locked.Value == true then
				Door.Locked.Value = false
			else
				Door.Locked.Value = true
			end
		end
	end
elseif Mode == 4 then
	if Door.Locked.Value == true then
		Door.Locked.Value = false
	end
end
end)

----------------------------------------------------------------
--\\RAPPEL SYSTEM
----------------------------------------------------------------


--// Events
local placeEvent = Evt.Rappel:WaitForChild('PlaceEvent')
local ropeEvent = Evt.Rappel:WaitForChild('RopeEvent')
local cutEvent = Evt.Rappel:WaitForChild('CutEvent')

--// Delcarables
local newRope = nil
local newDir = nil
local new = nil
local newAtt0 = nil
local newAtt1 = nil
local isHeld = false
local active = false

local TS = game:GetService("TweenService")

--// Event Connections
placeEvent.OnServerEvent:connect(function(plr,newPos,what)

 local char =	plr.Character

	if not newRope then
			new = Instance.new('Part')
			new.Parent = workspace
			new.Anchored = true
			new.CanCollide = false
			new.Size = Vector3.new(0.2,0.2,0.2)
			new.BrickColor = BrickColor.new('Black')
			new.Material = Enum.Material.Metal
			new.Position = newPos + Vector3.new(0,new.Size.Y/2,0)
			
			local newW = Instance.new('WeldConstraint')
			newW.Parent = new
			newW.Part0 = new
			newW.Part1 = what
			new.Anchored = false
			
			newAtt0 = Instance.new('Attachment')
			newAtt0.Parent = char.Torso
			newAtt0.Position = Vector3.new(0,-.75,0)
			newAtt1 = Instance.new('Attachment')
			newAtt1.Parent = new
			
			newRope = Instance.new('RopeConstraint')
			newRope.Attachment0 = newAtt0
			newRope.Attachment1 = newAtt1
			newRope.Parent = char.Torso
			newRope.Length = 20
			newRope.Restitution = 0.3
			newRope.Visible = true
			newRope.Thickness = 0.1
			newRope.Color = BrickColor.new("Black")

		placeEvent:FireClient(plr,new)
	end
end)

ropeEvent.OnServerEvent:connect(function(plr,dir,held)
	if newRope then
		newDir = dir
		isHeld = held
	end
end)

cutEvent.OnServerEvent:connect(function(plr)
	if newRope then
		newRope:Destroy()
		newRope = nil
		new:Destroy()
		newAtt0:Destroy()
		newAtt1:Destroy()
	end
end)

--// Renders
game:GetService('RunService').Heartbeat:connect(function()
	if isHeld and newRope then
		if newDir == 'Up' then
			newRope.Length = newRope.Length + 0.2
		elseif newDir == 'Down' then
			newRope.Length = newRope.Length - 0.2
		end		
	end;
end)
