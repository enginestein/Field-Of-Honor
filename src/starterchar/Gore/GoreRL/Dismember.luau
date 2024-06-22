local part = script.Parent.Parent["Right Leg"]
local gib = game.Lighting:WaitForChild("r_leg_gib"):Clone()
local s = script.Parent.GibSound:Clone()

function weld(name, par, p0, p1)
	weld = Instance.new("WeldConstraint", par)
	weld.Name = name
	weld.Part0 = p0
	weld.Part1 = p1
	return weld
end


local newpart = part:Clone()
local mesh = game.Lighting.armmesh:Clone()
mesh.Parent = newpart
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
part.Parent.Humanoid:TakeDamage(25)
s.Parent = newpart
s:Play()
newpart.Parent = game.Workspace.ignore
part:Destroy()
wait(s.TimeLength)
s:Destroy()
wait(1.9)
newpart:Destroy()