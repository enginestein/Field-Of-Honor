local part = script.Parent.Parent.Head
local gib = game.Lighting:WaitForChild("headgib"):Clone()
local s = script.Parent.GibSound:Clone()

function weld(name, par, p0, p1)
	weld = Instance.new("WeldConstraint", par)
	weld.Name = name
	weld.Part0 = p0
	weld.Part1 = p1
	return weld
end


local newpart = part:Clone()
newpart.CanCollide = true
newpart.Locked = true
gib.Parent = part.Parent
gib:SetPrimaryPartCFrame(part.Parent.Torso.CFrame)
gib.Primary:Destroy()
weld("GibWeld", gib, part.Parent.Torso, gib.blood)
local velo = Instance.new("BodyVelocity")
velo.Parent = newpart
velo.Velocity = Vector3.new(0,5,0)
wait(0.2)
velo:Destroy()
part.Parent.Humanoid:TakeDamage(100)
s.Parent = newpart
s:Play()
newpart.Parent = game.Workspace.ignore
part:Destroy()
wait(s.TimeLength)
s:Destroy()
wait(1.9)
newpart:Destroy()