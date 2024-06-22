local char = script.Parent
local hum = char:WaitForChild("Humanoid")

hum.BreakJointsOnDeath = false

hum.Died:Connect(function()
	local joints = char:GetDescendants()
	for _,joint in pairs(joints) do
		if joint:isA("Motor6D") then
			local socket = Instance.new("BallSocketConstraint", joint.Parent)
			local a0 = Instance.new("Attachment")
			local a1 = Instance.new("Attachment")

			socket.Attachment0 = a0
			socket.Attachment1 = a1

			a0.Parent = joint.Part0
			a1.Parent = joint.Part1

			a0.CFrame = joint.C0
			a1.CFrame = joint.C1

			socket.LimitsEnabled = true
			socket.TwistLimitsEnabled = true

			joint:Destroy()
		end
	end
end)