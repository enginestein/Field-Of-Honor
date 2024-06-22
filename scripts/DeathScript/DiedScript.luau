function Died(p)
		wait(.001)
	local tracks=script:GetChildren()
	local rn=math.random(1,#tracks)
	local track=tracks[rn]
	if track~=nil then
		track:play()
		wait(5)
		track:pause()
	end
end

function Hum(p) 
	hum = p:findFirstChild("Humanoid") 
	if hum ~= nil then 
		hum.Died:connect(function(hum) Died(p) end) 
	end 
end 

function Enter(p) 
	p.CharacterAdded:connect(Hum) 
end 
game.Players.PlayerAdded:connect(Enter)
