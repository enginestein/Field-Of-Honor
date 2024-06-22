local hum = script.Parent.Humanoid
local velo = Instance.new("BodyVelocity")
velo.Parent = hum.Parent.Torso
velo.Velocity = Vector3.new(0,10,0)
wait(0.3)
velo:Destroy()

script.Disabled = true