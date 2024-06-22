return function(char)

	local head = char:WaitForChild('Head')
	local leftarm = char["Left Arm"]
	local leftleg = char["Left Leg"]
	local rightleg = char["Right Leg"]
	local rightarm = char["Right Arm"]
	local torso = char.Torso

	local HeadA = Instance.new("Attachment")
	HeadA.Name = "HeadA"
	HeadA.Parent = head
	HeadA.Position = Vector3.new(0, -0.5, 0)
	HeadA.Rotation = Vector3.new(0, 0, -90)
	HeadA.Axis = Vector3.new(0, -1, 0)
	HeadA.SecondaryAxis = Vector3.new(1, 0, 0)
	
	local LeftArmA = Instance.new("Attachment")
	LeftArmA.Name = "LeftArmA"
	LeftArmA.Parent = leftarm
	LeftArmA.Position = Vector3.new(0.5, 0.6, 0)
	LeftArmA.Rotation = Vector3.new(0, 0, 0)
	LeftArmA.Axis = Vector3.new(1, 0, 0)
	LeftArmA.SecondaryAxis = Vector3.new(0, 1, 0)
	
	local LeftLegA = Instance.new("Attachment")
	LeftLegA.Name = "LeftLegA"
	LeftLegA.Parent = leftleg
	LeftLegA.Position = Vector3.new(0.1, 1, -0)
	LeftLegA.Rotation = Vector3.new(-0, -0, -90)
	LeftLegA.Axis = Vector3.new(-0, -1, 0)
	LeftLegA.SecondaryAxis = Vector3.new(1, 0, 0)
	
	local RightArmA = Instance.new("Attachment")
	RightArmA.Name = "RightArmA"
	RightArmA.Parent = rightarm
	RightArmA.Position = Vector3.new(-0.5, 0.6, 0)
	RightArmA.Rotation = Vector3.new(-180, 0, -180)
	RightArmA.Axis = Vector3.new(-1, 0, 0)
	RightArmA.SecondaryAxis = Vector3.new(0, 1, 0)
	
	local RightLegA = Instance.new("Attachment")
	RightLegA.Name = "RightLegA"
	RightLegA.Parent = rightleg
	RightLegA.Position = Vector3.new(-0.1, 1, 0)
	RightLegA.Rotation = Vector3.new(0, 0, -90)
	RightLegA.Axis = Vector3.new(-0, -1, -0)
	RightLegA.SecondaryAxis = Vector3.new(1, 0, -0)
	
	local TorsoA = Instance.new("Attachment")
	TorsoA.Name = "TorsoA"
	TorsoA.Parent = torso
	TorsoA.Position = Vector3.new(0.4, -1, 0)
	TorsoA.Rotation = Vector3.new(0, 0, -90)
	TorsoA.Axis = Vector3.new(0, -1, 0)
	TorsoA.SecondaryAxis = Vector3.new(1, 0, 0)
	
	local TorsoA1 = Instance.new("Attachment")
	TorsoA1.Name = "TorsoA1"
	TorsoA1.Parent = torso
	TorsoA1.Position = Vector3.new(-0.4, -1, 0)
	TorsoA1.Rotation = Vector3.new(0, 0, -90)
	TorsoA1.Axis = Vector3.new(0, -1, 0)
	TorsoA1.SecondaryAxis = Vector3.new(1, 0, 0)
	
	local TorsoA2 = Instance.new("Attachment")
	TorsoA2.Name = "TorsoA2"
	TorsoA2.Parent = torso
	TorsoA2.Position = Vector3.new(-1, 0.8, 0)
	TorsoA2.Rotation = Vector3.new(-0, 0, -0)
	TorsoA2.Axis = Vector3.new(1, -0, 0)
	TorsoA2.SecondaryAxis = Vector3.new(0, 1, -0)
	
	local TorsoA3 = Instance.new("Attachment")
	TorsoA3.Name = "TorsoA3"
	TorsoA3.Parent = torso
	TorsoA3.Position = Vector3.new(1, 0.8, 0)
	TorsoA3.Rotation = Vector3.new(180, 0, 180)
	TorsoA3.Axis = Vector3.new(-1, -0, 0)
	TorsoA3.SecondaryAxis = Vector3.new(-0, 1, -0)
	
	local TorsoA4 = Instance.new("Attachment")
	TorsoA4.Name = "TorsoA4"
	TorsoA4.Parent = torso
	TorsoA4.Position = Vector3.new(-0, 1, 0)
	TorsoA4.Rotation = Vector3.new(0, 0, -90)
	TorsoA4.Axis = Vector3.new(0, -1, 0)
	TorsoA4.SecondaryAxis = Vector3.new(1, 0, 0)


	local HA = Instance.new("BallSocketConstraint")
	HA.Parent = head
	HA.Attachment0 = HeadA
	HA.Attachment1 = TorsoA4
	HA.Enabled = true
	
	local LAT = Instance.new("BallSocketConstraint")
	LAT.Parent = leftarm
	LAT.Attachment0 = LeftArmA
	LAT.Attachment1 = TorsoA2
	LAT.Enabled = true
	
	local RAT = Instance.new("BallSocketConstraint")
	RAT.Parent = rightarm
	RAT.Attachment0 = RightArmA
	RAT.Attachment1 = TorsoA3
	RAT.Enabled = true
	
	local HA = Instance.new("BallSocketConstraint")
	HA.Parent = head
	HA.Attachment0 = HeadA
	HA.Attachment1 = TorsoA4
	HA.Enabled = true
	
	local TLL = Instance.new("BallSocketConstraint")
	TLL.Parent = torso
	TLL.Attachment0 = TorsoA1
	TLL.Attachment1 = LeftLegA
	TLL.Enabled = true
	
	local TRL = Instance.new("BallSocketConstraint")
	TRL.Parent = torso
	TRL.Attachment0 = TorsoA
	TRL.Attachment1 = RightLegA
	TRL.Enabled = true
	
	for i, v in pairs(char:GetDescendants()) do -- replace character with the character
   		if v:IsA("Motor6D") then
        	v:Destroy()
   		end
	end

	char.HumanoidRootPart:Destroy()
end
