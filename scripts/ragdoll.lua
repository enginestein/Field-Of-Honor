-- Settings
local BreakHats = false -- If set to true, it will break the welds attaching hats.
	local IgnoreHair = false -- If set to true, Hair will be left alone in the BreakHats sequence
local CustomFace = 709804947 -- Set to false if you do not want a custom face, other wise put the ID of a decal/face here
local GlobalRagdoll = false -- Creates a ragdoll inside of a workspace folder, however causes several issues ( Ragdoll isn't quite in the same position as the player's death spot, Oof sound doesn't play, etc )
	local GR_Time = 5 -- How long the ragdoll stays in the folder before being destroyed.

-- Script
if script.Parent == workspace then script.Parent = game:GetService("StarterPlayer").StarterCharacterScripts end wait() -- Installs to StarterCharacterScripts
if script.Parent == game:GetService("StarterPlayer").StarterCharacterScripts then return end -- Onlys works in a character

wait()
local char = script.Parent
local humanoid = char:FindFirstChildOfClass("Humanoid") if humanoid.RigType == Enum.HumanoidRigType.R15 then warn("Ragdoll only compatable with R6") return end
local check = char:GetChildren()
local attachs = {Vector3.new(0,-0.5,0),Vector3.new(0,0.5,0),Vector3.new(0,0.5,0),Vector3.new(0,1,0),Vector3.new(0,1,0)}
local attcahT = {Vector3.new(0,1,0),Vector3.new(1.5,0.5,0),Vector3.new(-1.5,0.5,0),Vector3.new(0.5,-1,0),Vector3.new(-0.5,-1,0)}
if char:FindFirstChild("Head") == nil then return end
local parts = {Head=char.Head,RA=char["Right Arm"],LA=char["Left Arm"],RL=char["Right Leg"],LL=char["Left Leg"],HRP=char.HumanoidRootPart,Torso=char.Torso}
local partsC = {char.Head,char["Right Arm"],char["Left Arm"],char["Right Leg"],char["Left Leg"],char.HumanoidRootPart,char.Torso}
local rs = game:GetService("RunService")
local fol = nil

humanoid.BreakJointsOnDeath = false -- Cheesy workaround to hats.
humanoid.Died:Connect(function() -- Player has died
	check = script.Parent:GetChildren()
	parts.HRP.Anchored = true -- Gets the HumanoidRootPart
	parts.HRP.CanCollide = false -- Out of the way
	for i=1,#attachs do -- Create the attachments and constraints
		local bisj = Instance.new("BallSocketConstraint", parts.Torso)
		local att0 = Instance.new("Attachment")
		att0.Parent = parts.Torso
		local att1 = Instance.new("Attachment")
		att1.Parent = partsC[i]
		att1.Position = attachs[i]
		att0.Position = attcahT[i]
		bisj.Attachment0 = att0
		bisj.Attachment1 = att1
	end
	local m6 = parts.Torso:GetChildren() -- Destroy the existing joints
	for i=1,#m6 do
		if m6[i].ClassName == "Motor6D" then
			m6[i]:Destroy()
		end
	end
	local m6 = parts.HRP:GetChildren()
	for i=1,#m6 do
		if m6[i].ClassName == "Motor6D" then
			m6[i]:Destroy()
		end
	end
	
	if BreakHats and not GlobalRagdoll then -- Breaks the hat welds if BreakHats is set to true
		local headWelds = parts.Head:GetChildren() -- Check for welds in the head
		for i=1,#headWelds do
			if headWelds[i].ClassName == "Weld" then
				if headWelds[i].Part1:FindFirstChild("HairAttachment") == nil then
					headWelds[i].Part1.CanCollide = true
					headWelds[i].Part1.Size = Vector3.new(0.1,0.1,0.1)
					headWelds[i]:Destroy()
				else
					if not IgnoreHair then
						headWelds[i].Part1.CanCollide = true
						headWelds[i].Part1.Size = Vector3.new(0.1,0.1,0.1)
						headWelds[i]:Destroy()
					end
				end
			end
		end
		for i=1,#check do
			if check[i].ClassName == "Accessory" then
				if check[i].Handle:FindFirstChildOfClass("Weld") ~= nil then
					if check[i].Handle:FindFirstChild("HairAttachment") == nil or not IgnoreHair then
						check[i].Handle.CanCollide = true
						check[i].Handle.Size = Vector3.new(0.1,0.1,0.1)
						check[i].Handle:FindFirstChildOfClass("Weld"):Destroy()
					else
						if not IgnoreHair then
							check[i].Handle.CanCollide = true
							check[i].Handle.Size = Vector3.new(0.1,0.1,0.1)
							check[i].Handle:FindFirstChildOfClass("Weld"):Destroy()
						end
					end
				end
			end
		end
	end
	
	if GlobalRagdoll then
		wait()
		local vel = parts.Torso.Velocity
		local fol = Instance.new("Model", workspace)
		fol.Name = script.Parent.Name .. "RagdollStore"
		char.Archivable = true
		local clone = char:Clone()
		clone.Parent = fol
		if clone:FindFirstChildOfClass("Humanoid") ~= nil then clone:FindFirstChildOfClass("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
		script.Parent = fol
		if clone:FindFirstChild("Torso") == nil then wait(GR_Time) fol:Destroy() end
		if clone:FindFirstChildOfClass("ForceField") ~= nil then
			clone:FindFirstChildOfClass("ForceField"):Destroy()
		end
		for i=1,#check do
			if check[i].ClassName == "Part" then
				check[i]:Destroy()
			end
			if check[i].ClassName == "Script" then
				check[i]:Destroy()
			end
			if check[i].ClassName == "ForceField" then
				check[i]:Destroy()
			end
			if check[i].ClassName == "Humanoid" then
				check[i].DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			end
		end
		
		local Ccheck = clone:GetChildren()
		if BreakHats then -- Breaks the hat welds if BreakHats is set to true
			local headWelds = clone.Head:GetChildren() -- Check for welds in the head
			for i=1,#headWelds do
				if headWelds[i].ClassName == "Weld" then -- HairAttachment
					if headWelds[i].Part1:FindFirstChild("HairAttachment") == nil then
						headWelds[i].Part1.CanCollide = true
						headWelds[i].Part1.Size = Vector3.new(0.1,0.1,0.1)
						headWelds[i]:Destroy()
					else
						if not IgnoreHair then
							headWelds[i].Part1.CanCollide = true
							headWelds[i].Part1.Size = Vector3.new(0.1,0.1,0.1)
							headWelds[i]:Destroy()
						end
					end
				end
			end
			for i=1,#Ccheck do
				if Ccheck[i].ClassName == "Accessory" then
					if Ccheck[i].Handle:FindFirstChildOfClass("Weld") ~= nil then
						if Ccheck[i].Handle:FindFirstChild("HairAttachment") == nil then
							Ccheck[i].Handle.CanCollide = true
							Ccheck[i].Handle.Size = Vector3.new(0.1,0.1,0.1)
							Ccheck[i].Handle:FindFirstChildOfClass("Weld"):Destroy()
						else
							if not IgnoreHair then
								Ccheck[i].Handle.CanCollide = true
								Ccheck[i].Handle.Size = Vector3.new(0.1,0.1,0.1)
								Ccheck[i].Handle:FindFirstChildOfClass("Weld"):Destroy()
							end
						end
					end
				end
			end
		end
		
		if CustomFace ~= false then -- If a custom face exists, put it on the humanoid
			if clone.Head:FindFirstChildOfClass("Decal") ~= nil then
				if typeof(CustomFace) == "number" then
					clone.Head:FindFirstChildOfClass("Decal").Texture = "rbxassetid://" .. CustomFace
				end
			end
		end
		
		wait(GR_Time)
		if fol ~= nil then
			fol:Destroy()
		end
	end
	
	if CustomFace ~= false then -- If a custom face exists, put it on the humanoid
		if parts.Head:FindFirstChildOfClass("Decal") ~= nil then
			if typeof(CustomFace) == "number" then
				parts.Head:FindFirstChildOfClass("Decal").Texture = "rbxassetid://" .. CustomFace
			end
		end
	end
end)

rs.Heartbeat:Connect(function()
	if humanoid.Health < 1 then
		if parts.Torso:FindFirstChild("Neck") ~= nil then
			parts.Torso:FindFirstChild("Neck"):Destroy()
		end
	end
end)