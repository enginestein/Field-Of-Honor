Animation_ID = "rbxassetid://573789183" -- Replace this with the ID of your animation
Health_To_Animate_At = 50 -- The animation will play when the humanoid's health gets to this or lower
Sound_ID = "" -- If left blank, it will not play a sound.
Sound_Volume = 0.5 -- 0 is silent, 1 is highest volume
NPC_Immobilized = true -- Whether or not the NPC is still able to walk around during the animation
NPC_Mobilized_After_Animation = false -- This is whether or not the NPC can walk after the animation finishes
NPC_Dies = true -- If set to false, the NPC will not die after playing the animation
Anchor_On_Death = true -- Whether or not the body parts will be anchored in place after dying
Remove_Body_After_Death = true -- Whether or not to remove body after dying
Wait_Time_To_Remove_Body = 20 -- How long to wait before removing the body

--Put this script inside of the humanoid of the NPC that you want to use.

--IMPORTANT: The last keyframe of the death animation MUST be named "End". 
--You can name a keyframe in the animation editor by clicking the three dots above the keyframe and clicking rename.




local Animation = Instance.new("Animation")
Animation.Parent = script
Animation.AnimationId = Animation_ID
local animtrack = script.Parent:LoadAnimation(Animation)
local WalkSpeed = nil
animtrack.KeyframeReached:connect(function(keyframeName)
	if keyframeName == "End" or keyframeName == "end" then
		animtrack:Stop()
		if NPC_Dies == true then
			script.Parent.Health = 0
			if Anchor_On_Death == true then
				local Children = script.Parent.Parent:GetChildren()
				for i=1, #Children do
					if Children[i]:IsA("BasePart") then
						Children[i].Anchored = true
					end
				end
			end
			if Remove_Body_After_Death == true then
				wait(Wait_Time_To_Remove_Body)
				script.Parent.Parent:Destroy()
			end
		else
			script.Parent.WalkSpeed = WalkSpeed
		end
	end
end)
deb = false
function healthChanged()
	if deb == false and script.Parent.Health <= Health_To_Animate_At then
		deb = true
		if Sound_ID ~= "" then
			local DSound = Instance.new("Sound")
			DSound.Volume = Sound_Volume
			DSound.Parent = script.Parent.Parent.Head
			DSound:Play()
		end
		WalkSpeed = script.Parent.WalkSpeed
		animtrack:Play()
		if NPC_Immobilized == true then
			script.Parent.WalkSpeed = 0
		end
	end
end
script.Parent.HealthChanged:connect(healthChanged)