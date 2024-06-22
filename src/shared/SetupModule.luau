return function(armModel,utilities,char,RA,RAW,LA,LAW,AnimBase,AnimBaseW,config,curGun)
	local raw
	local law
	local ra
	local la
	local Grip
	local GripW
	
			
		
		local shirt
		local armHum = Instance.new('Humanoid')
		armHum.Parent = armModel
		
		if char:FindFirstChild('Shirt') then
			shirt = armModel:FindFirstChild('Clothing') or Instance.new('Shirt')
			shirt.Parent = armModel
			shirt.ShirtTemplate = char.Shirt.ShirtTemplate
		end
		
		ra = char:WaitForChild('Right Arm'):clone()
		ra.FormFactor = "Custom"
		ra.Size = Vector3.new(0.6,2,0.6)
		
		la = char:WaitForChild('Left Arm'):clone()
		la.FormFactor = "Custom"
		la.Size = Vector3.new(0.6,2,0.6)
		
		for _,v in pairs(ra:GetChildren()) do
			if v then
				v:Destroy()
			end
		end;
		
		for _,v in pairs(la:GetChildren()) do
			if v then
				v:Destroy()
			end
		end;
		
		ra.Parent = armModel
		raw = Instance.new('Motor6D')
		raw.Name = 'RAW'
		raw.Parent = AnimBase
		raw.Part0 = AnimBase
		raw.Part1 = ra
		raw.C1 = config.RightPos
		
		la.Parent = armModel
		law = Instance.new('Motor6D')
		law.Name = 'LAW'
		law.Parent = AnimBase
		law.Part0 = AnimBase
		law.Part1 = la
		law.C1 = config.LeftPos
		
		Grip = curGun:WaitForChild('Handle')
		GripW = Instance.new('Motor6D')
		GripW.Name = 'GripW'
		GripW.Parent = Grip
		GripW.Part0 = ra
		GripW.Part1 = Grip
		Grip.Anchored = false
		GripW.C1 = config.GunPos

	return raw,law,ra,la,Grip,GripW
end