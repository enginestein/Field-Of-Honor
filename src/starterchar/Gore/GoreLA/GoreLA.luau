local healths = script.Parent.LimbHealths
local rd = script.Parent.Rag
local dismem = script.Dismember
local char = script.Parent
local limb = char["Left Arm"]
local limbhealth = healths.LeftArm

limbhealth.Changed:Connect(function(value)
	if limbhealth.Value == 0 then
		dismem.Disabled = false
		rd.Disabled = false
	end
end)